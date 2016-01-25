//
//  DetailViewController.h
//  Notes
//
//  Created by Daniel Konrad on 20.12.15.
//  Copyright © 2015 Daniel Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface DetailViewController : UIViewController

@property (weak) IBOutlet UITextField *noteTitleTextField;
@property (weak) IBOutlet UITextView *noteBodyTextView;
@property (weak) NSString *noteDate;

- (void)setNote:(Note *)note;

@end
