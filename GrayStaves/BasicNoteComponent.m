//
//  BasicNoteComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 10/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicNoteComponent.h"


@implementation BasicNoteComponent

@synthesize drawTail;
@synthesize drawFlag;
@synthesize tailUp;

-(void)setDrawTail:(BOOL)newVal{drawTail=newVal;}
-(void)setDrawFlag:(BOOL)newVal{drawFlag=newVal;}
-(void)setTailUp:(BOOL)newVal{tailUp=newVal;}


@end
