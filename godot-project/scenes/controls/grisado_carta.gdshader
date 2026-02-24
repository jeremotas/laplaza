shader_type canvas_item;

uniform bool grayscale = false;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    if (grayscale) {
        float avg = (color.r + color.g + color.b) / 3.0;
        COLOR = vec4(avg, avg, avg, color.a);
    } else {
        COLOR = color;
    }
}