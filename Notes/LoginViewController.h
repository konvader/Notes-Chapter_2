//
//  LoginViewController.h
//  Notes
//
//  Created by Daniel Konrad on 25.12.15.
//  Copyright © 2015 Daniel Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak) IBOutlet UIView *loginView;
@property (weak) IBOutlet UIView *signupView;
@property (weak) IBOutlet UISegmentedControl *segmentedControl;

@property (weak) IBOutlet UITextField *loginUsernameField;
@property (weak) IBOutlet UITextField *loginPasswordField;

@property (weak) IBOutlet UITextField *signupUsernameField;
@property (weak) IBOutlet UITextField *signupPasswordField;

- (IBAction) loginAction;
- (IBAction) signupAction;

@end
