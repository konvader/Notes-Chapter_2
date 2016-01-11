//
//  LoginViewController.m
//  Notes
//
//  Created by Daniel Konrad on 25.12.15.
//  Copyright © 2015 Daniel Konrad. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.segmentedControl addTarget:self
                              action:@selector(segmentedControlTapped:)
                    forControlEvents:UIControlEventValueChanged];
}

- (void)segmentedControlTapped:(id)sender {
    [self updateView];
}

- (void)updateView {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:0.5f animations:^{
            self.loginView.alpha = 1.0f;
            self.signupView.alpha = 0.0f;
        }];
    } else {
        [UIView animateWithDuration:0.5f animations:^{
            self.loginView.alpha = 0.0f;
            self.signupView.alpha = 1.0f;
        }];
    }
}


#pragma mark - Actions

- (IBAction)loginAction {
    NSLog(@"LoginViewController - Login action");
    BAAClient *client = [BAAClient sharedClient];
    
    [client authenticateUser:self.loginUsernameField.text
                    password:self.loginPasswordField.text
                  completion:^(BOOL success, NSError *error) {
                      
                      if (success) {
                          NSLog(@"LoginViewController - User authenticated: %@", client.currentUser);
                          [self dismissViewControllerAnimated:YES completion:nil];
                      } else {
                          NSLog(@"LoginViewController - Error while logging in: %@", error);
                      }
                  }];
}

- (IBAction)signupAction {
    NSLog(@"LoginViewController - Signup action");
    BAAClient *client = [BAAClient sharedClient];
    
    [client createUserWithUsername:self.signupUsernameField.text
                          password:self.signupPasswordField.text
                        completion:^(BOOL success, NSError *error) {
                            
                            if (success) {
                                NSLog(@"LoginViewController - User created %@", client.currentUser);
                                [self dismissViewControllerAnimated:YES completion:nil];
                            } else {
                                NSLog(@"LoginViewController - Error in creating user: %@", error);
                            }
                        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
