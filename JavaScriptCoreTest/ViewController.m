//
//  ViewController.m
//  JavaScriptCoreTest
//
//  Created by RipperLiew on 2023/1/30.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.jsContext = [JSContext new];
    [self test_JS];
}

- (void)test_JS {
    JSValue *value = [self.jsContext evaluateScript:@"2 + 2"];
    NSLog(@"%d", value.toInt32);
}

@end
