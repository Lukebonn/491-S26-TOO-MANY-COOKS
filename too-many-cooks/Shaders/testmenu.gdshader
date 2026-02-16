shader_type canvas_item;

uniform sampler2D noise_tex;
uniform sampler2D color_ramp;
uniform float speed = 0.1;

void fragment() {
    // Scroll noise over time
    vec2 scrolling_uv = UV + TIME * speed;
    
    // Sample noise (using red channel for grayscale)
    float n = texture(noise_tex, scrolling_uv).r;
    
    // Use the noise value to sample the color ramp
    vec3 color = texture(color_ramp, vec2(n, 0.0)).rgb;
    
    color;
}
