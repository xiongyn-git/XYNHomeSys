//
//  XYNAnnotation.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/1.
//

#import "XYNAnnotation.h"

@implementation XYNAnnotation

-(id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle
                subTitle:(NSString *)paramSubitle {
    self = [super init];
    if(self != nil)
    {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubitle;
    }
    return self;
}

@end
