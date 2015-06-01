//
//  LRNumberKeyboard.h
//  LRNumberKeyboard
//
//  Created by 甘 立荣 on 14-9-4.
//  Copyright (c) 2014年 甘 立荣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRNumberKeyboardDelegate.h"

typedef void(^LRKeyboardInputBlock)(NSUInteger);
typedef void(^LRKeyboardDeleteBlock)(void);
typedef void(^LRKeyboardFinishBlock)(void);

@interface LRNumberKeyboard : UIView

@property (nonatomic,assign) id<LRNumberKeyboardDelegate> delegate;
@property (nonatomic, copy) LRKeyboardInputBlock inputBolck;
@property (nonatomic, copy) LRKeyboardDeleteBlock deleteBolck;
@property (nonatomic, copy) LRKeyboardFinishBlock finishBolck;

@end
