varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const float offset = 3.0;

mat3 Sobel_horizontal = mat3(-1, -2, -1 ,0, 0, 0, 1, 2, 1);
mat3 Sobel_vertical=mat3(-1, 0, 1 ,-2 ,0, 2 ,-1, 0, 1);



void main(void)
{
	    
    float accum1 = 0.0;
	float accum2 = 0.0;
	

	for(int i =0; i<3 ;i++){

		for(int j =0; j<3 ;j++){
	
		    vec2 coord = vec2(v_Texcoords.s  + ((float(i) - offset ) *u_step.x  ), v_Texcoords.t + ((float(j) - offset) *u_step.y  ) );
			float luminance  = dot(texture2D(u_image, coord).rgb,  vec3(0.2125, 0.7154, 0.0721)); 
			accum1 += luminance * Sobel_horizontal[i][j];
			accum2 += luminance * Sobel_vertical[i][j];
		}
		
	}

	vec2 col = vec2(accum1, accum2);
	float len = length(col);

	if(len > 0.2){
		gl_FragColor = vec4(0.0,0.0,0.0,1.0);
	}else{
		float quantize = 30.5;// determine it
		vec3 rgb = texture2D(u_image, v_Texcoords).rgb;
		rgb *= quantize;

		rgb += vec3(0.5);

		ivec3 irgb = ivec3(rgb);

		rgb = vec3(irgb) / quantize;
		gl_FragColor = vec4(rgb,1.0);
	}

	
//	gl_FragColor = vec4(len,len,len,1.0);

}
