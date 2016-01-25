//
//  Note.h
//  Notes
//
//  Created by Daniel Konrad on 31.12.15.
//  Copyright © 2015 Daniel Konrad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : BAAObject

@property (nonatomic, copy) NSString *noteTitle;
@property (nonatomic, copy) NSString *noteBody;
@property (nonatomic, copy) NSString *noteDate;

@end
