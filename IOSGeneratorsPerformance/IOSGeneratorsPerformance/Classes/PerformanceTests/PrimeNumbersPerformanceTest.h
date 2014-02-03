//
//  PrimeNumbersPerformanceTest.h
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PerformanceTest.h"

@interface PrimeNumbersPerformanceTest : NSObject<PerformanceTest>

- (instancetype)initWithIterationsCount:(NSInteger)count from:(NSInteger)from;

@end
