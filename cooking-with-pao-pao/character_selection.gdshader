shader_type canvas_item;

uniform float blur_size = 1.0;
uniform int blur_steps = 5;

void fragment() {
    vec2 tex_size = vec2(textureSize(TEXTURE, 0));
    vec2 uv = UV;
    vec4 col = vec4(0.0);
    float total = 0.0;

    for (int x = -blur_steps; x <= blur_steps; x++) {
        for (int y = -blur_steps; y <= blur_steps; y++) {
            vec2 offset = vec2(float(x), float(y)) * blur_size / tex_size;
            float weight = 1.0 - length(offset) * float(blur_steps);
            col += texture(TEXTURE, uv + offset) * weight;
            total += weight;
        }
    }

    COLOR = col / total;
}