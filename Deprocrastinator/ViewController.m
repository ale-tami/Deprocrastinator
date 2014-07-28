//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Alejandro Tami on 28/07/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *addItemTextView;

@property (strong, nonatomic) NSMutableArray * todosArray;
@property BOOL isEditing;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.todosArray =  [NSMutableArray arrayWithObjects:
                        @"Have fun",
                        @"Stop Having Fun",
                        @"Conquer the world",
                        @"Become a supervillain",
                        nil];
    
    self.isEditing = NO;

}

#pragma mark Actions

- (IBAction)onAddButtonPressed:(id)sender
{
    
    [self.addItemTextView resignFirstResponder];
    [self.todosArray addObject:self.addItemTextView.text];
    [self.tableView reloadData];
    
    self.addItemTextView.text = @"";
    
}

- (IBAction)onEditButtonPressed:(UIButton*)sender {
    
    
    [sender setTitle:@"Done" forState:UIControlStateHighlighted];
    self.isEditing = YES;
    
}

#pragma mark datasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.todosArray.count ;
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.textLabel.text = [self.todosArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *thyCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.isEditing) {
        
        NSArray *deleteArray = [NSArray arrayWithObject:indexPath];
        [self.todosArray removeObject: thyCell.textLabel.text];
        [tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        
        thyCell.textLabel.textColor = [UIColor greenColor];
        
    }
    
    
    
}


@end
