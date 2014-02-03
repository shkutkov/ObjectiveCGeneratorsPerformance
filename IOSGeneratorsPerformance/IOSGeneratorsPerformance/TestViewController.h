//
//  TestViewController.h
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformanceTest.h"

@interface TestViewController : UITableViewController

@property (nonatomic, strong) id<PerformanceTest> performanceTest;

@end
