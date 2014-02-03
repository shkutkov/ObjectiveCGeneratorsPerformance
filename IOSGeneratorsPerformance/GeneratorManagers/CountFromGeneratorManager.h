//
//  CountFromGeneratorManager.h
//  SMGeneratorExperiments
//
//  Created by Mikhail Shkutkov on 25/01/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneratorManager.h"

@interface CountFromGeneratorManager : NSObject<GeneratorManager>

- (instancetype)initWithFromValue:(NSInteger)from;

@end
