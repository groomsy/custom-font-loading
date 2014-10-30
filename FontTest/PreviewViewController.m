//
//  PreviewViewController.m
//  FontTest
//
//  Created by Todd Grooms on 10/30/14.
//  Copyright (c) 2014 GroomsyDev. All rights reserved.
//

@import MachO;

#import "PreviewViewController.h"

NSString * const kOswaldFontName = @"Oswald";

@interface PreviewViewController ()

@property (nonatomic, weak) IBOutlet UILabel *previewLabel;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;

@end

@implementation PreviewViewController

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.statusLabel.alpha = 0.f;
    self.statusLabel.text = nil;

    [self preferredContentSizeChanged:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if ( self.statusLabel.alpha < 1.f ) {
        uint64_t end = mach_absolute_time();
        uint64_t elapsed = end - self.start;
        uint64_t elapsedTimeInNanoSeconds = 0;

        mach_timebase_info_data_t timeBaseInfo;
        mach_timebase_info(&timeBaseInfo);
        elapsedTimeInNanoSeconds = elapsed * timeBaseInfo.numer / timeBaseInfo.denom;
        double elapsedTimeInSeconds = elapsedTimeInNanoSeconds * 1.0E-9;

        self.statusLabel.text = [NSString stringWithFormat:@"this view took %f seconds to load", elapsedTimeInSeconds];

        [UIView animateWithDuration:0.3f animations:^{
            self.statusLabel.alpha = 1.f;
        }];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

#pragma mark NSNotificationCenter Observer Methods

- (void)preferredContentSizeChanged:(NSNotification *)notification {
    UIFont *systemBodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    UIFont *font = nil;
    if ( self.shouldLoadWithFontDescriptor ) {
        UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:kOswaldFontName
                                                                               size:systemBodyFont.pointSize];

        font = [UIFont fontWithDescriptor:fontDescriptor size:0];
    } else {
        font = [UIFont fontWithName:kOswaldFontName size:systemBodyFont.pointSize];
    }
    self.previewLabel.font = font;

    self.statusLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
}

@end
