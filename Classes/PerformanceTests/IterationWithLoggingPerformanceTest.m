//
//  IterationWithLoggingPerformanceTest.m
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "IterationWithLoggingPerformanceTest.h"
#import "CountFromGeneratorManager.h"

@interface IterationWithLoggingPerformanceTest()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger from;
@property (nonatomic, strong) CountFromGeneratorManager *manager;

@end

@implementation IterationWithLoggingPerformanceTest

- (instancetype)initWithIterationsCount:(NSInteger)count from:(NSInteger)from
{
    self = [super init];
    if (self) {
        _count = count;
        _from = count;
        _manager = [[CountFromGeneratorManager alloc] initWithFromValue:from];
    }
    return self;
}

- (NSString *)name
{
    return [NSString stringWithFormat:@"Iteration with logging from %d to %d", self.from, self.count];
}

- (ExecutionBlock)noGeneratorBlock
{
    return ^() {
        for (NSInteger i = self.from; i < self.from + self.count; ++i) {
            NSLog(@"%ld", (long)i);
        }
    };
}

- (ExecutionBlock)smGeneratorSyncBlock
{
    SMGenerator *smGenerator = [self.manager smSyncGenerator];
    return ^() {
        NSInteger i = 0;
        while (i++ < self.count) {
            NSNumber *number = [smGenerator next];
            NSLog(@"%@", number);
        }
    };
}

- (ExecutionBlock)smGeneratorAsyncBlock
{
    SMGenerator *smGenerator = [self.manager smAsyncGenerator];
    return ^() {
        NSInteger i = 0;
        while (i++ < self.count) {
            NSNumber *number = [smGenerator next];
            NSLog(@"%@", number);
        }
    };
}

- (ExecutionBlock)maGeneratorBlock
{
    Generator maGenerator = [self.manager maGenerator];
    return ^() {
        NSInteger i = 0;
        while (i++ < self.count) {
            NSNumber *number = maGenerator();
            NSLog(@"%@", number);
        }
    };
}

- (ExecutionBlock)extCoroutineBlock
{
    Generator extCoroutine = [self.manager extCoroutine];
    return ^() {
        NSInteger i = 0;
        while (i++ < self.count) {
            NSNumber *number = extCoroutine();
            NSLog(@"%@", number);
        }
    };
}

@end
