varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	vec4 originColor = texture2D(u_image, v_Texcoords);
	float brightness = (originColor.r + originColor.g + originColor.b) / 3.0;
	gl_FragColor = vec4(brightness, brightness, brightness, originColor.a);
}
