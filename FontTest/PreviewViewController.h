//
//  PreviewViewController.h
//  FontTest
//
//  Created by Todd Grooms on 10/30/14.
//  Copyright (c) 2014 GroomsyDev. All rights reserved.
//

@import UIKit;

@interface PreviewViewController : UIViewController

@property (nonatomic, assign, getter=shouldLoadWithFontDescriptor) BOOL loadWithFontDescriptor;

@property (nonatomic, assign) uint64_t start;

@end
