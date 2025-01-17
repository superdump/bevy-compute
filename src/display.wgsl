struct VertexOutput {
    [[location(0)]] uv: vec2<f32>;
    [[builtin(position)]] pos: vec4<f32>;
};

[[stage(vertex)]]
fn vs_main([[builtin(vertex_index)]] in_vertex_index: u32) -> VertexOutput {
    let x = f32((in_vertex_index & 1u) << 2u);
    let y = f32((in_vertex_index & 2u) << 1u);
    var out: VertexOutput;
    out.uv = vec2<f32>(x * 0.5, 1.0 - (y * 0.5));
    out.pos = vec4<f32>(x - 1.0, y - 1.0, 0.0, 1.0);
    return out;
}

[[group(0), binding(0)]]
var texture: [[access(read)]] texture_storage_2d<r32float>;

[[stage(fragment)]]
fn fs_main(in: VertexOutput) -> [[location(0)]] vec4<f32> {
    let dimensions = textureDimensions(texture);
    let pos = vec2<f32>(dimensions) * in.uv;
    let col = textureLoad(texture, vec2<i32>(pos)).r;
    return vec4<f32>(vec3<f32>(col), 1.0);
}