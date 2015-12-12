//
//  NoteStaveLineComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 08/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"

@interface NoteStaveLineComponent : BasicStaveComponent

@property (nonatomic) int lineCount;
@property (nonatomic) BOOL drawUpwards;
@property NSColor* lineColor;

@end
