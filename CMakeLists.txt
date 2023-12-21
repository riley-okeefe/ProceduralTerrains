cmake_minimum_required(VERSION 3.10)

project(ProceduralTerrains)

#--- Load the common configuration
include(common/config.cmake)

#--- Load third party packages
include(common/Eigen.cmake)
include(common/OpenCV.cmake)
include(common/OpenGP.cmake)

#--- OpenGL configuration
include(common/OpenGL.cmake)
include(common/GLEW.cmake)
include(common/GLFW.cmake)

#--- Subprojects
add_subdirectory(Mountains)


#--- C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)









