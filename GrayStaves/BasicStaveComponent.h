//
//  BasicStaveComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 21/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "ScalableView.h"
#import "BasicStaveView.h"

@interface BasicStaveComponent : ScalableView{
    BOOL _selected;
}

@property (nonatomic) CGFloat xValue;
@property (nonatomic) CGFloat yRelativeValue;

@property (nonatomic) NSColor* color;

-(void)setFrameOriginAtRelativePoint:(NSPoint)newOrigin;
-(void)setFrameOriginAtRelativeXValue:(CGFloat)x andYValue:(CGFloat)y;

-(CGFloat)YValueTransform:(CGFloat)literalY;
-(CGFloat)xValueTransform:(CGFloat)literalX;

@end