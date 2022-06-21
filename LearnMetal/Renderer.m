//
//  Renderer.m
//  LearnMetal
//
//  Created by Asandei Stefan on 21.06.2022.
//

#import "Renderer.h"

@implementation Renderer
{
    id<MTLDevice> _device;
    id<MTLCommandQueue> _commandQueue;
    id<MTLRenderPipelineState> _pipelineState;
    id<MTLBuffer> _vertexBuffer;
    
    vector_uint2 _viewportSize;
}

// initialize the renderer
- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView
{
    self = [super init];
    if(self)
    {
        _device = mtkView.device;
        printf("Your gpu is %s\n", _device.name.UTF8String);
        
        _commandQueue = [_device newCommandQueue];
        
        [self buildRenderPipelineWith:mtkView];
        [self buildVertexBuffer];
    }
    
    return self;
}

// called on window resize
- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size
{
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}

// build the render pipeline
- (void)buildRenderPipelineWith:(nonnull MTKView *)view
{
    MTLRenderPipelineDescriptor* _pipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    NSError* error;
    
    id<MTLLibrary> _library = [_device newDefaultLibrary];
    id<MTLFunction> _vertexFunction = [_library newFunctionWithName:@"vertexShader"];
    id<MTLFunction> _fragmentFunction = [_library newFunctionWithName:@"fragmentShader"];
    
    _pipelineDescriptor.vertexFunction = _vertexFunction;
    _pipelineDescriptor.fragmentFunction = _fragmentFunction;
    _pipelineDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat;

    _pipelineState = [_device newRenderPipelineStateWithDescriptor:_pipelineDescriptor error: &error];
    
    NSAssert(_pipelineState, @"Failed to create pipeline state: %@", error);
}

// create the buffers needed to draw
- (void)buildVertexBuffer
{
    const vector_float4 color = {0, 0, 1, 1};
    const struct Vertex vertices[] =
    {
        {color, {-1, -1}},
        {color, {0, 1}},
        {color, {1, -1}},
    };
        
    _vertexBuffer = [_device newBufferWithBytes:(void*)vertices length:sizeof(struct Vertex)*COUNT(vertices) options:MTLResourceOptionCPUCacheModeDefault];
}

// main loop
- (void)drawInMTKView:(nonnull MTKView *)view
{
    id<MTLCommandBuffer> _commandBuffer = [_commandQueue commandBuffer];
    MTLRenderPassDescriptor* _renderPassDescriptor = view.currentRenderPassDescriptor;
    _renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 0, 1);
    
    if(_renderPassDescriptor != nil)
    {
        id<MTLRenderCommandEncoder> _renderEncoder =
        [_commandBuffer renderCommandEncoderWithDescriptor:_renderPassDescriptor];

        [_renderEncoder setViewport:(MTLViewport){0.0, 0.0,
            _viewportSize.x, _viewportSize.y, 0.0, 1.0 }];
        [_renderEncoder setRenderPipelineState:_pipelineState];
        [_renderEncoder setVertexBuffer:_vertexBuffer offset:0 atIndex:0];
        
        [_renderEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:3];
        
        [_renderEncoder endEncoding];

        [_commandBuffer presentDrawable:view.currentDrawable];
    }
    
    [_commandBuffer commit];
}

@end
