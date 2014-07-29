//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Alejandro Tami on 28/07/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *addItemTextView;

@property (strong, nonatomic) NSMutableArray * todosArray;
@property (strong, nonatomic) NSMutableArray * greenOnesArray;
@property (strong, nonatomic) UIAlertView * alertView;
@property BOOL isEditing;
@property (strong, nonatomic) NSIndexPath * indexpathToDelete;


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
    
    self.alertView = [[UIAlertView alloc]init];
    self.alertView.delegate = self;
    self.alertView.title = @"Delete item?";
    [self.alertView addButtonWithTitle:@"Yes"];
    [self.alertView addButtonWithTitle:@"Nnnnope"];
    
    self.greenOnesArray = [[NSMutableArray alloc] init];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self deleteItem];
    }
}

- (void) deleteItem
{
    [self.todosArray removeObject: [self.tableView cellForRowAtIndexPath:self.indexpathToDelete].textLabel.text];
    [self.greenOnesArray removeObject: [self.tableView cellForRowAtIndexPath:self.indexpathToDelete]];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.indexpathToDelete] withRowAnimation:UITableViewRowAnimationFade];

}

#pragma mark Actions

- (IBAction)onAddButtonPressed:(id)sender
{
    
    [self.addItemTextView resignFirstResponder];
    [self.todosArray addObject:self.addItemTextView.text];
    [self.tableView reloadData];
    
    self.addItemTextView.text = @"";
    
}

- (IBAction)onEditButtonPressed:(UIButton*)sender
{
    
    if (self.isEditing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
        self.isEditing = NO;
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self.tableView setEditing:YES animated:YES];
        self.isEditing = YES;
    }

}

- (IBAction)onSwipe:(UISwipeGestureRecognizer*)sender
{
    CGPoint point = [sender locationInView:self.tableView];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:point]];
    
    if (cell) {
        
        if (cell.textLabel.textColor == [UIColor redColor]) {
            cell.textLabel.textColor = [UIColor yellowColor];
        }else if (cell.textLabel.textColor == [UIColor yellowColor]){
            cell.textLabel.textColor = [UIColor blueColor]; //green is for completed to dos
        } else {
            cell.textLabel.textColor = [UIColor redColor];
        }
    
    }
    
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
    
    if ( [self.greenOnesArray containsObject: cell] ) {
        cell.textLabel.textColor = [UIColor greenColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexpathToDelete = indexPath;
    [self.alertView show];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = self.todosArray[sourceIndexPath.row];
    [self.todosArray removeObjectAtIndex:sourceIndexPath.row];
    [self.todosArray insertObject:stringToMove atIndex:destinationIndexPath.row];
}

#pragma mark delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *thyCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.isEditing) {
        
        self.indexpathToDelete = indexPath;
        [self.alertView show];
//        NSArray *deleteArray = [NSArray arrayWithObject:indexPath];
//        [self.todosArray removeObject: thyCell.textLabel.text];
//        [tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        
        thyCell.textLabel.textColor = [UIColor greenColor];
        [self.greenOnesArray addObject:thyCell];
        
    }
    
}


@end
