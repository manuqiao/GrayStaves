//
//  NoteTailFlagComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 11/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"

@interface NoteTailFlagComponent : BasicStaveComponent

@property (nonatomic) TimeValue timeValue;
@property (nonatomic) BOOL drawUpward;

-(instancetype)initWithScale:(CGFloat)scale andTimeVale:(TimeValue)tval drawingUpward:(BOOL)up;

@end
