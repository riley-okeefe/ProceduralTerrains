R"(
#version 330 core

out vec4 FragColor;
in vec4 clipSpaceCoordinates;
in vec2 uv;

uniform sampler2D reflectionTexture;
uniform sampler2D refractionTexture;
uniform sampler2D waterTexture;
uniform float time;


void main() {  

    // Use layered periodic signals to the displaced water texture.
    vec2 waterUV1 = uv + vec2(0.2 * (1 + sin(time/5)), 0.2 * (1 + sin(time/10)));
    vec2 waterUV2 = uv + vec2(0.1 * (1 + sin(time/2)), 0.1 * (1 + sin(time/5)));
    vec2 waterUV3 = uv + vec2(0.05 * (1 + sin(time)), 0.05 * (1 + sin(time/2)));
    vec4 waterColor = 0.5 * texture(waterTexture, waterUV1) + 0.3 * texture(waterTexture, waterUV2) + 0.2 * texture(waterTexture, waterUV3);

    // Normalised device coordinates to properly => we get the screen space coordinates Not the (nx, ny) one but the (-1, 1) ones
    vec2 ndc = clipSpaceCoordinates.xy/clipSpaceCoordinates.w;
    // Now we change the [-1, 1] coodinates to [0, 1] so that we can use it to sample the texture
    vec2 ndc_uv = ndc / 2.0 + 0.5;    
    
    // We invert the coordinates to sample for the reflection.  Need to change y as inverted (opengl coordinate system problems)
    vec2 reflectionUV = vec2(ndc_uv.x, 1.0-ndc_uv.y);
    //No need to change y  
    vec2 refractionUV = vec2(ndc_uv.x, ndc_uv.y); 

    vec4 reflectColor = texture(reflectionTexture, reflectionUV);    
    vec4 refractColor = texture(refractionTexture, refractionUV);

    // Blend reflection with refraction
    FragColor = mix(reflectColor, refractColor, /*0.3*/ 0.5); 
    //Blend the displaced water texture (based on the layered periodic coordinates)
    FragColor = mix(FragColor, waterColor, 0.3); 
    //Add a litle bluish color
    FragColor = mix(FragColor, vec4(0.0, 0.1, 0.3, 1.0), 0.2); 
}
)"