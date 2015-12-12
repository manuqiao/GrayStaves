//
//  StaveDocument.h
//  GrayStaves
//
//  Created by Thomas Gray on 22/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

//#import <GrayStaves/GrayStaves.h>
#import <Cocoa/Cocoa.h>
#import "StaveView.h"
#import "ScalableView.h"

@interface StaveDocument : ScalableView{
    NSMutableArray<StaveView*>* staves;
}


@end
