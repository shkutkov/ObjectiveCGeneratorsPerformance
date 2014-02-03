//
//  PerformanceTestManager.m
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "PerformanceTestManager.h"
#import "DummyIterationPerformanceTest.h"
#import "IterationWithLoggingPerformanceTest.h"
#import "PrimeNumbersWithLoggingPerformanceTest.h"

static NSInteger const kDummyIterationFrom = 1;
static NSInteger const kDummyIterationCount = 100000;

static NSInteger const kIterationWithLogFrom = 1;
static NSInteger const kIterationWithLogCount = 1000;

static NSInteger const kPrimeNumbersFrom = 100000;
static NSInteger const kPrimeNumbersCount = 1000;


@interface PerformanceTestManager ()

@property (nonatomic, strong) NSDictionary *tests;

@end

@implementation PerformanceTestManager

+ (PerformanceTestManager *)sharedManager
{
    static PerformanceTestManager *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tests = @{@(kDummyIterationPerformanceTestType):
                       [[DummyIterationPerformanceTest alloc] initWithIterationsCount:kDummyIterationCount
                                                                                 from:kDummyIterationFrom],
                   @(kIterationWithLoggingPerformanceTestType):
                       [[IterationWithLoggingPerformanceTest alloc] initWithIterationsCount:kIterationWithLogCount
                                                                                       from:kIterationWithLogFrom],
                   @(kPrimeNumbersWithLoggingPerformanceTestType):
                       [[PrimeNumbersWithLoggingPerformanceTest alloc] initWithIterationsCount:kPrimeNumbersCount
                                                                                      from:kPrimeNumbersFrom]
       };
    }
    return self;
}

- (id<PerformanceTest>)performanceTestWithType:(PerformanceTestType)type;
{
    return self.tests[@(type)];
}

@end
