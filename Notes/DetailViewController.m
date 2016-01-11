//
//  DetailViewController.m
//  Notes
//
//  Created by Daniel Konrad on 20.12.15.
//  Copyright © 2015 Daniel Konrad. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    Note *_note;
}

- (void)configureView;

@end

@implementation DetailViewController


#pragma mark - Managing the detail note

- (void)setNote:(Note *)note {
    if (_note != note) {
        _note = note;
        [self configureView];
    }
}

- (Note *)note {
    return _note;
}

- (void)configureView {
    self.noteHeaderField.text = self.note.noteHeader;
    self.noteBodyTextView.text = self.note.noteBody;
    self.noteDate = self.note.noteDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view, typically from a nib.
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 5.0f, 20.0f)];
    self.noteHeaderField.leftView = paddingView;
    self.noteHeaderField.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNote:)];
    
    [self configureView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.noteHeaderField becomeFirstResponder];
}

- (void)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveNote:(id)sender {
    self.note.noteHeader = self.noteHeaderField.text;
    self.note.noteBody = self.noteBodyTextView.text;
    
    [self.note saveObjectWithCompletion:^(id object, NSError *error) {
        if (object) {
            NSLog(@"Detail View Controller - Object saved");
            self.note = object;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"POST_UPDATED"
                                                                object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"Detail View Controller - Error in saving: %@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
