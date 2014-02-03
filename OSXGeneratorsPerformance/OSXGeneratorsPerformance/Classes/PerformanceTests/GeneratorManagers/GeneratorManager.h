//
//  GeneratorManager.h
//  SMGeneratorExperiments
//
//  Created by Mikhail Shkutkov on 24/01/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXTCoroutine.h"
#import "MAGenerator.h"
#import "SMGenerator.h"

typedef  id (^Generator)(void);

@protocol GeneratorManager <NSObject>

- (Generator)maGenerator;
- (Generator)extCoroutine;
- (SMGenerator *)smSyncGenerator;
- (SMGenerator *)smAsyncGenerator;

@end
