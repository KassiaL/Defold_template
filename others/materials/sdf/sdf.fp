varying mediump vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;

const float treshold = .04;

void main()
{
	vec3 cc = texture2D(texture_sampler, var_texcoord0.xy).xxx;
	vec3 res2 = smoothstep(.5 - treshold, .5 + treshold, cc);
	lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
	gl_FragColor = vec4(res2, res2.r) * tint_pm;
}