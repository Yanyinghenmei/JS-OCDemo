//
//  ViewController.h
//  JS&OCDemo
//
//  Created by Daniel on 16/5/27.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestJSExport <JSExport>

JSExportAs
(calculateForJs,
- (void)calculateWithNumber:(NSNumber *)number
);

@end

@interface ViewController : UIViewController<TestJSExport,UIWebViewDelegate>

@property (nonatomic, strong)JSContext *context;
@end

