//
//  InputBar.h
//  STDG
//
//  Created by 翟涛 on 14-4-2.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//
@class  InputBar;
@protocol InputBarDelegate <NSObject>

- (void)inputBar:(InputBar*) inputBar sendBtnPress:(UIButton*)sendBtn withInputString:(NSString*)str;

@end

@interface InputBar : UIView

//代理 用于传递btn事件
@property(assign,nonatomic)id<InputBarDelegate> delegate;
//这两个可以自己付值
@property(strong,nonatomic)UITextField *textField;
@property(strong,nonatomic)UIButton *sendBtn;

//点击btn时候 清空textfield  默认NO
@property(assign,nonatomic)BOOL clearInputWhenSend;
//点击btn时候 隐藏键盘  默认NO
@property(assign,nonatomic)BOOL resignFirstResponderWhenSend;

//初始frame
@property(assign,nonatomic)CGRect originalFrame;

//隐藏键盘
-(BOOL)resignFirstResponder;

@end
