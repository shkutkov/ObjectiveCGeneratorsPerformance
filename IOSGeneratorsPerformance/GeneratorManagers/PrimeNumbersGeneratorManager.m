//
//  PrimeNumbersGeneratorManager.m
//  SMGeneratorExperiments
//
//  Created by Mikhail Shkutkov on 24/01/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "PrimeNumbersGeneratorManager.h"

@interface PrimeNumbersGeneratorManager ()

@property (nonatomic, assign) NSInteger from;

@end

@implementation PrimeNumbersGeneratorManager

- (instancetype)initWithFrom:(NSInteger)from
{
    self = [super init];
    if (self) {
        _from = from;
    }
    return self;
}

GENERATOR(NSNumber *, Primes(NSInteger from), (void))
{
    __block int n;
    __block int i;
    GENERATOR_BEGIN(void)
    {
        for(n = from; ; n++)
        {
            for(i = 2; i < n; i++)
                if(n % i == 0)
                    break;
            if(i == n)
                GENERATOR_YIELD(@(n));
        }
    }
    GENERATOR_END
}

- (Generator)maGenerator
{
    return Primes(self.from);
}

- (Generator)extCoroutine
{
__block int n;
__block int i;
NSInteger from = self.from;
return coroutine()({
    for(n = from; ; n++) {
        for(i = 2; i < n; i++)
            if(n % i == 0)
                break;
        if(i == n) {
            ext_yield @(n);
        }
    }
});
}

- (id<NSFastEnumeration>)smSyncGenerator
{
    NSInteger from = self.from;
    return SM_GENERATOR(^{
        for(NSInteger n = from; ; n++) {
            int i;
            for(i = 2; i < n; i++)
                if(n % i == 0)
                    break;
            if(i == n) {
                SM_YIELD(@(n));
            }
        }
    });
}

- (id<NSFastEnumeration>)smAsyncGenerator
{
    return SM_GENERATOR(^(NSNumber *from) {
        for(NSInteger n = [from integerValue]; ; n++) {
            int i;
            for(i = 2; i < n; i++)
                if(n % i == 0)
                    break;
            if(i == n) {
                SM_YIELD(@(n));
            }
        }
    }, @(self.from));
}


@end
