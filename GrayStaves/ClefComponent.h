//
//  ClefComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 22/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

//#import "GrayStaves.h"
#import "BasicStaveComponent.h"

@interface ClefComponent : BasicStaveComponent

@property (nonatomic) ClefEnum clef;

-(instancetype)initWithClef:(ClefEnum)clef andScale:(CGFloat)scale;

@end
