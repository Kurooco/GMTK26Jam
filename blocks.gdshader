shader_type canvas_item;

// https://www.youtube.com/watch?v=JvB4Uy5ERZk

void vertex() {
	UV = UV + vec2(.2, .2)*TIME;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
