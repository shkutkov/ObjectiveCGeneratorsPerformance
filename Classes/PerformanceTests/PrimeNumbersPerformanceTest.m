//
//  PrimeNumbersPerformanceTest.m
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "PrimeNumbersPerformanceTest.h"
#import "PrimeNumbersGeneratorManager.h"
@interface PrimeNumbersPerformanceTest ()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger from;
@property (nonatomic, strong) PrimeNumbersGeneratorManager *manager;

@end

@implementation PrimeNumbersPerformanceTest

- (instancetype)initWithIterationsCount:(NSInteger)count from:(NSInteger)from
{
    self = [super init];
    if (self) {
        _count = count;
        _from = count;
        _manager = [[PrimeNumbersGeneratorManager alloc] initWithFrom:from];
    }
    return self;
}

- (NSString *)name
{
    return [NSString stringWithFormat:@"Print %d prime numbers starting from %d", self.count, self.from];
}

- (ExecutionBlock)noGeneratorBlock
{
    return ^() {
        NSInteger i = 0;
        while (TRUE) {
            for(NSInteger n = self.from; ; n++) {
                int j;
                for(j = 2; j < n; i++)
                    if(n % j == 0)
                        break;
                if(j == n) {
                    NSLog(@"%ld", (long)n);
                    if (i++ >= self.count) {
                        return;
                    }
                }
            }
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
