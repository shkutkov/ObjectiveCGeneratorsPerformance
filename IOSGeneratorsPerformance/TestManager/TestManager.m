//
//  TestManager.m
//  
//
//  Created by Mikhail Shkutkov on 31/01/14.
//
//

#import "TestManager.h"

@interface TestManager()

@property (nonatomic, assign) NSInteger testCounts;
@property (nonatomic, assign) NSInteger discardResultsCount;

@end

@implementation TestManager

- (instancetype)initManagerWithTestsCount:(NSInteger)count andDiscardResultsCount:(NSINteger)discardResultsCount
{
    self = [super init];
    if (self) {
        _testCounts = count;
        _discardResultsCount = discardResultsCount;
    }
    return self;
}

- (NSTimeInterval)runPerformanceTest:(void (^)(void))testBlock
{
    NSMutableArray *results = [@[] mutableCopy];
    for (NSInteger i = 0; i < self.testCounts; ++i) {
        NSDate *date = [NSDate date];
        testBlock();
        NSTimeInterval time = -[date timeIntervalSinceNow];
        [results addObject:@(time)];
    }
    
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [mutableArrayOfNumbers sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    NSArray *subArray = 
}


@end
