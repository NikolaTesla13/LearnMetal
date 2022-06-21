//
//  Renderer.h
//  LearnMetal
//
//  Created by Asandei Stefan on 21.06.2022.
//

#import <Cocoa/Cocoa.h>
#include "ShaderTypes.h"

@import MetalKit;

@interface Renderer : NSObject <MTKViewDelegate>

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView;

@end

