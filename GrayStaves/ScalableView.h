//
//  ScalableView.h
//  GrayStaves
//
//  Created by Thomas Gray on 21/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StaveConstants.h"

@interface ScalableView : NSImageView

@property (nonatomic) CGFloat scale;

-(instancetype)initWithScale:(CGFloat)scale;

-(void)initialise;

-(void)resizeToFit;
-(void)resizeLeft;
-(void)resizeRight;
-(void)resizeUp;
-(void)resizeDown;

@end
