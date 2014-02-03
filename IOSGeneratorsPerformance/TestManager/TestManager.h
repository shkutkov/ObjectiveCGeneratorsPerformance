//
//  TestManager.h
//  
//
//  Created by Mikhail Shkutkov on 31/01/14.
//
//

#import <Foundation/Foundation.h>

@interface TestManager : NSObject

- (instancetype)initManagerWithTestsCount:(NSInteger)count andDiscardResultsCount:(NSINteger)discardResultsCount;

- (NSTimeInterval)runPerformanceTest:(void (^)(void))testBlock;

@end
