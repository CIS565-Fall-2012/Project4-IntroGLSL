varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	//vec2 tSize = vec2(textureSize2D(u_image, 1.0));
	vec2 tSize = vec2(1280, 720);
	vec2 pixelSize = vec2(6.0) / tSize.x;
	
	vec2 coord = vec2(pixelSize.x * floor(v_Texcoords.x / pixelSize.x), 
					  pixelSize.y * floor(v_Texcoords.y / pixelSize.y));
                   
	gl_FragColor = texture2D(u_image, coord);
}
