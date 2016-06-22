//
//  ViewController.m
//  JS&OCDemo
//
//  Created by Daniel on 16/5/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "OCCallJsViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:.4f];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    NSString *httpStr = [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"JSCoreDemo.html"];
    NSURL *httpUrl = [NSURL URLWithString:httpStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:httpUrl];
    [webView loadRequest:request];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 100, 44)];
    [btn setTitle:@"oc-call-js" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [webView addSubview:btn];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    _context[@"native"] = self;
    
    // js call oc
    _context[@"log"] = ^(NSString *str) {
        NSLog(@"log--%@", str);
    };
    
    _context[@"mutiParams"] = ^(NSString *str1, NSString *str2, NSString *str3) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:str1 message:str2 delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:str3, nil];
        [aler show];
    };
    
}

- (void)calculateWithNumber:(NSNumber *)number {
    NSLog(@"输入的数字--%@", number);
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)btnClick:(UIButton *)btn {
    [self presentViewController:[OCCallJsViewController new] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
