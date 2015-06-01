//
//  LRNumberKeyboard.m
//  LRNumberKeyboard
//
//  Created by 甘 立荣 on 14-9-4.
//  Copyright (c) 2014年 甘 立荣. All rights reserved.
//

#import "LRNumberKeyboard.h"

#define kLineWidth 1
#define kNumberFont [UIFont systemFontOfSize:28]
#define COLOR_RGB(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

//定义设备屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//定义设备屏幕的宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

static const NSUInteger kFinishButtonTag = 10;
static const NSUInteger kZeroButtonTag = 11;
static const NSUInteger kDelegateButtonTag = 12;
static const CGFloat kKeyboardHeight = 216;
static const CGFloat kKeyboardButtonHeight = 54;

@implementation LRNumberKeyboard

- (id)init {
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, ScreenWidth, kKeyboardHeight);
        for (int i = 0; i < 4; i++){
            for (int j = 0; j < 3; j++){
                UIButton *button = [self creatButtonWithX:i Y:j];
                [self addSubview:button];
            }
            
        }
        
        UIColor *color = COLOR_RGB(188, 192, 199);
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(105, 0, kLineWidth, kKeyboardHeight)];
        line1.backgroundColor = color;
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(214, 0, kLineWidth, kKeyboardHeight)];
        line2.backgroundColor = color;
        [self addSubview:line2];
        
        for (int i = 0; i < 3; i++){
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kKeyboardButtonHeight*(i + 1), ScreenWidth, kLineWidth)];
            line.backgroundColor = color;
            [self addSubview:line];
            
        }
        
    }
    
    return self;
}

/**
 *  创建键盘数字按钮
 *
 *  @param x 列
 *  @param y 行
 *
 *  @return 返回相应的按钮
 */
-(UIButton *)creatButtonWithX:(NSInteger) x Y:(NSInteger) y
{
    CGFloat frameX = 0;
    CGFloat frameW = 0;
    
    switch (y){
        case 0:{
            frameX = 0.0;
            frameW = 106.0;
        }
            break;
            
        case 1:{
            frameX = 105.0;
            frameW = 110.0;
        }
            break;
            
        case 2:{
            frameX = 214.0;
            frameW = 106.0;
        }
            break;
            
        default:
            break;
    }
    
    CGFloat frameY = kKeyboardButtonHeight*x;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(frameX, frameY, frameW, kKeyboardButtonHeight)];
    NSInteger number = y + 3*x + 1;
    button.tag = number;
    [button addTarget:self
               action:@selector(clickButton:)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIColor *colorNormal = COLOR_RGB(252, 252, 252);
    UIColor *colorHightlighted = COLOR_RGB(186, 189, 194);
    if (number == 10 || number == 12){
        UIColor *colorTemp = colorNormal;
        colorNormal = colorHightlighted;
        colorHightlighted = colorTemp;
    }
    
    button.backgroundColor = colorNormal;
    CGSize imageSize = CGSizeMake(frameW, kKeyboardButtonHeight);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorHightlighted set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setImage:pressedColorImg forState:UIControlStateHighlighted];
    
    //创建0-9键盘数字
    if (number < 10){
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        numberLabel.text = [NSString stringWithFormat:@"%zd",number];
        numberLabel.textColor = [UIColor blackColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = kNumberFont;
        [button addSubview:numberLabel];
        
    } else if (number == 11){
        
        UILabel *zerolabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        zerolabel.text = @"0";
        zerolabel.textColor = [UIColor blackColor];
        zerolabel.textAlignment = NSTextAlignmentCenter;
        zerolabel.font = kNumberFont;
        [button addSubview:zerolabel];
        
    }else if (number == 10){
        
        UILabel *finishlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        finishlabel.text = @"完成";
        finishlabel.textColor = [UIColor blackColor];
        finishlabel.textAlignment = NSTextAlignmentCenter;
        [button addSubview:finishlabel];
        
    } else {
        
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(42, 19, 22, 17)];
        arrow.image = [UIImage imageNamed:@"arrowInKeyboard.png"];
        [button addSubview:arrow];
        
    }
    
    return button;
    
}

/**
 *  数字键点击事件
 *
 *  @param sender
 */
-(void)clickButton:(UIButton *)button{
    
    if (button.tag == kFinishButtonTag){
        if ([self.delegate respondsToSelector:@selector(numberKeyboardFinish)]) {
            [self.delegate numberKeyboardFinish];
        }
        if (_finishBolck) {
            _finishBolck();
        }
        return;
    } else if (button.tag == kDelegateButtonTag){
        if ([self.delegate respondsToSelector:@selector(numberKeyboardDelete)]) {
            [self.delegate numberKeyboardDelete];;
        }
        if (_deleteBolck) {
            _deleteBolck();
        }
    } else {
        NSUInteger number = button.tag;
        if (button.tag == kZeroButtonTag){
            number = 0;
        }
        if ([self.delegate respondsToSelector:@selector(numberKeyboardDelete)]) {
            [self.delegate numberKeyboardInput:number];
        }
        if (_inputBolck) {
            _inputBolck(number);
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
