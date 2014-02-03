//
//  PrimeNumbersWithLoggingPerformanceTest.m
//  
//
//  Created by Mikhail Shkutkov on 03/02/14.
//
//

#import "PrimeNumbersWithLoggingPerformanceTest.h"
#import "PrimeNumbersGeneratorManager.h"

@interface PrimeNumbersWithLoggingPerformanceTest ()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger from;
@property (nonatomic, strong) PrimeNumbersGeneratorManager *manager;

@end

@implementation PrimeNumbersWithLoggingPerformanceTest

- (instancetype)initWithIterationsCount:(NSInteger)count from:(NSInteger)from
{
    self = [super init];
    if (self) {
        _count = count;
        _from = from;
        _manager = [[PrimeNumbersGeneratorManager alloc] initWithFrom:from];
    }
    return self;
}

- (NSString *)name
{
    return [NSString stringWithFormat:@"Print %ld prime numbers starting from %ld", (long)self.count, (long)self.from];
}

- (ExecutionBlock)noGeneratorBlock
{
    return ^() {
        NSInteger i = 0;
        NSInteger from  = self.from;
        while (TRUE) {
            for(NSInteger n = from; ; n++) {
                int j;
                for(j = 2; j < n; j++)
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
