#version 300 es

precision mediump float;

in vec2 v_texcoord;
uniform sampler2D tex;
uniform float time;

uniform vec2 resolution;
out vec4 fragColor;


void main() {
	vec2 uv = v_texcoord;
	vec2 rev = vec2(uv.x, 1.0 - uv.y);
    vec4 pixel = texture2D(tex, rev);

    fragColor = pixel;
}
