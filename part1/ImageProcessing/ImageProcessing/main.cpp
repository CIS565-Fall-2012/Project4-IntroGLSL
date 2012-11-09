#include <GL/glew.h>
#include <GL/glut.h>
#include <iostream>
#include "Utility.h"
#include "SOIL.h"

int width = 640;
int height = 480;

GLuint positionLocation = 0;
GLuint texcoordsLocation = 1;
const char *attributeLocations[] = { "Position", "Tex" };

GLuint passthroughProgram;
GLuint boxBlurProgram;
GLuint negativeProgram;
GLuint gaussBlurProgram;
GLuint grayscaleProgram;
GLuint sobelProgram;
GLuint toonShadingProgram;
GLuint brightnessProgram;
GLuint nightVisionProgram;
GLuint pixelizeProgram;

GLuint initShader(const char *vertexShaderPath, const char *fragmentShaderPath)
{
	GLuint program = Utility::createProgram(vertexShaderPath, fragmentShaderPath, attributeLocations, 2);
	GLint location;

	glUseProgram(program);
	
	if ((location = glGetUniformLocation(program, "u_image")) != -1)
	{
		glUniform1i(location, 0);
	}

	if ((location = glGetUniformLocation(program, "u_step")) != -1)
	{
		glUniform2f(location, 1.0f / (float)width, 1.0f / (float)height);
	}

	return program;
}

void initTextures()
{
	GLuint image = SOIL_load_OGL_texture("Valve.png", 3, 0, 0);
	glBindTexture(GL_TEXTURE_2D, image);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
}

void initVAO(void)
{
	GLfloat vertices[] =
	{ 
        -1.0f, -1.0f, 
         1.0f, -1.0f, 
         1.0f,  1.0f, 
        -1.0f,  1.0f, 
    };

	GLfloat texcoords[] = 
    { 
        1.0f, 1.0f,
        0.0f, 1.0f,
        0.0f, 0.0f,
        1.0f, 0.0f
    };

	GLushort indices[] = { 0, 1, 3, 3, 1, 2 };

	GLuint vao;
	glGenVertexArrays(1, &vao);
	glBindVertexArray(vao);

	GLuint vertexBufferObjID[3];
	glGenBuffers(3, vertexBufferObjID);
	
	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObjID[0]);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
	glVertexAttribPointer((GLuint)positionLocation, 2, GL_FLOAT, GL_FALSE, 0, 0); 
	glEnableVertexAttribArray(positionLocation);

	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObjID[1]);
	glBufferData(GL_ARRAY_BUFFER, sizeof(texcoords), texcoords, GL_STATIC_DRAW);
	glVertexAttribPointer((GLuint)texcoordsLocation, 2, GL_FLOAT, GL_FALSE, 0, 0);
	glEnableVertexAttribArray(texcoordsLocation);

	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vertexBufferObjID[2]);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
}

void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT);	

	// VAO, shader program, and texture already bound
	glDrawElements(GL_TRIANGLES, 6,  GL_UNSIGNED_SHORT, 0);

	glutPostRedisplay();
	glutSwapBuffers();
}

void keyboard(unsigned char key, int x, int y)
{
    switch (key) 
	{
	   case '1':
	       glUseProgram(passthroughProgram);
		   break;
	   case '2':
           glUseProgram(boxBlurProgram);
		   break;
	   case '3':
		   glUseProgram(negativeProgram);
		   break;
	   case '4':
		   glUseProgram(gaussBlurProgram);
		   break;
	   case '5':
		   glUseProgram(grayscaleProgram);
		   break;
	   case '6':
		   glUseProgram(sobelProgram);
		   break;
	   case '7':
		   glUseProgram(toonShadingProgram);
		   break;
	   case '8':
		   glUseProgram(brightnessProgram);
		   break;
	   case '9':
		   glUseProgram(nightVisionProgram);
		   break;
	   case '0':
		   glUseProgram(pixelizeProgram);
		   break;
	}
}

void reshape(int w, int h)
{
	glViewport(0, 0, (GLsizei)w, (GLsizei)h);
}

int main(int argc, char* argv[])
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA);
	glutInitWindowSize(width, height);
	glutCreateWindow("Image Processing");
	glewInit();
	GLenum err = glewInit();
	if (GLEW_OK != err)
	{
		/* Problem: glewInit failed, something is seriously wrong. */
		std::cout << "glewInit failed, aborting." << std::endl;
		exit (1);
	}
	std::cout << "Status: Using GLEW " << glewGetString(GLEW_VERSION) << std::endl;
	std::cout << "OpenGL version " << glGetString(GL_VERSION) << " supported" << std::endl;

	initVAO();
    initTextures();
	passthroughProgram = initShader("passthroughVS.glsl", "passthroughFS.glsl");
	boxBlurProgram = initShader("passthroughVS.glsl", "boxBlurFS.glsl");
	negativeProgram = initShader("passthroughVS.glsl", "negativeFS.glsl");
	gaussBlurProgram = initShader("passthroughVS.glsl", "gaussBlurFS.glsl");
	grayscaleProgram = initShader("passthroughVS.glsl", "grayscaleFS.glsl");
	sobelProgram = initShader("passthroughVS.glsl", "sobelFS.glsl");
	toonShadingProgram = initShader("passthroughVS.glsl", "toonShadingFS.glsl");
	brightnessProgram = initShader("passthroughVS.glsl", "brightnessFS.glsl");
	nightVisionProgram = initShader("passthroughVS.glsl", "nightVisionFS.glsl");
	pixelizeProgram = initShader("passthroughVS.glsl", "pixelizeFS.glsl");

	glutDisplayFunc(display);
	glutReshapeFunc(reshape);	
    glutKeyboardFunc(keyboard);

    glUseProgram(passthroughProgram);
    glActiveTexture(GL_TEXTURE0);

	glutMainLoop();
	return 0;
}