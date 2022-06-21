//
//  Shader.metal
//  LearnMetal
//
//  Created by Asandei Stefan on 21.06.2022.
//

#include <metal_stdlib>
#include "ShaderTypes.h"

using namespace metal;

struct VertexOut
{
    float4 color;
    float4 position [[position]];
};

vertex VertexOut vertexShader(const device struct Vertex *vertexArray [[buffer(0)]], unsigned int vid [[vertex_id]])
{
    VertexOut out;
    Vertex in = vertexArray[vid];
    
    out.position = float4(in.position.x, in.position.y, 0.0, 1.0);
    out.color = in.color;
    
    return out;
}

fragment float4 fragmentShader(VertexOut interpolated [[stage_in]])
{
    return interpolated.color;
}
