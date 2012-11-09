varying vec2 v_Texcoords;

uniform sampler2D u_image;

// Algorithm reference: http://wtomandev.blogspot.com/2010/01/pixelize-effect.html
const vec2 dimensions = vec2(80.0, 60.0);
const vec2 size = vec2(1.0, 1.0) / dimensions;

void main(void)
{
	vec2 pixel_base = vec2(0.0);
	pixel_base.s = v_Texcoords.s - mod(v_Texcoords.s, size.s);
	pixel_base.t = v_Texcoords.t - mod(v_Texcoords.t, size.t);

	pixel_base += 0.5 * size;

	gl_FragColor = texture2D(u_image, pixel_base);
}
