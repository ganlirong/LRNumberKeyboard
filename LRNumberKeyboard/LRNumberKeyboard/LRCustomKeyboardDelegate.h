//
//  LRNumberKeyboardDelegate.h
//  LRNumberKeyboard
//
//  Created by 甘 立荣 on 14-9-4.
//  Copyright (c) 2014年 甘 立荣. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LRCustomKeyboardDelegate <NSObject>

@optional
/**
 *  键盘按钮被点击时
 *
 *  @param number 点击的数字
 */
- (void) numberKeyboardInput:(NSInteger)number;

/**
 *  删除键被点击时
 */
- (void) numberKeyboardDelete;

/**
 *  完成键被点击时
 */
- (void) numberKeyboardFinish;

@end
