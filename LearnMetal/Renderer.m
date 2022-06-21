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
    
    vector_uint2 _viewportSize;
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView
{
    self = [super init];
    if(self)
    {
        _device = mtkView.device;
        printf("Your gpu is %s!\n", _device.name.UTF8String);
    }
    
    return self;
}

- (void)drawInMTKView:(nonnull MTKView *)view
{
    
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size
{
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}

@end
