//
//  SimpleIterationPerformanceTest.m
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "DummyIterationPerformanceTest.h"
#import "CountFromGeneratorManager.h"

@interface DummyIterationPerformanceTest ()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger from;
@property (nonatomic, strong) CountFromGeneratorManager *manager;
@end

@implementation DummyIterationPerformanceTest

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
    return [NSString stringWithFormat:@"Dummy iteration from %ld to %ld", (long)self.from, (long)self.count];
}

- (ExecutionBlock)noGeneratorBlock
{
    return ^() {
        for (NSInteger i = self.from; i < self.from + self.count; ++i) {
        }
    };
}

- (ExecutionBlock)smGeneratorSyncBlock
{
    SMGenerator *smGenerator = [self.manager smSyncGenerator];
    return ^() {
        NSInteger i = 0;
        while (i++ < self.count) {
            __unused NSNumber *number = [smGenerator next];
        }
    };
}

- (ExecutionBlock)smGeneratorAsyncBlock
{
    SMGenerator *smGenerator = [self.manager smAsyncGenerator];
    return ^() {
        NSInteger i = 0;
        while (i++ < self.count) {
            __unused NSNumber *number = [smGenerator next];
        }
    };
}

- (ExecutionBlock)maGeneratorBlock
{
    Generator maGenerator = [self.manager maGenerator];
    return ^() {
        NSInteger i = 0;
        while (i++ < self.count) {
            __unused NSNumber *number = maGenerator();
        }
    };
}

- (ExecutionBlock)extCoroutineBlock
{
    Generator extCoroutine = [self.manager extCoroutine];
    return ^() {
        NSInteger i = 0;
        while (i++ < self.count) {
            __unused NSNumber *number = extCoroutine();
        }
    };
}

@end
