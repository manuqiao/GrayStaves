//
//  BasicNoteComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 10/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"

@interface BasicNoteComponent : BasicStaveComponent

@property (nonatomic) NoteStruct noteStruct;
@property (nonatomic) NoteTimeValue timeValue;

@property (nonatomic) BOOL tailUp;
@property (nonatomic) BOOL drawFlag;
@property (nonatomic) BOOL drawTail;

@end
