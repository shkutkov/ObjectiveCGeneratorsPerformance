//
//  PrimeNumbersGeneratorManager.h
//  SMGeneratorExperiments
//
//  Created by Mikhail Shkutkov on 24/01/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneratorManager.h"

@interface PrimeNumbersGeneratorManager : NSObject<GeneratorManager>

- (instancetype)initWithFrom:(NSInteger)from;

@end
