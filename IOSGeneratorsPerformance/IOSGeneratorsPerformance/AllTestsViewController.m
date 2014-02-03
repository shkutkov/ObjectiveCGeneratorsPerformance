//
//  AllTestsViewController.m
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "AllTestsViewController.h"
#import "PerformanceTestManager.h"
#import "TestViewController.h"

@interface AllTestsViewController ()

@property (nonatomic, strong) NSArray *tests;
@property (nonatomic, assign) NSInteger currentSelection;

@end

@implementation AllTestsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.tests = @[@(kDummyIterationPerformanceTestType),
                   @(kIterationWithLoggingPerformanceTestType),
                   @(kPrimeNumbersPerformanceTestType)];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PerformanceTestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSNumber *number = self.tests[indexPath.row];
    PerformanceTestType type = [number integerValue];
    id<PerformanceTest> test = [[PerformanceTestManager sharedManager] performanceTestWithType:type];
    cell.textLabel.text = [NSString stringWithFormat:@"Test #%@", number];
    cell.detailTextLabel.text = [test name];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"choose-performance-test" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"choose-performance-test"]) {
        TestViewController *vc = segue.destinationViewController;
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        PerformanceTestType type = selectedIndexPath.row;
        vc.performanceTest = [[PerformanceTestManager sharedManager] performanceTestWithType:type];
    }
}


@end
