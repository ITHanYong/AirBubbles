//
//  AirBubbleView.h
//  AirBubbles
//
//  Created by HanYong on 2019/1/14.
//  Copyright © 2019年 com.hanyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirBubbleView : UIView

/** 初始化
 @param frame 气泡的frame
 @param text 文字
 @param position 尖角位置
 @return An initialized view object.
 */


- (instancetype)initWithFrame:(CGRect)frame text:(NSString*)text pointX:(CGFloat)point;


@end
