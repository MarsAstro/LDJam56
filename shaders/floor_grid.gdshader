shader_type spatial;

uniform sampler2D grid_texture : filter_linear_mipmap_anisotropic;
varying vec3 world_position;

float inverseLerp(float v, float min_value, float max_value)
{
    return (v - min_value) / (max_value - min_value);
}

float remap(float v, float in_min, float in_max, float out_min, float out_max)
{
    float t = inverseLerp(v, in_min, in_max);
    return mix(out_min, out_max, t);
}

float hash(vec2 p)
{
    p = 50.0 * fract(p * 0.3183099 + vec2(0.71, 0.113));
    return -1.0 + 2.0 * fract(p.x * p.y * (p.x + p.y));
}

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	    // Grid
    float thick_lines = texture(grid_texture, world_position.xz * 0.1).x;
    float thin_lines = texture(grid_texture, world_position.xz).x;

    float grid_hash = hash(floor(world_position.xz));

    vec3 grid_color = mix(vec3(0.5 + remap(grid_hash, -1.0, 1.0, -0.2, 0.2)), vec3(0.0625), thin_lines);
    grid_color = mix(grid_color, vec3(0.00625), thick_lines);

	ALBEDO = vec3(grid_color);
}