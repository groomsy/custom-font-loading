//
//  HomeViewController.m
//  FontTest
//
//  Created by Todd Grooms on 10/30/14.
//  Copyright (c) 2014 GroomsyDev. All rights reserved.
//

@import MachO;

#import "HomeViewController.h"
#import "PreviewViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PreviewViewController *vc = (PreviewViewController *)segue.destinationViewController;
    vc.loadWithFontDescriptor = [@"ShowFontDescriptor" isEqualToString:segue.identifier];
    vc.start = mach_absolute_time();
}

@end
