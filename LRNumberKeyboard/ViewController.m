//
//  ViewController.m
//  LRNumberKeyboard
//
//  Created by 甘立荣 on 15/6/1.
//  Copyright (c) 2015年 甘立荣. All rights reserved.
//

#import "ViewController.h"
#import "LRNumberKeyboard.h"

//定义设备屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//定义设备屏幕的宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<LRNumberKeyboardDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LRNumberKeyboard *keyboard = [[LRNumberKeyboard alloc] init];
    keyboard.delegate = self;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.tag = 10009;
    textField.frame = CGRectMake(50, 100, ScreenWidth - 100, 30);
    textField.placeholder = @"custom keyboard";
    textField.inputView = keyboard;
    textField.font = [UIFont systemFontOfSize:14];
    textField.clearsOnBeginEditing = YES;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
}

/**
 *  完成按钮
 */
-(void)numberKeyboardFinish{
    UITextField *textField = (UITextField *)[self.view viewWithTag:10009];
    [textField resignFirstResponder];
}

-(void)numberKeyboardDelete{
    
    UITextField *textField = (UITextField *)[self.view viewWithTag:10009];
    
    if ([textField isFirstResponder]) {
        if (textField.text.length != 0) {
            textField.text = [textField.text substringToIndex:textField.text.length -1];
        }
    }
}

-(void)numberKeyboardInput:(NSInteger)number{
    
    UITextField *textField = (UITextField *)[self.view viewWithTag:10009];
    
    if ([textField isFirstResponder]) {
        textField.text = [textField.text stringByAppendingString:[NSString stringWithFormat:@"%zd",number]];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
