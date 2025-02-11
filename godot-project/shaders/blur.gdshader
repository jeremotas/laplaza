shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float amount: hint_range(0.0, 5.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = textureLod(screen_texture, SCREEN_UV, amount);// Called for every pixel the material 	is visible on.
	
	COLOR = color;
	
	COLOR.rgb = mix(vec3((COLOR.r + COLOR.g + COLOR.b) / 3.0),  vec3(0.299 * COLOR.r + 0.587 * COLOR.g + 0.114 * COLOR.b), 1.0);
	COLOR.rgb = mix(COLOR.rgb, vec3(0.25, 0.25, 0.4), 0.5);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
