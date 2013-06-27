//
//  NQFoldingUIView.m
//  foldingTest
//
//  Created by AhmedElnaqah on 4/6/13.
//  Copyright (c) 2013 elnaqah. All rights reserved.
//
//The MIT License (MIT)
//
//Copyright (c) 2013 ahmed elnaqah
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.


#import "NQFoldingUIView.h"
#import <QuartzCore/QuartzCore.h>

#define ANIMATION_DURATION 0.3

NQAxes NQAxesWith(float x,float y, float z)
{
    NQAxes axes;
    axes.x=x;
    axes.y=y;
    axes.z=z;
    return axes;
}

@interface NQFoldingUIView()
@property (strong) CALayer * topHalfLayer;
@property (strong) CALayer * bottomHalfLayer;
@property (strong) UIImage * image;
@property CGPoint midPoint;

/////
@property CATransform3D transformClosedTop;
@property CATransform3D transformClosedBottom;
@property CATransform3D transformOpenedTop;
@property CATransform3D transformOpenedBottom;

@property (nonatomic) BOOL flapped;
@end

@implementation NQFoldingUIView

- (id)initWithFrame:(CGRect)frame WithImage:(UIImage *) image WithType:(NQFoldingType) type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type=type;
        self.backgroundColor=[UIColor clearColor];
        self.image=image;
        [self awakeFromNib];
        [self initalizerForLayers];
        [self initalizeTransformations];
    }
    return self;
}

-(void)awakeFromNib
{
    //self.backgroundColor=[UIColor clearColor];
    
    self.userInteractionEnabled=YES;
    
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self addGestureRecognizer:gesture];
    //    [self.flayer startPosition];
}

-(void) initalizerForLayers
{
    if ([(id)self.delegate respondsToSelector:@selector(willIntializeLayer)]) {
        [self.delegate willIntializeLayer];
    }
    CGPoint anchorTop;
    CGPoint anchorBottom;
    CGRect topContentRect;
    CGRect bottomContentRect;
    CGRect halfRect;
    CGSize size = self.bounds.size;
    switch (self.type) {
        case NQHorizontalFolding:
            anchorTop=CGPointMake(0.5,1);
            anchorBottom=CGPointMake(0.5,0);
            topContentRect=CGRectMake(0, 0, 1, 0.5);
            bottomContentRect=CGRectMake(0, 0.5, 1, 0.5);
            halfRect = CGRectMake(0,0,size.width, 0.5 * size.height);
            break;
            
        case NQVerticalFolding:
            anchorTop=CGPointMake(1,0.5);
            anchorBottom=CGPointMake(0,0.5);
            topContentRect=CGRectMake(0, 0, 0.5, 1);
            bottomContentRect=CGRectMake(0.5, 0, 0.5, 1);
            halfRect = CGRectMake(0,0,0.5 * size.width, size.height);
            break;
    }
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/1000.0;
    self.layer.sublayerTransform = transform;
    
    self.topHalfLayer = [CALayer layer];
    
    self.topHalfLayer.backgroundColor=[[UIColor redColor] CGColor];
    self.topHalfLayer.anchorPoint = anchorTop;
    
    self.topHalfLayer.contentsRect=topContentRect;
    [self.layer addSublayer:self.topHalfLayer];
    
    self.bottomHalfLayer = [CALayer layer];
    
    self.topHalfLayer.backgroundColor=[[UIColor blueColor] CGColor];
    self.bottomHalfLayer.anchorPoint = anchorBottom;
    
    self.bottomHalfLayer.contentsRect=bottomContentRect;
    [self.layer addSublayer:self.bottomHalfLayer];
    
    self.topHalfLayer.contents=(id) self.image.CGImage;
    self.bottomHalfLayer.contents=(id)self.image.CGImage;
    
  
    
    // Configure the layer bounds and midpoints
    
    
    self.topHalfLayer.bounds = halfRect;
    self.bottomHalfLayer.bounds = halfRect;
    self.midPoint = CGPointMake(0.5 * size.width, 0.5 * size.height);
    self.topHalfLayer.position = self.midPoint;
    self.bottomHalfLayer.position = self.midPoint;
    
    if ([(id)self.delegate respondsToSelector:@selector(didFinishIntializeLayer)]) {
        [self.delegate didFinishIntializeLayer];
    }

}


-(void) initalizeTransformations
{
    if ([(id)self.delegate respondsToSelector:@selector(willIntializeTransfromations)]) {
        [self.delegate willIntializeTransfromations];
    }
    NQAxes axes;
    int sign;
    CATransform3D transform;
    switch (self.type) {
        case NQHorizontalFolding:
            axes=NQAxesWith(1.0, 0.0, 0.0);
            sign=1;
            transform=CATransform3DMakeTranslation(0.0, -self.bounds.size.height/2, -50);
            break;
        case NQVerticalFolding:
            axes=NQAxesWith(0.0, 1.0, 0.0);
            sign=-1;
            transform=CATransform3DMakeTranslation(-self.bounds.size.width/2, 0.0, -50);
            break;
    }
    self.transformClosedTop= CATransform3DRotate(transform, sign*acosf(0), axes.x, axes.y, axes.z);
    self.transformClosedBottom = CATransform3DRotate(transform, 0, axes.x, axes.y, axes.z);
    self.topHalfLayer.transform=self.transformClosedTop;
    self.bottomHalfLayer.transform=self.transformClosedBottom;
    self.transformOpenedTop=CATransform3DIdentity;
    self.transformOpenedBottom=CATransform3DIdentity;
    if ([(id)self.delegate respondsToSelector:@selector(didFinishIntializeTransformations)]) {
        [self.delegate didFinishIntializeTransformations];
    }
}

- (void)pinch:(UIPinchGestureRecognizer *) recognizer
{
    CGPoint location=[recognizer locationInView:self];
    float frameScale = recognizer.scale;
    //NSLog(@"pinch scale %f",frameScale);
    
    if (frameScale>1) {
        frameScale=1;
    }
    if (frameScale<0.2) {
        frameScale=0.2;
    }
    
    if(recognizer.state==UIGestureRecognizerStateBegan)
    {
        
        
    }
    if(recognizer.state==UIGestureRecognizerStateChanged){
        self.status=NQTransition;
        [self animateWithScale:frameScale andPosition:location];
    }
    
    if (recognizer.state==UIGestureRecognizerStateEnded || recognizer.state==UIGestureRecognizerStateCancelled || recognizer.state==UIGestureRecognizerStateFailed) {
        const float threshold=0.5;
        
        if(frameScale < threshold)
        {
            [self fold];
        }
        else if (frameScale>=threshold)
        {
            [self flat];
        }
    }
}

-(void) animateWithScale:(float) scale andPosition:(CGPoint) aPosition
{
    NQAxes axes;
    int sign;
    switch (self.type) {
        case NQHorizontalFolding:
            axes=NQAxesWith(1.0, 0.0, 0.0);
            sign=1;
            break;
        case NQVerticalFolding:
            axes=NQAxesWith(0.0, 1.0, 0.0);
            sign=-1;
            break;
    }
    
    CGFloat theta = sign * acosf(scale);
    CGFloat topAngle = theta;
    CGFloat bottomAngle = -theta;
    CGFloat z = 4 * sinf(theta);
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    //CGPoint newPos=CGPointMake(aPosition.x-self.midPoint.x, aPosition.y-self.midPoint.y);
//    self.topHalfLayer.position = aPosition;
//    self.bottomHalfLayer.position = aPosition;
    CATransform3D transform= CATransform3DMakeTranslation(aPosition.x-self.midPoint.x,aPosition.y-self.midPoint.y, -z);
    
//    CATransform3D transform= CATransform3DMakeTranslation(0.0,0.0, -z);
    self.topHalfLayer.transform = CATransform3DRotate(transform, topAngle, axes.x, axes.y, axes.z);
    self.bottomHalfLayer.transform = CATransform3DRotate(transform, bottomAngle, axes.x, axes.y, axes.z);
    [CATransaction commit];
}

-(void) flat
{
    if ([(id)self.delegate respondsToSelector:@selector(foldingViewWillAnimateToFlat)]) {
        [self.delegate foldingViewWillAnimateToFlat];
    }
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:ANIMATION_DURATION];
    [CATransaction setCompletionBlock:^{
        if ([(id)self.delegate respondsToSelector:@selector(foldingViewDidAnimateToFlat)]) {
            [self.delegate foldingViewDidAnimateToFlat];
        }
    }];
    self.topHalfLayer.transform=self.transformOpenedTop;
    self.bottomHalfLayer.transform=self.transformOpenedBottom;
 
    [CATransaction commit];
    self.status=NQOpened;    
}

-(void) fold
{
    if ([(id)self.delegate respondsToSelector:@selector(foldingViewWillAnimateToFold)]) {
        [self.delegate foldingViewWillAnimateToFold];
    }
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:ANIMATION_DURATION];
    [CATransaction setCompletionBlock:^{
        if ([(id)self.delegate respondsToSelector:@selector(foldingViewDidAnimateToFold)]) {
            [self.delegate foldingViewDidAnimateToFold];
        }
    }];
    self.topHalfLayer.transform=self.transformClosedTop;
    self.bottomHalfLayer.transform=self.transformClosedBottom;

    [CATransaction commit];
    self.status=NQClosed;
    
    
}
#pragma mark setFlapped
-(void)setFlapped:(BOOL)flapped
{
    _flapped=flapped;
    if (_flapped) {
        [self flat];
    }
    else
    {
        [self fold];
    }
}
#pragma mark touch handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.flapped=!self.flapped;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
