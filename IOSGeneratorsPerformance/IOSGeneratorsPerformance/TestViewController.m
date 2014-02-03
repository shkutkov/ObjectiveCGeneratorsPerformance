//
//  TestViewController.m
//  IOSGeneratorsPerformance
//
//  Created by Mikhail Shkutkov on 02/02/14.
//  Copyright (c) 2014 Mikhail Shkutkov. All rights reserved.
//

#import "TestViewController.h"
#import "TestRunnerViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) NSArray *implementations;

@end

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = [self.performanceTest name];
    self.implementations = @[@(kNoGeneratorImplementation),
                             @(kSMGeneratorSyncImplementation),
                             @(kSMGeneratorAsyncImplementation),
                             @(kMAGeneratorImplementation),
                             @(kExtCoroutineImplementation)];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.implementations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PerformanceTestImplementationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSNumber *number = self.implementations[indexPath.row];
    PerformanceTestImplemenationType type = [number integerValue];
    switch (type) {
        case kNoGeneratorImplementation:
            cell.textLabel.text = @"Without generator";
            break;
        case kSMGeneratorSyncImplementation:
            cell.textLabel.text = @"SMGenerator Sync";
            break;
        case kSMGeneratorAsyncImplementation:
            cell.textLabel.text = @"SMGenerator Async";
            break;
        case kMAGeneratorImplementation:
            cell.textLabel.text = @"MAGenerator";
            break;
        case kExtCoroutineImplementation:
            cell.textLabel.text = @"EXTCoroutine";
        break;
    }

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"run-test" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"run-test"]) {
        TestRunnerViewController *vc = segue.destinationViewController;
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        vc.navigationItem.title = [self.tableView cellForRowAtIndexPath:selectedIndexPath].textLabel.text;

        PerformanceTestImplemenationType type = selectedIndexPath.row;
        ExecutionBlock exBlock;
        switch (type) {
            case kNoGeneratorImplementation:
                exBlock = [self.performanceTest noGeneratorBlock];
                break;
            case kSMGeneratorSyncImplementation:
                exBlock = [self.performanceTest smGeneratorSyncBlock];
                break;
            case kSMGeneratorAsyncImplementation:
                exBlock = [self.performanceTest smGeneratorAsyncBlock];
                break;
            case kMAGeneratorImplementation:
                exBlock = [self.performanceTest maGeneratorBlock];
                break;
            case kExtCoroutineImplementation:
                exBlock = [self.performanceTest extCoroutineBlock];
                break;
        }
        
        vc.executionBlock = exBlock;
    }
}

@end
