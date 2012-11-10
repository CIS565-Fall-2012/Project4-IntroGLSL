varying vec2 v_Texcoords;

uniform sampler2D u_image;
float value=0.1;

void main(void)
{	
	vec3 contrast=vec3(0.0);
	contrast=(texture2D(u_image, v_Texcoords).rgb -vec3(0.5))*2.0 +0.5;
	//(texture2D(u_image, v_Texcoords).rgb=  (texture2D(u_image, v_Texcoords).rgb*(texture2D(u_image, v_Texcoords).rgb+valu
	gl_FragColor =  vec4(vec3(contrast),1);
}