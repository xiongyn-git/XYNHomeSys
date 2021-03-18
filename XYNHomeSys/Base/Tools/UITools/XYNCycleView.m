//
//  XYNCycleView.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/14.
//

#import "XYNCycleView.h"

@implementation XYNCycleView
- (instancetype)initWithFrame:(CGRect)frame style:(XYNCycleViewStyle)style {
    self = [super initWithFrame:frame];
    if(self) {
        
    }
    return self;
}

#pragma mark - protocol NSCoding

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    NSNumber *scale = [aDecoder decodeObjectForKey:@"YYImageScale"];
//    NSData *data = [aDecoder decodeObjectForKey:@"YYImageData"];
//    if (data.length) {
//        self = [self initWithData:data scale:scale.doubleValue];
//    } else {
//        self = [super initWithCoder:aDecoder];
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    if (_decoder.data.length) {
//        [aCoder encodeObject:@(self.scale) forKey:@"YYImageScale"];
//        [aCoder encodeObject:_decoder.data forKey:@"YYImageData"];
//    } else {
//        [super encodeWithCoder:aCoder]; // Apple use UIImagePNGRepresentation() to encode UIImage.
//    }
//}
@end

@implementation XYNCycleViewItem



@end
