#version 120
varying vec2 v_Texcoords;

uniform sampler2D u_image;

const float gamma=1.0/2.2;
const float divisor=1.0;

float gammaCorrection(float a){
 
 return clamp(pow(a/divisor,gamma),0.0,1.0);
}
void main(void)
{
    vec3 color=texture2D(u_image, v_Texcoords).rgb;

	gl_FragColor = vec4(gammaCorrection(color.r),gammaCorrection(color.g),gammaCorrection(color.b),1.0);
}
