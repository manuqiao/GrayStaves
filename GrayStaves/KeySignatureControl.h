//
//  KeySignatureControl.h
//  GrayStaves
//
//  Created by Thomas Gray on 30/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "StaveComponentControl.h"
#import "AccidentalComponent.h"

@interface KeySignatureControl : StaveComponentControl

@property (nonatomic) KeySignature keySignature;
@property (nonatomic) ClefEnum clef;
@property NSMutableArray<AccidentalComponent*>* accidentals;

-(instancetype)initWithScale:(CGFloat)scle clef:(ClefEnum)clf andKeySignature:(KeySignature)sig;

+(NoteLetter)noteLetterForKeyIndex:(KeySignature)sig;


@end
