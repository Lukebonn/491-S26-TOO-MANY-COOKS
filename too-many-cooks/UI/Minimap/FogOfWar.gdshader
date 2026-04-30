/*shader_type canvas_item;

uniform sampler2D fog_texture;

void fragment() {
    float revealed = texture(fog_texture, UV).r;
    float fog = 1.0 - revealed;
    COLOR = vec4(0.0, 0.0, 0.0, fog);
}
*/

shader_type canvas_item;

uniform sampler2D fog_texture;

void fragment() {
	float revealed = texture(fog_texture, UV).r;
	float fog = 1.0 - revealed;
	COLOR = vec4(0.0, 0.0, 0.0, fog);
}