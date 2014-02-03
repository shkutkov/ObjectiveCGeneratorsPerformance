//
//  RootViewController.m
//  OSXGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 03/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "RootViewController.h"
#import "PerformanceTestManager.h"
#import "PerformanceTest.h"
#import "PerformanceTestRunner.h"
#import "Constants.h"

@interface RootViewController ()

@property (weak) IBOutlet NSComboBox *performanceTestComboBox;
@property (weak) IBOutlet NSComboBox *implementationComboBox;
@property (weak) IBOutlet NSButton *runButton;
@property (weak) IBOutlet NSProgressIndicator *activityIndicator;

@property (nonatomic, strong) NSArray *performanceTests;
@property (nonatomic, strong) NSArray *implementations;
@property (nonatomic, strong) NSArray *implementationsName;

@end

@implementation RootViewController

-(void)awakeFromNib
{
    self.performanceTests = @[@(kDummyIterationPerformanceTestType),
                              @(kIterationWithLoggingPerformanceTestType),
                              @(kPrimeNumbersPerformanceTestType)];
    
    for (NSNumber *number in self.performanceTests) {
        PerformanceTestType type = [number integerValue];
        id<PerformanceTest> test = [[PerformanceTestManager sharedManager] performanceTestWithType:type];
        [self.performanceTestComboBox addItemWithObjectValue:[test name]];
    }
    
    self.implementations = @[@(kNoGeneratorImplementation),
                             @(kSMGeneratorSyncImplementation),
                             @(kSMGeneratorAsyncImplementation),
                             @(kMAGeneratorImplementation),
                             @(kExtCoroutineImplementation)];
    
    self.implementationsName = @[@"Without generator",
                                 @"SMGenerator Sync",
                                 @"SMGenerator Async",
                                 @"MAGenerator",
                                 @"EXTCoroutine"];
    
    for (NSNumber *number in self.implementations) {
        [self.implementationComboBox addItemWithObjectValue:self.implementationsName[[number integerValue]]];
    }
    
    [self.performanceTestComboBox selectItemAtIndex:0];
    [self.implementationComboBox selectItemAtIndex:0];
}

- (IBAction)runAction:(id)sender
{
    self.performanceTestComboBox.enabled = NO;
    self.implementationComboBox.enabled = NO;
    
    self.runButton.hidden = YES;
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimation:self];
    
    PerformanceTestType type = [self.performanceTestComboBox indexOfSelectedItem];
    id<PerformanceTest> performanceTest = [[PerformanceTestManager sharedManager] performanceTestWithType:type];

    PerformanceTestImplemenationType implementationType = [self.implementationComboBox indexOfSelectedItem];
    
    ExecutionBlock exBlock;
    switch (implementationType) {
        case kNoGeneratorImplementation:
            exBlock = [performanceTest noGeneratorBlock];
            break;
        case kSMGeneratorSyncImplementation:
            exBlock = [performanceTest smGeneratorSyncBlock];
            break;
        case kSMGeneratorAsyncImplementation:
            exBlock = [performanceTest smGeneratorAsyncBlock];
            break;
        case kMAGeneratorImplementation:
            exBlock = [performanceTest maGeneratorBlock];
            break;
        case kExtCoroutineImplementation:
            exBlock = [performanceTest extCoroutineBlock];
            break;
    }
    
    PerformanceTestRunner *testRunner = [[PerformanceTestRunner alloc] initManagerWithTestsCount:kPerformanceTestsCount
                                                                          andDiscardResultsCount:kDiscardPerformanceResulsCount];
    [testRunner runPerformanceTestSetAsynchronously:exBlock completition:^(NSTimeInterval result) {
        self.performanceTestComboBox.enabled = YES;
        self.implementationComboBox.enabled = YES;
        
        self.runButton.hidden = NO;
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimation:self];
        
        NSString *message = [NSString stringWithFormat:@"Result %f", result];
        NSAlert *alert = [NSAlert alertWithMessageText:@"Performance test completed"
                     defaultButton:@"OK"
                   alternateButton:nil
                       otherButton:nil
         informativeTextWithFormat:message, nil];
        [alert setAlertStyle:NSInformationalAlertStyle];
        [alert runModal];
    }];
}

@end
