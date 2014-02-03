//
//  PrimeNumbersWithLoggingPerformanceTest.h
//  
//
//  Created by Mikhail Shkutkov on 03/02/14.
//
//

#import <Foundation/Foundation.h>
#import "PerformanceTest.h"

@interface PrimeNumbersWithLoggingPerformanceTest : NSObject<PerformanceTest>

- (instancetype)initWithIterationsCount:(NSInteger)count from:(NSInteger)from;

@end
