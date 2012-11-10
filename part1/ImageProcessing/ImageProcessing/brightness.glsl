varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{	
	gl_FragColor =  vec4(vec3(clamp((texture2D(u_image, v_Texcoords).r*1.6),0.0,1.0),clamp((texture2D(u_image, v_Texcoords).g*1.6),0.0,1.0),clamp((texture2D(u_image, v_Texcoords).b*1.6),0.0,1.0)) ,1);
}