//
//  StaveComponentControl.m
//  GrayStaves
//
//  Created by Thomas Gray on 30/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "StaveComponentControl.h"

@implementation StaveComponentControl

@synthesize scale;
@synthesize xRelativeValue;
@synthesize YrelativeValue;

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initialise];
    }
    return self;
}

-(instancetype)initWithScale:(CGFloat)scle{
    self = [super init];
    if (self){
        [self initialise];
        scale = scle;
    }
    return self;
}

-(void)initialise{}

-(void)setXRelativeValue:(CGFloat)newx{
    xRelativeValue=newx;
}
-(void)setYrelativeValue:(CGFloat)newy{
    YrelativeValue=newy;
}
-(void)setScale:(CGFloat)newscale{
    scale=newscale;
}
-(void)setFrameOriginAtRelativeX:(CGFloat)x andRelativeY:(CGFloat)y{
    [self setXRelativeValue:x];
    [self setYrelativeValue:y];
}

-(void)removeFromSuperview{}
-(void)addToStave:(BasicStaveView *)stave{}

@end
