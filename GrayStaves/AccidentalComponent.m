//
//  AccidentalComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 29/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "AccidentalComponent.h"
#import "GrayStavesDelegate.h"

@interface AccidentalComponent ()

+(CGFloat)staveOffsetRatio;

@end

@implementation AccidentalComponent

@synthesize modifier;
@synthesize note;

-(instancetype)initWithScale:(CGFloat)scale andModifier:(NoteModifier)mod{
    self = [super initWithScale:scale];
    if (self) {
        [self setModifier:mod];
    }
    return self;
}

//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//}

-(void)setModifier:(NoteModifier)mod{
    NSImage* image;
    modifier = mod;
    switch (modifier) {
        case NoteModifierFlat:
            image = [GrayStavesDelegate getImageNamed:@"flat"];
            break;
        case NoteModifierNatural:
            image = [GrayStavesDelegate getImageNamed:@"natural"];
            break;
        case NoteModifierSharp:
            image = [GrayStavesDelegate getImageNamed:@"sharp"];
            break;
        default:
            return;
    }
    CGFloat ratio = image.size.width/image.size.height;
    CGFloat thisHeight = (320./90.)*self.scale;
    NSSize thisSize = NSMakeSize(ratio*thisHeight, thisHeight);
    [image setSize:thisSize];
    [self setImage:image];
    [self setFrameSize:thisSize];
}

-(void)setNote:(NoteStruct)newnote{
    note = newnote;
}

//-(void)setYRelativeValue:(CGFloat)yRelativeValue{
//    CGFloat offRatio = [AccidentalComponent staveOffsetRatio];
//    CGFloat diff = self.image.size.height*offRatio;
//    [self setFrameOrigin:NSMakePoint(self.xValue, yRelativeValue-diff)];
//}

-(CGFloat)YValueTransform:(CGFloat)literalY{
    CGFloat offRatio = [AccidentalComponent staveOffsetRatio];
    return literalY-(self.image.size.height*offRatio);
}

+(CGFloat)staveOffsetRatio{
    return 90./320.;
}
@end
