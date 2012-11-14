#include <GL/glew.h>
#include <GL/glut.h>
#include <iostream>
#include "Utility.h"
#include "SOIL.h"

int width = 640;
int height = 480;
int frame = 0;

GLuint positionLocation = 0;
GLuint texcoordsLocation = 1;
const char *attributeLocations[] = { "Position", "Tex" };

GLuint passthroughProgram;
GLuint boxBlurProgram;
GLuint negativeProgram;
GLuint gaussProgram;
GLuint grayProgram;
GLuint sobelProgram;
GLuint toonProgram;
GLuint medianProgram;
GLuint hsvProgram;
GLuint pixelateProgram;

enum MENU_TYPE
{
        MENU_DEFAULT,
        MENU_BOX,
        MENU_NEGATIVE,
        MENU_GAUSS,
        MENU_GRAY,
        MENU_SOBEL,
        MENU_TOON,
        MENU_MEDIAN,
        MENU_HSV,
		MENU_PIXELATE
};

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

void menu(int item)
{
	switch( item )
	{
		case MENU_DEFAULT:
			glUseProgram(passthroughProgram);
			break;
		case MENU_BOX:
			glUseProgram(boxBlurProgram);
			break;
		case MENU_NEGATIVE:
			glUseProgram(negativeProgram);
			break;
		case MENU_GAUSS:
			glUseProgram(gaussProgram);
			break;
		case MENU_GRAY:
			glUseProgram(grayProgram);
			break;
		case MENU_SOBEL:
			glUseProgram(sobelProgram);
			break;
		case MENU_TOON:
			glUseProgram(toonProgram);
			break;
		case MENU_MEDIAN:
			glUseProgram(medianProgram);
			break;
		case MENU_HSV:
			glUseProgram(hsvProgram);
			break;
		case MENU_PIXELATE:
			glUseProgram(pixelateProgram);
			break;
	}
}

void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT);	
	GLint location;
	GLint id;
	
	glGetIntegerv(GL_CURRENT_PROGRAM, &id);

	if ((location = glGetUniformLocation(id, "u_frame")) != -1)
	{
		glUniform1i(location, frame++);
	}

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
           glUseProgram(gaussProgram);
		   break;
	   case '5':
           glUseProgram(grayProgram);
		   break;
	   case '6':
           glUseProgram(sobelProgram);
		   break;
	   case '7':
           glUseProgram(toonProgram);
		   break;
	   case '8':
           glUseProgram(medianProgram);
		   break;
	   case '9':
           glUseProgram(hsvProgram);
		   break;
	   case '0':
           glUseProgram(pixelateProgram);
		   break;
	   case 'q':
		   exit(0);
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
	gaussProgram = initShader("passthroughVS.glsl", "gaussFS.glsl");
	grayProgram = initShader("passthroughVS.glsl", "grayFS.glsl");
	sobelProgram = initShader("passthroughVS.glsl", "sobelFS.glsl");
	toonProgram = initShader("passthroughVS.glsl", "toonFS.glsl");
	medianProgram = initShader("passthroughVS.glsl", "medianFS.glsl");
	hsvProgram = initShader("passthroughVS.glsl", "hsvFS.glsl");
	pixelateProgram = initShader("passthroughVS.glsl", "pixelateFS.glsl");

	glutDisplayFunc(display);
	glutReshapeFunc(reshape);	
    glutKeyboardFunc(keyboard);

    glUseProgram(passthroughProgram);
    glActiveTexture(GL_TEXTURE0);

	glutCreateMenu(menu);

	glutAddMenuEntry("[1] Default", MENU_DEFAULT);
	glutAddMenuEntry("[2] 7X7 Box", MENU_BOX);
	glutAddMenuEntry("[3] Negative", MENU_NEGATIVE);
	glutAddMenuEntry("[4] 3x3 Gaussian", MENU_GAUSS);
	glutAddMenuEntry("[5] Grayscale", MENU_GRAY);
	glutAddMenuEntry("[6] Sobel", MENU_SOBEL);
	glutAddMenuEntry("[7] Toon", MENU_TOON);
	glutAddMenuEntry("[8] 5x5 Median", MENU_MEDIAN);
	glutAddMenuEntry("[9] Color Shift", MENU_HSV);
	glutAddMenuEntry("[0] Pixelate", MENU_PIXELATE);

	glutAttachMenu(GLUT_RIGHT_BUTTON);

	glutMainLoop();
	return 0;
}