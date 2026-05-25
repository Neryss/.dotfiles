#version 300 es
precision highp float;

out vec4 fragColor;
in vec2 v_texcoord;
uniform sampler2D tex;
uniform vec2 resolution;
uniform float time;

vec2 wobble(vec2 uv, float amplitude, float frequence, float speed)
{
  float offset = amplitude*sin(uv.y*frequence+time*speed);
  return vec2(uv.x+offset,uv.y);	
}

void main()
{
	// vec2 uv = v_texcoord.xy / resolution.xy;
  vec2 uv = v_texcoord;
	float amplitude = 0.0100;
	float frequence = 25.00;
	float speed = 10.0;
	uv = wobble(uv,amplitude,frequence,speed);
	fragColor = texture2D(tex,uv);
}
