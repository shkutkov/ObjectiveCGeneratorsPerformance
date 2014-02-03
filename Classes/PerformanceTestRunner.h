//
//  TestManager.h
//  
//
//  Created by Mikhail Shkutkov on 31/01/14.
//
//

#import <Foundation/Foundation.h>

@interface PerformanceTestRunner : NSObject

- (instancetype)initManagerWithTestsCount:(NSInteger)count andDiscardResultsCount:(NSInteger)discardResultsCount;

- (NSTimeInterval)runPerformanceTestSet:(void (^)(void))testBlock;

- (void)runPerformanceTestSetAsynchronously:(void (^)(void))testBlock completition:(void (^)(NSTimeInterval result))completition;

@end
