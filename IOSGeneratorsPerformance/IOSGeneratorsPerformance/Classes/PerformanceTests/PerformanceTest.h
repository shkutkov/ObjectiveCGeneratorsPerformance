//
//  PerformanceTest.h
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ExecutionBlock)(void);

typedef NS_ENUM(NSInteger, PerformanceTestImplemenationType) {
    kNoGeneratorImplementation,
    kSMGeneratorSyncImplementation,
    kSMGeneratorAsyncImplementation,
    kMAGeneratorImplementation,
    kExtCoroutineImplementation
};

@protocol PerformanceTest <NSObject>

- (NSString *)name;

- (ExecutionBlock)noGeneratorBlock;
- (ExecutionBlock)smGeneratorSyncBlock;
- (ExecutionBlock)smGeneratorAsyncBlock;
- (ExecutionBlock)maGeneratorBlock;
- (ExecutionBlock)extCoroutineBlock;

@end
