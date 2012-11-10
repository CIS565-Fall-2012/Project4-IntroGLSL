varying vec2 v_Texcoords;

uniform sampler2D u_image;

const vec3 W=vec3(0.2125, 0.7154, 0.0721);
void main(void)
{
	gl_FragColor = vec4(vec3(dot(texture2D(u_image, v_Texcoords).rgb,W)),1.0);
}
