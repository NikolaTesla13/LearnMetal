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
    
    vector_uint2 _viewportSize;
    float red, delta;
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView
{
    self = [super init];
    if(self)
    {
        _device = mtkView.device;
        printf("Your gpu is %s\n", _device.name.UTF8String);
        
        _commandQueue = [_device newCommandQueue];
        
        red = 0.0f;
        delta = 0.01f;
    }
    
    return self;
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size
{
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}

- (void)drawInMTKView:(nonnull MTKView *)view
{
    red += delta;
    if(red > 1.0f || red < 0.0f) delta = -delta;
    
    id<MTLCommandBuffer> _commandBuffer = [_commandQueue commandBuffer];
    MTLRenderPassDescriptor* _renderPassDescriptor = view.currentRenderPassDescriptor;
    _renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(red, 0, 0, 1);
    
    if(_renderPassDescriptor != nil)
    {
        id<MTLRenderCommandEncoder> _renderEncoder =
        [_commandBuffer renderCommandEncoderWithDescriptor:_renderPassDescriptor];

        [_renderEncoder setViewport:(MTLViewport){0.0, 0.0,
            _viewportSize.x, _viewportSize.y, 0.0, 1.0 }];
        
        [_renderEncoder endEncoding];

        [_commandBuffer presentDrawable:view.currentDrawable];
    }
    
    [_commandBuffer commit];
}

@end
