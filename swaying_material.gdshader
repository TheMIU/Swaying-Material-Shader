shader_type spatial;

// ----------- RENDER MODE SETTINGS -----------
render_mode blend_mix, depth_draw_opaque, cull_back;
// blend_mix       = enables alpha blending for transparency
// depth_draw_opaque = render depth normally (can tweak if using full transparency)
// cull_back       = backface culling enabled

// ----------- SWAY PARAMETERS -----------
uniform float sway_amount : hint_range(0.0, 1.0) = 0.1;
// Maximum sway offset

uniform float sway_scale : hint_range(0.0, 10.0) = 1.0;
// Controls how tightly sway oscillates over the mesh's Y axis

uniform float sway_duration : hint_range(0.01, 10.0) = 2.0;
// Time (in seconds) for one full sway cycle

uniform vec3 sway_direction = vec3(1.0, 0.0, 0.0);
// Direction of sway movement (X, Y, Z)

// ----------- MATERIAL PARAMETERS -----------
uniform vec4 albedo_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
// Base color of the material (includes alpha)

uniform float metallic : hint_range(0.0, 1.0) = 0.0;
// 0 = non-metal, 1 = full metal

uniform float roughness : hint_range(0.0, 1.0) = 1.0;
// 0 = smooth mirror, 1 = fully rough

uniform float specular : hint_range(0.0, 1.0) = 0.5;
// Strength of specular reflection for non-metallic surfaces

uniform float opacity : hint_range(0.0, 1.0) = 1.0;
// Controls transparency

// ----------- VERTEX FUNCTION -----------
void vertex() {
    // Calculate a normalized sway angle over time
    float sway_time = (TIME / sway_duration) * 6.28318; // 2π = full sine wave cycle

    // Calculate sway based on vertex height (Y)
    float sway = sin(VERTEX.y * sway_scale + sway_time) * sway_amount;

    // Apply sway in specified direction
    VERTEX.xyz += sway * sway_direction;
}

// ----------- FRAGMENT FUNCTION -----------
void fragment() {
    ALBEDO = albedo_color.rgb;
    METALLIC = metallic;
    ROUGHNESS = roughness;
    SPECULAR = specular;
    ALPHA = opacity;
}
