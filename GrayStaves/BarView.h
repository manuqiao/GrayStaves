//
//  BarView.h
//  GrayStaves
//
//  Created by Thomas Gray on 22/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BasicStaveComponent.h"
#import "ClefComponent.h"
#import "BasicStaveView.h"
#import "KeySignatureControl.h"
#import "NoteComponent.h"
#import "NoteGroupComponent.h"

@class ClefComponent;

@interface BarView : BasicStaveView{
}

-(instancetype)initWithScale:(CGFloat)scale Clef:(ClefEnum)clf Key:(KeySignature)key andTimeSignature:(TimeSignature)tme;

@property (nonatomic) ClefEnum clef;
@property (nonatomic) TimeSignature timeSignature;
@property (nonatomic) KeySignature keySignature;

@property (readonly) ClefComponent* clefView;
@property (readonly) KeySignatureControl* keySignatureControl;

@property (nonatomic) BOOL drawClef;
@property (nonatomic) BOOL drawTimeSignature;
@property (nonatomic) BOOL drawKeySignature;

-(NoteStruct)noteAtPoint:(CGFloat)pnt;
-(CGFloat)heightForNote:(NoteStruct)nte;

-(void)addComponent:(BasicStaveComponent*)comp;
-(void)addComponent:(BasicStaveComponent *)comp atX:(CGFloat)xval;

@end
