//
//  StaveDocument.m
//  GrayStaves
//
//  Created by Thomas Gray on 22/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "StaveDocument.h"

@implementation StaveDocument

-(void)initialise{
    [super initialise];
    staves = [[NSMutableArray alloc]init];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
