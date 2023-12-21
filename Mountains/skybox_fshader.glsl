R"(
#version 330 core
out vec4 FragColor;

in vec3 texCoords;

uniform samplerCube skybox;

void main() {    
    
     vec4 skyColor = texture(skybox, texCoords); 
     FragColor = skyColor;
}
)"