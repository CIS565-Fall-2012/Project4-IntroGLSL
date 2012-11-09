-------------------------------------------------------------------------------
CIS565: Project 4: Image Processing/Vertex Shading
-------------------------------------------------------------------------------
Fall 2012
-------------------------------------------------------------------------------
Due Friday 11/09/2012
-------------------------------------------------------------------------------
BLOG Link: http://seunghoon-cis565.blogspot.com/2012/11/project-4-image-processingvertex.html
-------------------------------------------------------------------------------
A brief description
-------------------------------------------------------------------------------
The goal of this project is to implement a couple of image processing algorithms and
wave effects by using GLSL(OpenGL Shading Language).


-------------------------------------------------------------------------------
PART 1: Image Processing
-------------------------------------------------------------------------------
- Basic
* Image negative
* Gaussian blur
* Grayscale
* Edge Detection
* Toon shading

- Additional
* Brightness

![Example brightness filter](Project4-IntroGLSL/raw/master/readmeFiles/brightness.png)

* Night Vision

![Example night vision filter](Project4-IntroGLSL/raw/master/readmeFiles/nightVision.png)

* Pixelization

![Example pixelization filter](Project4-IntroGLSL/raw/master/readmeFiles/pixelization.png)


-------------------------------------------------------------------------------
PART 2: Vertex Shading
-------------------------------------------------------------------------------
- Basic
* A sin-wave based vertex shader:
* A simplex noise based vertex shader:

- Additional
* A sin-wave varying on the radius from the center
![Example radial sine](Project4-IntroGLSL/raw/master/readmeFiles/radialSine.png)

-------------------------------------------------------------------------------
How to build
-------------------------------------------------------------------------------
I developed the part1 on Visual Studio 2010.
Its solution file is located in "part1/ImageProcessing/ImageProcessing.sln".
You should be able to build it without modification.

For part2, just open html files on the latest web browsers.