//
//  OCCallJsViewController.m
//  JS&OCDemo
//
//  Created by Daniel on 16/6/21.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "OCCallJsViewController.h"

@interface OCCallJsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UILabel *showResultLab;

@end

@implementation OCCallJsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _context = [[JSContext alloc] init];
    [self.context evaluateScript:[self loadJsFile:@"test"]];
    
    _context[@"alert"] = ^(NSString *str) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:str otherButtonTitles: nil];
        [alert show];
    };
}

- (NSString *)loadJsFile:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"js"];
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"jsScript -- %@", jsScript);
    return jsScript;
}

- (IBAction)star:(id)sender {
    NSNumber *inputNum = [NSNumber numberWithInteger:[self.inputField.text integerValue]];
    
    JSValue *function = [self.context objectForKeyedSubscript:@"factorialOptimize"];
    JSValue *result = [function callWithArguments:@[inputNum, @(1)]];
    self.showResultLab.text = [NSString stringWithFormat:@"%@", [result toNumber]];
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
