shader_type canvas_item;

uniform sampler2D texture_x: repeat_enable;

void fragment() {
	vec4 texture_color = texture(texture_x, UV);
	COLOR.rgb = texture_color.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
