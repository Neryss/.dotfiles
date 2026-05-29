#version 300 es

precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;

out vec4 fragColor;
float m_8(vec2 pos) {
    /*const int M8[64] = float[](
         0, 32,  8, 40,  2, 34, 10, 42,
        48, 16, 56, 24, 50, 18, 58, 26,
        12, 44,  4, 36, 14, 46,  6, 38,
        60, 28, 52, 20, 62, 30, 54, 22,
         3, 35, 11, 43,  1, 33,  9, 41,
        51, 19, 59, 27, 49, 17, 57, 25,
        15, 47,  7, 39, 13, 45,  5, 37,
        63, 31, 55, 23, 61, 29, 53,  2
    );*/

    int i = int(abs(mod(pos.x, 8.0)));
    int j = int(abs(mod(pos.y, 8.0)));
    int v = j * 8 + i;

    int ret = 32;

    if (v == 000) ret =  0; if (v == 001) ret = 32; if (v == 002) ret =  8; if (v == 003) ret = 40;
    if (v == 004) ret =  2; if (v == 005) ret = 34; if (v == 006) ret = 10; if (v == 007) ret = 42;
    if (v == 010) ret = 48; if (v == 011) ret = 16; if (v == 012) ret = 56; if (v == 013) ret = 24;
    if (v == 014) ret = 50; if (v == 015) ret = 18; if (v == 016) ret = 58; if (v == 017) ret = 26;
    if (v == 020) ret = 12; if (v == 021) ret = 44; if (v == 022) ret =  4; if (v == 023) ret = 36;
    if (v == 024) ret = 14; if (v == 025) ret = 46; if (v == 026) ret =  6; if (v == 027) ret = 38;
    if (v == 030) ret = 60; if (v == 031) ret = 28; if (v == 032) ret = 52; if (v == 033) ret = 20;
    if (v == 034) ret = 62; if (v == 035) ret = 30; if (v == 036) ret = 54; if (v == 037) ret = 22;
    if (v == 040) ret =  3; if (v == 041) ret = 35; if (v == 042) ret = 11; if (v == 043) ret = 43;
    if (v == 044) ret =  1; if (v == 045) ret = 33; if (v == 046) ret =  9; if (v == 047) ret = 41;
    if (v == 050) ret = 51; if (v == 051) ret = 19; if (v == 052) ret = 59; if (v == 053) ret = 27;
    if (v == 054) ret = 49; if (v == 055) ret = 17; if (v == 056) ret = 57; if (v == 057) ret = 25;
    if (v == 060) ret = 15; if (v == 061) ret = 47; if (v == 062) ret =  7; if (v == 063) ret = 39;
    if (v == 064) ret = 13; if (v == 065) ret = 45; if (v == 066) ret =  5; if (v == 067) ret = 37;
    if (v == 070) ret = 63; if (v == 071) ret = 31; if (v == 072) ret = 55; if (v == 073) ret = 23;
    if (v == 074) ret = 61; if (v == 075) ret = 29; if (v == 076) ret = 53; if (v == 077) ret =  2;

    return float(ret) / 64.;
}

float m_4(vec2 pos) {
    int i = int(abs(mod(pos.x, 4.0)));
    int j = int(abs(mod(pos.y, 4.0)));
    int v = j * 4 + i;

    int ret = 8;

    if (v == 000) ret =  0; if (v == 001) ret =  8; if (v == 002) ret =  2; if (v == 003) ret = 10;
    if (v == 004) ret = 12; if (v == 005) ret =  4; if (v == 006) ret = 14; if (v == 007) ret =  6;
    if (v == 010) ret =  3; if (v == 011) ret = 11; if (v == 012) ret =  1; if (v == 013) ret =  9;
    if (v == 014) ret = 15; if (v == 015) ret =  7; if (v == 016) ret = 13; if (v == 017) ret =  5;

    return float(ret) / 16.;
}

float m_2(vec2 pos) {
    int i = int(abs(mod(pos.x, 2.0)));
    int j = int(abs(mod(pos.y, 2.0)));
    int v = j * 2 + i;

    int ret = 2;

    if (v == 000) ret =  0; if (v == 001) ret = 2;
    if (v == 002) ret =  3; if (v == 003) ret = 1;

    return float(ret) / 4.;
}

// used the formula that's over at https://en.wikipedia.org/wiki/Ordered_dithering
float transform(float channel) {
    vec2 tex_dims = vec2(1920., 1080.);

    int n_bits = 3;
    int shift_divisor = 32; // 1 << (8 - n_bits)

    float m = m_8(v_texcoord * tex_dims);
    float r = 1. / float(n_bits);

    float pre_nearest = channel + r * (m - 0.5);
    float nearest = float(int(pre_nearest * 255.) / shift_divisor * shift_divisor) / 255.;

    return nearest;
}

void main() {
    vec4 texture_sample = texture2D(tex, v_texcoord);

    vec3 rgb = texture_sample.rgb;
    vec3 rgb_prime = vec3(
      transform(rgb.r),
      transform(rgb.g),
      transform(rgb.b)
    );

    fragColor = vec4(rgb_prime, texture_sample.a);
}

