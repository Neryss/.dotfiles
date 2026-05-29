#version 300 es

precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;

uniform vec2 resolution;
out vec4 fragColor;

float bias = 0.7;

const mat4 b_matrix4 = mat4(
    0.0,  8.0,  2.0, 10.0,
    12.0, 4.0,  14.0, 6.0,
    3.0,  11.0, 1.0, 9.0,
    15.0, 7.0,  13.0, 5.0
) / 16.0;

vec3	orderedDither(vec2 uv, float lum)
{
	vec3	color = vec3(0.0);
	float	threshold = 0.0;
	int		x = int(uv.x * resolution.x) % 4;
	int		y = int(uv.y * resolution.y) % 4;

	threshold = b_matrix4[x][y];
	if (lum < threshold + bias)
		color = vec3(0.0);
	else
		color = vec3(1.0);
	return (color);
}

void	main()
{
	vec2	uv = v_texcoord;
	vec4	color = texture2D(tex, uv);

	float	lum = dot(vec3(0.2126, 0.7152, 0.0722), color.rgb);
	// float	lum = (0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b);
	color.rgb = orderedDither(uv, lum);

	fragColor = color;
}
