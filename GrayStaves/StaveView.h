//
//  StaveView.h
//  GrayStaves
//
//  Created by Thomas Gray on 21/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "GrayStaves.h"
#import "BasicStaveView.h"
#import "BarView.h"

@interface StaveView : BasicStaveView

@property (nonatomic) NSColor* staveLineColor;
@property (nonatomic) NSColor* backgroundColor;


-(void)addBar:(BarView*)bar atX:(CGFloat)xpos;

@end
