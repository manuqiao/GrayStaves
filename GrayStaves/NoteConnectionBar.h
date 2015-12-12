//
//  NoteConnectionBar.h
//  GrayStaves
//
//  Created by Thomas Gray on 08/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"

@interface NoteConnectionBar : BasicStaveComponent

@property (nonatomic) BOOL inclined;

-(void)positionLeftPoint:(NSPoint)lpoint rightPoint:(NSPoint)rPoint;

@end
