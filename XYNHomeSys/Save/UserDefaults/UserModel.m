//
//  UserModel.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/13.
//

#import "UserModel.h"

@interface UserModel()<NSSecureCoding>

@end

@implementation UserModel

+ (BOOL)supportsSecureCoding {
    return YES;;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    NSLog(@"归档");
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.age forKey:@"age"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if(self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeIntegerForKey:@"age"];
    }
    return self;
}


@end
