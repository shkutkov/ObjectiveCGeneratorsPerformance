//
//  PerformanceTestManager.h
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PerformanceTest.h"

typedef NS_ENUM(NSInteger, PerformanceTestType) {
    kDummyIterationPerformanceTestType,
    kIterationWithLoggingPerformanceTestType,
    kPrimeNumbersPerformanceTestType
};

@interface PerformanceTestManager : NSObject

+ (PerformanceTestManager *)sharedManager;

- (id<PerformanceTest>)performanceTestWithType:(PerformanceTestType)type;

@end
