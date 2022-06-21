//
//  ViewController.m
//  LearnMetal
//
//  Created by Asandei Stefan on 21.06.2022.
//

#import "ViewController.h"

@implementation ViewController
{
    MTKView* _view;
    
    Renderer* _renderer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _view = (MTKView*)self.view;
    _view.device = MTLCreateSystemDefaultDevice();
    NSAssert(_view.device, @"Metal is not supported on this gpu!");
    
    _renderer = [[Renderer alloc] initWithMetalKitView:_view];
    NSAssert(_renderer, @"Renderer failed initialization");
    
    [_renderer mtkView:_view drawableSizeWillChange:_view.drawableSize];
    
    _view.delegate = _renderer;
}

@end
