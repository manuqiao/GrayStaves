//
//  StaveComponentControl.h
//  GrayStaves
//
//  Created by Thomas Gray on 30/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicStaveView.h"

@interface StaveComponentControl : NSObject

@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat YrelativeValue;
@property (nonatomic) CGFloat xRelativeValue;

-(instancetype)initWithScale:(CGFloat)scle;

-(void)setFrameOriginAtRelativeX:(CGFloat)x andRelativeY:(CGFloat)y;
-(void)addToStave:(BasicStaveView*)stave;
-(void)removeFromSuperview;
-(void)initialise;

@end
