# Procedural-Terrains
Procedural terrain generation using fundamentals learned in a Computer Graphics course taken at Saint Mary's University and taught by Dr. Jiju Poovvancheri.
![Screenshot 2023-12-20 141846](https://github.com/riley-okeefe/Procedural-Terrains/assets/97004064/fa303340-455c-4501-8558-32e908fc7680)

This project uses fundamentals learned from class as well as external sources to generate procedural terrains using C++ and OpenGL. The project follows the core requirements of producing procedural terrains using the requirements for geometry, rendering, and animation along with implementing a few advanced features such as hybrid multifractal noise and infinite world generation.

## Geometry Requirements
Basic features implemented for the geometry portion of the requirements include the creation of a flat triangle mesh in Terrain.h making use of OpenGLs GL_TRIANGLE_STRIP and GL_PRIMITIVE_RESTART, generation of a heightmap using fractional Browian motion, and use of the height map to displace the grid vertices.
Advanced features include the use of alternate noise functions such as hybrid multifractal noise function, and a ‘warped fBm’ noise function along with the creation of an infinite world via noise generation on the GPU (Musgrave, n.d.).

## Rendering Requirements
Basic features implemented for the rendering portion of the requirements include calculation of the surface normals in the terrain vertex shader, the use of tile-able textures in terrain fragment shader along with texturing based on height and slope, and the implementation of a skybox texture using OpenGLs cubemap textures in Skybox.h.
Advanced features include use of normal map texture (water.png) to represent waves using a time dependent sine function in the water fragment shader and mirroring effect added to the water achieved by mirroring the camera position with respect to the water plane, rendering using a framebuffer, then placing the texture back in another step.

## Animation Requirements
Basic features for the animation portion of the requirements include implementation of forward, backward, left, right camera controls using the WASD keys and adjustment of the field of view and speed of the camera movement all achieved in Camera.h.

## Additional Comments
For this project I mostly used the materials provided to us through course notes, and from previous recitations, to be more specific recitations 7, 8, and 9 (Poovvancheri, 2023). One other additional source I used was the link provided in the assignment 2 section on the github wiki page, and this source was used to implement the algorithms for the different noise functions such as fractional Brownian Noise, hybrid multi fractal, and domain distorted fractional Browian noise or ‘warped fBm’ (Musgrave, n.d.). The picture provided on this report uses the ‘warped fBm’ noise function, but there is code in the terrain vertex shader to swap between the fBm, hybrid multi fractal, and ‘warped fBm’ noise functions, all that needs to be done is to comment and uncomment the code depending on what noise function you would like to use.

## References
- Musgrave F.K.(n.d.).Procedural Fractal Terrains: 2.3 procedural fbm.Retrieved from [source](https://www.classes.cs.uchicago.edu/archive/2015/fall/23700-1/final-project/MusgraveTerrain00.pdf)
- Musgrave F.K.(n.d.).Procedural Fractal Terrains: 2.4 heterogenous fbm.Retrieved from [source](https://www.classes.cs.uchicago.edu/archive/2015/fall/23700-1/final-project/MusgraveTerrain00.pdf)
- Musgrave F.K.(n.d.).Procedural Fractal Terrains: 2.5 warped terrains: domain distortion.Retrieved from [source](https://www.classes.cs.uchicago.edu/archive/2015/fall/23700-1/final-project/MusgraveTerrain00.pdf)
- Poovvancheri J.(2023).Introduction to computer graphics: OpenGL textures.
- Poovvancheri J.(2023).Introduction to computer graphics: frame buffer objects.
- Poovvancheri j.(2023).GraphicsLab: wiki: recitation 07 perlin noise. Retrieved from [source](https://github.com/jijup/GraphicsLab/wiki/Recitation-07-Perlin-Noise)
- Poovvancheri j.(2023).GraphicsLab: wiki: recitation 08 terrain and water(framebuffer). Retrieved from [source](https://github.com/jijup/GraphicsLab/wiki/Recitation-08-Terrain-and-Water(FrameBuffer))
- Poovvancheri j.(2023).GraphicsLab: wiki: recitation 09 mesh texturing. Retrieved from [source](https://github.com/jijup/GraphicsLab/wiki/Recitation-09-Mesh-Texturing)


