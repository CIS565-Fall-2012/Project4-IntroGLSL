#version 150

varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform float u_time;

void main(void)
{
	gl_FragColor = texture2D(u_image, v_Texcoords);
	float yDistortion = sin( float(int((v_Texcoords.y + u_time) * 10000) % 2129) / 2129.0) / 4.0;
	gl_FragColor += vec4(0, yDistortion, 0, 1.0);
	gl_FragColor.a = 1.0;
}