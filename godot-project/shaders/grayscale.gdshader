shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float amount: hint_range(0.0, 5.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 xy = UV;
	vec4 color = texture(TEXTURE, xy);
	
	float avg = (color.r + color.g + color.b) / 3.0;
	float factor = 8.0;
	COLOR = vec4(avg + color.r / factor, avg + color.g / factor, avg+ color.b  / factor, color.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
