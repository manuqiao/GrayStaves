//
//  BasicStaveView.h
//  GrayStaves
//
//  Created by Thomas Gray on 21/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "ScalableView.h"
#import "StaveConstants.h"

@interface BasicStaveView : ScalableView

@property (nonatomic) StaveInsets staveInsets;

-(void)setStaveInsetBottom:(CGFloat)bottom;
-(void)setStaveInsetsTop:(CGFloat)top;
-(void)setStaveInsetLeft:(CGFloat)left;
-(void)setStaveInsetRight:(CGFloat)right;

-(void)refreshLayout;

@end
