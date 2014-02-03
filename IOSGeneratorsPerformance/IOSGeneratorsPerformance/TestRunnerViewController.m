//
//  TestRunnerViewController.m
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "TestRunnerViewController.h"
#import "PerformanceTestRunner.h"
#import "Constants.h"

@interface TestRunnerViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (nonatomic, strong) PerformanceTestRunner *testRunner;

@end

@implementation TestRunnerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.testRunner = [[PerformanceTestRunner alloc] initManagerWithTestsCount:kPerformanceTestsCount
                                                        andDiscardResultsCount:kDiscardPerformanceResulsCount];
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    [self.testRunner runPerformanceTestSetAsynchronously:self.executionBlock completition:^(NSTimeInterval result) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.activityIndicator stopAnimating];
            strongSelf.activityIndicator.hidden = YES;
            strongSelf.resultsLabel.text = [NSString stringWithFormat:@"%f", result];
            strongSelf.resultsLabel.hidden = NO;
            strongSelf.navigationItem.hidesBackButton = NO;
        }
    }];
}

@end
