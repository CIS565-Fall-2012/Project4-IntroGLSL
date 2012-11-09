varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 7; // Odd
const float offset = 0.4;
mat3 weight =mat3 (1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0)/16.0;

void main(void)
{
	    
    vec3 accum = vec3(0.0);

	for(int i =0; i<3 ;i++){

		for(int j =0; j<3 ;j++){
	
		    vec2 coord = vec2(v_Texcoords.s + ((float(i) ) *u_step.x  ), v_Texcoords.t + ((float(j) ) *u_step.y  ) );
			accum += texture2D(u_image, coord).rgb * weight[i][j];
		
		}
		
	}

//	gl_FragColor = (accum/16.0);
	gl_FragColor = vec4(accum, 1.0);


  
}
