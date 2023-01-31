//
//  ViewController.m
//  JavaScriptCoreTest
//
//  Created by RipperLiew on 2023/1/30.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import "MyPoint.h"

@interface ViewController ()

@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.jsContext = [JSContext new];
    
//    [self test_JS];
//    [self test_JS_function];
//    [self test_JS_block];
//    [self test_distance_function];
    [self test_middlePoint_function];
}

- (void)test_JS {
    JSValue *value = [self.jsContext evaluateScript:@"2 + 2"];
    NSLog(@"%d", value.toInt32);
}

- (void)test_JS_function {
    NSString *jsCode = [self loadTestJSFileStr];
    [self.jsContext evaluateScript:jsCode];
    JSValue *function = self.jsContext[@"put"];
//    JSValue *result = [function callWithArguments:@[]];
    JSValue *result = [function callWithArguments:@[@"test"]];
    NSLog(@"%@", result.toString);
}

- (void)test_JS_block {
    UIColor* (^block)(NSDictionary *) = ^(NSDictionary *dic) {
        float r = [dic[@"red"] floatValue];
        float g = [dic[@"green"] floatValue];
        float b = [dic[@"blue"] floatValue];
        
        return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    };
    self.jsContext[@"makeNSColor"] = block;
    
    NSString *jsCode = [self loadTestJSFileStr];
    [self.jsContext evaluateScript:jsCode];
    
    JSValue *function = self.jsContext[@"colorForWord"];
    JSValue *result = [function callWithArguments:@[@"blue"]];
    self.view.backgroundColor = (UIColor *)result.toObject;
}

- (void)test_distance_function {
    NSString *jsCode = [self loadPointTestJSFileStr];
    [self.jsContext evaluateScript:jsCode];
    JSValue *function = self.jsContext[@"euclideanDistance"];

    MyPoint *p1 = [[MyPoint alloc] initWithX:0.0 Y:0.0];
//    MyPoint *p2 = [[MyPoint alloc] initWithX:1.0 Y:1.0];
    MyPoint *p2 = [[MyPoint alloc] initWithX:1.0 Y:0.0];
    JSValue *result = [function callWithArguments:@[p1, p2]];
    NSLog(@"%@", result.toString);
}

- (void)test_middlePoint_function {
    self.jsContext[@"MyPoint"] = [MyPoint class];
    
    NSString *jsCode = [self loadPointTestJSFileStr];
    [self.jsContext evaluateScript:jsCode];
    JSValue *function = self.jsContext[@"midpoint"];

    MyPoint *p1 = [[MyPoint alloc] initWithX:0.0 Y:0.0];
//    MyPoint *p2 = [[MyPoint alloc] initWithX:1.0 Y:1.0];
    MyPoint *p2 = [[MyPoint alloc] initWithX:1.0 Y:0.0];
    JSValue *result = [function callWithArguments:@[p1, p2]];
    MyPoint *mP = result.toObject;
    NSLog(@"%@", mP);
}

- (NSString *)loadTestJSFileStr {
    NSString * jsCode = [self loadJSFileStrWithFileName:@"test"];
    return jsCode;
}

- (NSString *)loadPointTestJSFileStr {
    NSString * jsCode = [self loadJSFileStrWithFileName:@"geometryScript"];
    return jsCode;
}

- (NSString *)loadJSFileStrWithFileName:(NSString *)name {
    NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:@"js"];
    NSData * jsData = [[NSData alloc]initWithContentsOfFile:path];
    NSString * jsCode = [[NSString alloc]initWithData:jsData encoding:NSUTF8StringEncoding];
    return jsCode;
}

@end
