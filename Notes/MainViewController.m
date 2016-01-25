//
//  MainViewController.m
//  Notes
//
//  Created by Daniel Konrad on 26.12.15.
//  Copyright © 2015 Daniel Konrad. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "Note.h"
#import "DetailViewController.h"

@interface MainViewController () {
    NSMutableArray *_notes;
}

@end

@implementation MainViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutUser:)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewNote:)];
    
    self.navigationItem.leftBarButtonItem = logoutButton;
    self.navigationItem.rightBarButtonItem = addButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"NOTE_UPDATED" object:nil];
}

- (void)reload {
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BAAClient *client = [BAAClient sharedClient];
    
    if (client.isAuthenticated) {
        NSLog(@"Main View Controller - User logged in");
        [Note getObjectsWithCompletion:^(NSArray *objects, NSError *error) {
            if (error == nil) {
                _notes = [objects mutableCopy];
                [self.tableView reloadData];
            }
        }];
    } else {
        NSLog(@"Main View Controller - Need to login/signup user");
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController presentViewController:loginViewController
                                                animated:YES
                                              completion:nil];
    }
}

- (void)createNewNote:(id)sender {
    if (!_notes) {
        _notes = [[NSMutableArray alloc] init];
    }
    
    Note *note = [[Note alloc] init];
    note.noteTitle = [NSString stringWithFormat:@"Enter title %lu", (unsigned long)_notes.count];
    note.noteBody = @"Enter your note here";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    note.noteDate = dateString;
    
    [note saveObjectWithCompletion:^(Note *note, NSError *error) {
        if (error == nil) {
            NSLog(@"Main View Controller - Created note on server: %@", note);
            
            [_notes insertObject:note atIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0
                                                        inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            NSLog(@"Main View Controller - Error while saving note: %@", error);
        }
    }];
}

- (void)logoutUser:(id)sender {
    [BAAUser logoutWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"Main View Controller - Successfully logged out");
            _notes = nil;
            LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController presentViewController:loginViewController
                                                    animated:YES
                                                  completion:nil];
        } else {
            NSLog(@"Main View Controller - Error while logging out: %@", error.description);
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Note *note = _notes[indexPath.row];
    cell.textLabel.text = note.noteTitle;
    cell.detailTextLabel.text = note.noteDate;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Segue identifier, %@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Note *object = _notes[indexPath.row];
        [[segue destinationViewController] setNote:object];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
