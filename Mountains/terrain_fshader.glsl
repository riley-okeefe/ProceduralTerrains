R"(
#version 330 core

uniform sampler2D grass;
uniform sampler2D rock;
uniform sampler2D sand;
uniform sampler2D snow;
uniform sampler2D lunar;

uniform vec3 viewPos;
uniform float waterHeight;
uniform vec3 skyColor;
uniform vec3 lightPos;

in vec2 uv;
in vec3 fragPos;
in float height;
in vec3 normal;
in float slope; 
in vec3 distanceFromCamera;

out vec4 color;


void main() {

    
    // colors for each of the textures
    vec4 sandCol = texture(sand, uv);
    vec4 rockCol = texture(rock, uv);
    vec4 grassCol = texture(grass, uv);
    vec4 snowCol = texture(snow, uv);
    vec4 lunarCol= texture(lunar, uv);
    vec4 col;

    // define terrain heights
    float sandHeight = 0.1f;
    float grassHeight = 0.3f;
    float rockHeight = 0.7f;
    float snowHeight = 1.0f;

    // half distance calculation for blending the textures
    float sgHalfDistance = (grassHeight - sandHeight) / 2.0; //half distance between sand and grass
    float grHalfDistance = (rockHeight - grassHeight) / 2.0; //half distance between rock and grass
    float rsHalfDistance = (snowHeight - rockHeight) / 2.0; //half distance between snow and rock
    float srHalfDistance = (rockHeight - snowHeight) / 2.0; //half distance between rock and snow
    
    // texturing based on height and slope
    if(height == snowHeight) {
        col = snowCol;
    } else if(height >= sandHeight && height < grassHeight) {
        if (height < (sandHeight + sgHalfDistance)) {
            // blending sand with grass
            float pos = height - sandHeight;
            float posScaled = clamp(pos / sgHalfDistance, 0.0, 1.0);
            col = (texture(sand, uv) * (1 - posScaled)) + (texture(grass, uv) * posScaled);
        } else {
            col = grassCol;
        }
    } else if(height >= grassHeight && height < rockHeight) {
        if (height < (grassHeight + grHalfDistance)) {
            // Blending grass with rock
            float pos = height - grassHeight;
            float posScaled = clamp(pos / grHalfDistance, 0.0, 1.0);
            col = (texture(grass, uv) * (1 - posScaled)) + (texture(rock, uv) * posScaled);
        } else {
            col = rockCol;
        }
    } else if(height >= rockHeight && height < snowHeight) {
        if (height < (rockHeight + rsHalfDistance)) {
            float pos = height - rockHeight;
            float posScaled = clamp(pos / rsHalfDistance, 0.0, 1.0); // Scale position between 0 and 1
            col = (texture(rock, uv) * (1 - posScaled)) + (texture(snow, uv) * posScaled);
        } else {
            col = snowCol;
        }
    } else if(height > snowHeight){
        // color the snow based on slope
        if(slope > 0.3) {
            float halfDistance = (height - snowHeight) / 2.0;
            float pos = height - snowHeight;
            float posScaled = clamp(pos / slope, 0.0, 1.0);
            col = (texture(snow, uv) * (1 - posScaled)) + (texture(rock, uv) * posScaled);      
        } else {
            float halfDistance = (height - snowHeight) / 2.0;
            float pos = height - snowHeight;
            float posScaled = clamp(pos / slope, 0.0, 1.0);
            col = (texture(snow, uv) * (1 - posScaled)) + (texture(rock, uv) * posScaled);
        }
    } else {
        col = sandCol;
    }


    // Blinn-Phong constants are placed here so we can update them at each level
    float ka = 0.2f, kd = 0.3f, ks = 0.7f, p = 0.8f;    
    
    // Blinn-Phong shading. Computing diffuse, specular and ambient components
    // Blinn-Phong calculation
    vec3 lightDir = normalize(lightPos - fragPos);
    float diffuse = kd * max(0, dot(normal, lightDir));

    vec3 viewDirection = viewPos - fragPos;
    vec3 halfVector = normalize(lightDir + viewDirection);
    float specular = ks * max(0, pow(dot(halfVector, lightDir), p));

    col = ka*vec4(1.0f, 1.0f, 1.0f, 1.0f) + diffuse*col + specular*col;

    color = vec4(col); //Comment this and uncomment the below code to render fog

    // visibility calculation. 
    //add fog so that we can hide 'render distance'  
    // we mix the color with the skycolor based on the distance from the camera
    // we use a visibility formula to detect how far an object is from the camera
    // 1 => render normaly, 0 => fade into the skycolor
    // visibility takes the distance from the camera and use an exponential decrease so that the fog scaling looks more natural
    // visibility = exp(-pow(distance * density, gradient)) is such a formula
    // density = thickness of the fog, higher value means less visiblr
    // gradient = how quickly the visibility decreases with distance
    
    /*float density = 0.1;
    float gradient = 1.5;
    float distance = length(distanceFromCamera.xyz);
    float visibility = exp(-pow(distance * density, gradient));
    visibility = clamp(visibility, 0.0, 1.0);
    color = mix(vec4(0.6f, 0.8f, 0.9f, 1.0f),  col, visibility);*/
    
}
)"