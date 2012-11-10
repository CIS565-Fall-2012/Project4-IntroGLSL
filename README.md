-------------------------------------------------------------------------------
CIS565: Project 4: Image Processing/Vertex Shading
-------------------------------------------------------------------------------
Fall 2012
-------------------------------------------------------------------------------
Due Friday 11/09/2012
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
NOTE:
-------------------------------------------------------------------------------
In this project I implemented some very simple fragment shaders.

I implemented:

    Image Negative
    3x3 Gaussian Blur
    Image Grayscale
    Sobel Edge Detector
    "Toon Shading"
    5x5 Median filter 
    HSV Color Shifter
    Pixelator
    5x5 Median:

A simple median filter with a 5x5 kernel. Nothing fancy, implemented with a simple loop to collect samples then another to sort.

HSV Color Shifter:

Transforms the image from RGB to HSV color space, replaces the hue channel with a time varying uniform then converts back to RGB for display.

Pixelator:

Straight forward pixeletor using a time varying uniform to make it interesting.

For ease of access on the c++ I added a glut context menu and keyboard commands to switch between shaders.

I also implemented some webGL vertex shaders:

    Sine Wave
    Simplex Noise
    Potential Functions

The potential functions use the sum of the inverse square distance from five points modulated by simplex noise as input to a sigmoid function to achieve a nice smooth rounded look.

Blogpost: http://liamboone.blogspot.com/2012/11/project-4-shaders.html