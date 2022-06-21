//
//  ShaderTypes.h
//  LearnMetal
//
//  Created by Asandei Stefan on 21.06.2022.
//

#ifndef ShaderTypes_h
#define ShaderTypes_h

#include <simd/simd.h>

#define COUNT(arr) sizeof(arr) / sizeof(arr[0])

struct Vertex {
    vector_float4 color;
    vector_float3 position;
};

#endif /* ShaderTypes_h */
