//
//  CountFromGeneratorManager.m
//  SMGeneratorExperiments
//
//  Created by Mikhail Shkutkov on 25/01/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "CountFromGeneratorManager.h"

@interface CountFromGeneratorManager ()

@property (nonatomic, assign) NSInteger from;

@end

@implementation CountFromGeneratorManager

- (instancetype)initWithFromValue:(NSInteger)from
{
    self = [super init];
    if (self) {
        _from = from;
    }
    return self;
}

GENERATOR(NSNumber *, CountFrom(NSInteger start), (void))
{
    __block NSInteger n;
    GENERATOR_BEGIN(void)
    {
        n = start;
        while (TRUE) {
            GENERATOR_YIELD(@(n));
            n++;
        }

    }
    GENERATOR_END
}

- (Generator)maGenerator
{
    return CountFrom(self.from);
}

- (Generator)extCoroutine
{
    __block NSInteger n = self.from;
    return coroutine()({
        while (TRUE) {
            ext_yield(@(n));
            n++;
        }
    });
}

- (id<NSFastEnumeration>)smSyncGenerator
{
    return SM_GENERATOR(^(NSNumber *n) {
        NSInteger i = [n integerValue];
        while (TRUE) {
            SM_YIELD(@(i));
            i++;
        }
    }, @(self.from));
}

- (id<NSFastEnumeration>)smAsyncGenerator
{
    return SM_ASYNC_GENERATOR(^(NSNumber *n) {
        NSInteger i = [n integerValue];
        while (TRUE) {
            SM_YIELD(@(i));
            i++;
        }
    }, @(self.from));
}


@end
