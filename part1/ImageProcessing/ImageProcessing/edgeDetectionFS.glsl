varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 1.0;

void main(void)
{
    //vec3 accum = vec3(0.0);
	const vec3 W = vec3(0.2125, 0.7154, 0.0721);
	mat3 sobelH = mat3(vec3(-1,-2,-1),vec3(0,0,0),vec3(1,2,1));
	mat3 sobelV = mat3(vec3(-1,0,1),vec3(-2,0,2),vec3(-1,0,1));
	float luminanceH = 0.0;
	float luminanceV = 0.0;

	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coord = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			luminanceH += sobelH[i][j] * dot(texture2D(u_image, coord).rgb, W);
			luminanceV += sobelV[i][j] * dot(texture2D(u_image, coord).rgb, W);
		}
	}	

	vec2 edge = vec2(luminanceH, luminanceV); 
    float edgeIntensity = length(edge);
	gl_FragColor = vec4(vec3(edgeIntensity), 1.0);
}
