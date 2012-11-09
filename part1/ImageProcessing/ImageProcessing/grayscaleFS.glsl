varying vec2 v_Texcoords;

uniform sampler2D u_image;

const vec3 W = vec3(0.2125, 0.7154, 0.0721);

void main(void)
{
	vec4 originColor = texture2D(u_image, v_Texcoords);
	float luminance = dot(originColor.rgb, W);
	gl_FragColor = vec4(luminance, luminance, luminance, originColor.a);
}
