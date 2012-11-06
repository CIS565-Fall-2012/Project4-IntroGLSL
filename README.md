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
This project requires any graphics card with support for a modern OpenGL pipeline. Any AMD, NVIDIA, or Intel card from the past few years should work fine, and every machine in the SIG Lab and Moore 100 is capable of running this project.

The first part of this project requires Visual Studio 2010 or newer, and the second part of this project requires a WebGL capable browser, such as the latest versions of Chrome, Firefox, or Safari.

-------------------------------------------------------------------------------
INTRODUCTION:
-------------------------------------------------------------------------------
In this project, you will get introduced to the world of GLSL in two parts: fragment shading, and vertex shading. The first part of this project is the Image Processor, and the second part of this project is a Wave Vertex Shader.

In the first part of this project, you will implement various image processing filters using GLSL fragment shaders by rendering a viewport-aligned fullscreen quad where each fragment corresponds to one texel in a texture that stores an image. As you can guess, these filters are embarassingly parallel, as each fragment can be processed in parallel. Although we apply filters to static images in this project, the same technique can be and is widely used in post-processing dynamic scenes.

In the second part of this project, you will implement a GLSL vertex shader as part of a WebGL demo. You will create a dynamic wave animation using code that runs entirely on the GPU; before vertex shading, dynamic vertex buffers could only be implemented on the CPU, and each frame would then be uploaded to the GPU. 

-------------------------------------------------------------------------------
CONTENTS:
-------------------------------------------------------------------------------
The Project4 root directory contains the following subdirectories:
	
* part1/ contains the base code for the Image Processing half of the assignment.
* part1/ImageProcessing contains a Visual Studio 2010 project for the Image Processor
* part1/shared32 contains libraries that are required to build and run the Image Processor
* part2/ contains the base code for the Wave Vertex Shader in the form of a .html file and several .js files

The Image Processor builds and runs like any other standard Visual Studio project. The Wave Vertex Shader does not require building and can be run by opening the .html file in the web browser of your choice, such as Chrome.

-------------------------------------------------------------------------------
PART 1 REQUIREMENTS:
-------------------------------------------------------------------------------
In Part 1, you are given code for:

* Reading and loading an image
* Code for passing a quad to OpenGL
* Passthrough fragment and vertex shaders that take in an input and output the exact original input
* An example box blur filter fragment shader

You are required to implement the following filters:

* Image negative
* Gaussian blur
* Grayscale
* Edge Detection
* Toon shading

You are also required to implement at least three of the following filters:

* Pixelate (http://wtomandev.blogspot.com/2010/01/pixelize-effect.html)
* CMYK conversion (http://en.wikipedia.org/wiki/CMYK_color_model)
* Gamma correction (http://en.wikipedia.org/wiki/Gamma_correction)
* Brightness (http://en.wikipedia.org/wiki/Brightness)
* Contrast (http://en.wikipedia.org/wiki/Contrast_(vision))
* Night vision (http://wtomandev.blogspot.com/2009/09/night-vision-effect.html)
* Open-ended: make up your own filter!

You will also have to bind each filter you write to a keyboard key, such that hitting that key will trigger the associated filter. In the base code, hitting "1" will turn off filtering and use the passthrough filter, and hitting "2" will switch to the example box blur filter.

For this project, the console window will show what shaders are loaded, and will report shader compile/link warnings and errors. The base code does not have any build or shader warnings or errors; neither should your code submission!

![Example console window](Project4-IntroGLSL/raw/master/readmeFiles/consoleExample.png)

IMPORTANT: You MAY NOT copy/paste code from other sources for any of your filters! If you choose to make your own filter(s), please document what they are, how they work, and how your implementation works.

-------------------------------------------------------------------------------
PART 1 WALKTHROUGH:
-------------------------------------------------------------------------------
**Image Negative**

Create a new fragment shader starting with `passthroughFS.glsl`, that performans an image negative when the user presses `3`. Compute the negative color as:

`vec3(1.0) - rgb`

![Example negative filter](Project4-IntroGLSL/raw/master/readmeFiles/negativeFilter.png)

**Gaussian Blur**

Create a new fragment shader starting with `boxBlurFS.glsl`, that performs a 3x3 Gaussian blur when the user presses `4`.  This is similar to the box blur, except we are using a smaller kernel (3x3 instead of 7x7), and instead of weighting each texel evenly, they are weighted using a 2D Gaussian function, making the blur more subtle:

`1/16 * [[1 2 1][2 4 2][1 2 1]]`

![Example gaussian filter](Project4-IntroGLSL/raw/master/readmeFiles/gaussianFilter.png)

**Grayscale**

Create a new fragment shader starting with `passthroughFS.glsl`, that displays the image in grayscale when the user presses `5`.  To create a grayscale filter, determine the luminance

`const vec3 W = vec3(0.2125, 0.7154, 0.0721);`

`float luminance = dot(rgb, W);`

Then set the output `r`, `g`, and `b` components to the lumiance.

![Example grayscale filter](Project4-IntroGLSL/raw/master/readmeFiles/grayscaleFilter.png)

**Edge Detection**

Build on both our Gaussian blur and Grayscale filters to create an edge detection filter when the user presses `6` using a horizontal and vertical sobel filter. Use two 3x3 kernels:

`Sobel-horizontal = [[-1 -2 -1][0 0 0][1 2 1]]`

`Sobel-vertical = [[-1 0 1][-2 0 2][-1 0 1]]`

Run the kernels on the luminance of each texel, instead of the `rgb` components used in the Gaussian blur. The result is two floating-point values, one from each kernel. Create a `vec2` from these values, and set the output `rgb` components to the vector’s length.

![Example edge filter](Project4-IntroGLSL/raw/master/readmeFiles/edgeFilter.png)

**Toon Shading**

Toon shading is part of non-photorealistic rendering (NPR). Instead of trying to produce a photorealistic image, the goal is to create an image with a certain artistic style. In this case, we will build on our edge detection filter to create a cartoon filter when the user presses `7`.

First, perform edge detection. If the length of the vector is above a threshold (you determine), then output black. Otherwise, quantize the texel’s color and output it. Use the following code to quantize:

`float quantize = // determine it`

`rgb *= quantize;`

`rgb += vec3(0.5);`

`ivec3 irgb = ivec3(rgb);`

`rgb = vec3(irgb) / quantize;`

![Example toon filter](Project4-IntroGLSL/raw/master/readmeFiles/toonFilter.png)

-------------------------------------------------------------------------------
PART 2 REQUIREMENTS:
-------------------------------------------------------------------------------
In Part 2, you are given code for:

* Drawing a VBO through WebGL
* Javascript code for interfacing with WebGL
* Functions for generating simplex noise

You are required to implement the following:

* A sin-wave based vertex shader:

![Example sin wave grid](Project4-IntroGLSL/raw/master/readmeFiles/sinWaveGrid.png)

* A simplex noise based vertex shader:

![Example simplex noise wave grid](Project4-IntroGLSL/raw/master/readmeFiles/oceanWave.png)

* One interesting vertex shader of your choice

-------------------------------------------------------------------------------
PART 2 WALKTHROUGH:
-------------------------------------------------------------------------------
**Sin Wave**

* For this assignment, you will need the latest version of either Chrome, Firefox, or Safari.
* Begin by opening index.html. You should see a flat grid of black and white lines on the xy plane:

![Example boring grid](Project4-IntroGLSL/raw/master/readmeFiles/emptyGrid.png)

* In this assignment, you will animate the grid in a wave-like pattern using a vertex shader, and determine each vertex’s color based on its height, as seen in the example in the requirements.
* The vertex and fragment shader are located in script tags in `index.html`.
* The JavaScript code that needs to be modified is located in `index.js`.
* Required shader code modifications:
	* Add a float uniform named u_time.
	* Modify the vertex’s height using the following code:

	`float s_contrib = sin(position.x*2.0*3.14159 + u_time);`

	`float t_contrib = cos(position.y*2.0*3.14159 + u_time);`

	`float height = s_contrib*t_contrib;`

	* Use the GLSL mix function to blend together two colors of your choice based on the vertex’s height. The lowest possible height should be assigned one color (for example, `vec3(1.0, 0.2, 0.0)`) and the maximum height should be another (`vec3(0.0, 0.8, 1.0)`). Use a varying variable to pass the color to the fragment shader, where you will assign it `gl_FragColor`.

* Required JavaScript code modifications:
	* A floating-point time value should be increased every animation step. Hint: the delta should be less than one.
	* To pass the time to the vertex shader as a uniform, first query the location of `u_time` using `context.getUniformLocation` in `initializeShader()`. Then, the uniform’s value can be set by calling `context.uniform1f` in `animate()`.

**Simplex Wave**

* Now that you have the sin wave working, create a new copy of `index.html`. Call it `index_simplex.html`, or something similar.
* Open up `simplex.vert`, which contains a compact GLSL simplex noise implementation, in a text editor. Copy and paste the functions included inside into your `index_simplex.html`'s vertex shader.
* Try changing s_contrib and t_contrib to use simplex noise instead of sin/cos functions with the following code:

	`vec2 simplexVec = vec2(u_time, position);`

        `float s_contrib = snoise(simplexVec);`

        `float t_contrib = snoise(vec2(s_contrib,u_time));`

**Wave Of Your Choice**

* Create another copy of `index.html`. Call it `index_custom.html`, or something similar.
* Implement your own interesting vertex shader! In your README.md with your submission, describe your custom vertex shader, what it does, and how it works.

-------------------------------------------------------------------------------
BLOG
-------------------------------------------------------------------------------
As mentioned in class, all students should have student blogs detailing progress on projects. If you already have a blog, you can use it; otherwise, please create a blog using www.blogger.com or any other tool, such as www.wordpress.org. Blog posts on your project are due on the SAME DAY as the project, and should include:

* A brief description of the project and the specific features you implemented.
* A link to your github repo if the code is open source.
* At least one screenshot of your project running.
* A 30 second or longer video of your project running. To create the video, use http://www.microsoft.com/expression/products/Encoder4_Overview.aspx 

-------------------------------------------------------------------------------
THIRD PARTY CODE POLICY
-------------------------------------------------------------------------------
* Use of any third-party code must be approved by asking on Piazza.  If it is approved, all students are welcome to use it.  Generally, we approve use of third-party code that is not a core part of the project.  For example, for the ray tracer, we would approve using a third-party library for loading models, but would not approve copying and pasting a CUDA function for doing refraction.
* Third-party code must be credited in README.md.
* Using third-party code without its approval, including using another student's code, is an academic integrity violation, and will result in you receiving an F for the semester.

-------------------------------------------------------------------------------
SELF-GRADING
-------------------------------------------------------------------------------
* On the submission date, email your grade, on a scale of 0 to 100, to Karl, yiningli@seas.upenn.edu, with a one paragraph explanation.  Be concise and realistic.  Recall that we reserve 30 points as a sanity check to adjust your grade.  Your actual grade will be (0.7 * your grade) + (0.3 * our grade).  We hope to only use this in extreme cases when your grade does not realistically reflect your work - it is either too high or too low.  In most cases, we plan to give you the exact grade you suggest.
* Projects are not weighted evenly, e.g., Project 0 doesn't count as much as the path tracer.  We will determine the weighting at the end of the semester based on the size of each project.

-------------------------------------------------------------------------------
SUBMISSION
-------------------------------------------------------------------------------
As with the previous project, you should fork this project and work inside of your fork. Upon completion, commit your finished project back to your fork, and make a pull request to the master repository.
You should include a README.md file in the root directory detailing the following

* A brief description of the project and specific features you implemented
* At least one screenshot of your project running, and at least one screenshot of the final rendered output of your raytracer
* Instructions for building and running your project if they differ from the base code
* A link to your blog post detailing the project
* A list of all third-party code used