//
//  TestManager.m
//  
//
//  Created by Mikhail Shkutkov on 31/01/14.
//
//

#import "PerformanceTestRunner.h"

@interface PerformanceTestRunner()

@property (nonatomic, assign) NSInteger testCounts;
@property (nonatomic, assign) NSInteger discardResultsCount;

@end

@implementation PerformanceTestRunner

- (instancetype)initManagerWithTestsCount:(NSInteger)count andDiscardResultsCount:(NSInteger)discardResultsCount
{
    self = [super init];
    if (self) {
        _testCounts = count;
        if (discardResultsCount * 2 < count) {
            _discardResultsCount = discardResultsCount;
        } else {
            _discardResultsCount = 0;
        }
    }
    return self;
}

- (NSTimeInterval)runPerformanceTestSet:(void (^)(void))testBlock
{
    NSArray *performanceResults = [self runAllPerformanceTests:testBlock];
    
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    NSArray *sortedResults = [performanceResults sortedArrayUsingDescriptors:@[highestToLowest]];
    
    NSArray *meaningfullResults = [sortedResults subarrayWithRange:NSMakeRange(self.discardResultsCount, self.testCounts - 2 * self.discardResultsCount)];
    
    NSNumber *averageTime = [meaningfullResults valueForKeyPath:@"@avg.floatValue"];
    return [averageTime floatValue];
}

- (void)runPerformanceTestSetAsynchronously:(void (^)(void))testBlock completition:(void (^)(NSTimeInterval result))completition
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSTimeInterval result = [self runPerformanceTestSet:testBlock];
        dispatch_sync(dispatch_get_main_queue(), ^{
            completition(result);
        });
    });
}

#pragma mark - Private Methods

- (NSTimeInterval)runPerformanceTestOneTime:(void (^)(void))testBlock
{
    NSDate *date = [NSDate date];
    testBlock();
    NSTimeInterval time = -[date timeIntervalSinceNow];
    return time;
}

- (NSArray *)runAllPerformanceTests:(void (^)(void))testBlock
{
    NSMutableArray *results = [@[] mutableCopy];
    for (NSInteger i = 0; i < self.testCounts; ++i) {
        NSTimeInterval time = [self runPerformanceTestOneTime:testBlock];
        [results addObject:@(time)];
    }
    return results;
}

@end
