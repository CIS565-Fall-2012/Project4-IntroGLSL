#version 120
varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
    vec3 color=vec3(1.0)-texture2D(u_image, v_Texcoords).rgb;
	vec4 finalColor=vec4(vec3(0.0),1.0);
	float K=min(color.r,min(color.g,color.b));
	if(abs(K-1.0)>0.001)
	    finalColor=vec4((color-vec3(K))/(1.0-K),K);
	gl_FragColor=finalColor;
}
