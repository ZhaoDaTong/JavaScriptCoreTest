//
//  MyPoint.m
//  JavaScriptCoreTest
//
//  Created by RipperLiew on 2023/1/30.
//1

#import "MyPoint.h"
#import "MyPointExports.h"

@interface MyPoint () <MypointExports>

@end

@implementation MyPoint
@synthesize x = _x;
@synthesize y = _y;

- (instancetype)initWithX:(double)x
                        Y:(double)y {
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

+ (id)makePointWithX:(double)x Y:(double)y {
    MyPoint *point = [[MyPoint alloc] initWithX:x Y:y];
    return point;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%p %f %f", self, self.x, self.y];
}

@end
