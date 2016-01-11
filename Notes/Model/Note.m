//
//  Note.m
//  Notes
//
//  Created by Daniel Konrad on 31.12.15.
//  Copyright © 2015 Daniel Konrad. All rights reserved.
//

#import "Note.h"

@implementation Note

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        _noteHeader = dictionary[@"noteHeader"];
        _noteBody = dictionary[@"noteBody"];
        _noteDate = dictionary[@"noteDate"];
    }
    
    return self;
}

- (NSString *)collectionName {
    return @"document/notes";
}

@end
