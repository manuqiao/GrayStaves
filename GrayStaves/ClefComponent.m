//
//  ClefComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 22/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "ClefComponent.h"
#import "GrayStavesDelegate.h"

@interface ClefComponent (Private)

+(CGFloat)separationRatio;
+(CGFloat)bottomLineRatio;
+(CGFloat)staveRatio;

-(void)loadImage;

@end

@implementation ClefComponent
@synthesize clef;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    if (_selected)
        [[NSBezierPath bezierPathWithRect:dirtyRect]stroke];
}

-(instancetype)initWithClef:(ClefEnum)clf andScale:(CGFloat)scale{
    self = [super initWithScale:scale];
    if (self){
        clef = clf;
        [self loadImage];
    }
    return  self;
}

//-(void)setScale:(CGFloat)scale{
//    [super setScale:scale];
//    CGFloat oldStaveHeight = self.frame.origin.y-_staveOffset;
//    [self loadImage];
//    [self setFrameOriginAtRelativeHeight:oldStaveHeight];
//}

-(void)loadImage{
    NSImage* image;
    CGFloat height = 4*self.scale;
    CGFloat staveRatio = [ClefComponent staveRatio];
    switch (clef) {
        case ClefAlto:
            image= [GrayStavesDelegate getImageNamed:@"alto-clef"];
            break;
        case ClefBass:
            image = [GrayStavesDelegate getImageNamed:@"bass-clef"];
            break;
        case ClefTreble:
            image = [GrayStavesDelegate getImageNamed:@"treble-clef"];
            break;
        case ClefTenor:
            image = [GrayStavesDelegate getImageNamed:@"tenor-clef"];
            break;
        default:
            return;
    }
    CGFloat currentStaveHeight = staveRatio*image.size.height;
    CGFloat transformRatio = height/currentStaveHeight;
    [image setSize:NSMakeSize(image.size.width*transformRatio, image.size.height*transformRatio)];
    [self setImage:image];
    [self setFrameSize:image.size];
    //CGFloat staveGap = [ClefComponent bottomLineRatio]*self.frame.size.height;
    //_yRelativeOffset =-staveGap;
}


-(void)setScale:(CGFloat)scale{
    [super setScale:scale];
    CGFloat height = 4*scale;
    
    NSSize currentSize = self.frame.size;
    CGFloat staveRatio = [ClefComponent staveRatio];
    CGFloat currentStaveHeight = staveRatio*currentSize.height;
    CGFloat transformRatio = height/currentStaveHeight;
    
    NSSize newSize = NSMakeSize(transformRatio*currentSize.width, transformRatio*currentSize.height);
    [self setFrameSize:newSize];
    [self.image setSize:newSize];
//    CGFloat staveGap = [ClefComponent bottomLineRatio]*newSize.height;
//    CGFloat staveBottom = self.frame.origin.y+_yRelativeOffset;
//    _yRelativeOffset = -staveGap;
    [self setYRelativeValue:self.frame.origin.y];
}

+(CGFloat)separationRatio{
    return 93.75/644.;
}

+(CGFloat)bottomLineRatio{
    return 152./644.;
}
+(CGFloat)staveRatio{
    return (527.-152.)/644.;
}

-(CGFloat)YValueTransform:(CGFloat)literalY{
    CGFloat staveGap = [ClefComponent bottomLineRatio]*self.frame.size.height;
    return literalY-staveGap;
}


@end
