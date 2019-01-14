//
//  AirBubbleView.m
//  AirBubbles
//
//  Created by HanYong on 2019/1/14.
//  Copyright © 2019年 com.hanyong. All rights reserved.
//

#define SIDELENGTH 6.0
#define TRIANGLE 7.0

#import "AirBubbleView.h"

@interface AirBubbleView ()

@property (nonatomic,assign) CGFloat pointX;//角标位置

@end

@implementation AirBubbleView

#pragma mark - private method
- (void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawTriangle:ctx andRect:rect];
    [self drawRectangle:ctx andRect:rect];
}

//画三角形
-(void)drawTriangle:(CGContextRef)ctx andRect:(CGRect)rect{
    
    [[UIColor grayColor] set];
    CGContextMoveToPoint(ctx, self.pointX, 0.0);
    CGPoint sPoints[3];//坐标点
    
    sPoints[0] = CGPointMake(self.pointX, 0);//坐标1
    sPoints[1] = CGPointMake(self.pointX - SIDELENGTH, TRIANGLE);//坐标2
    sPoints[2] = CGPointMake(self.pointX + SIDELENGTH, TRIANGLE);//坐标3
    
    CGContextAddLines(ctx, sPoints, 3);//添加线
    CGContextDrawPath(ctx, kCGPathFillStroke); //根据坐标绘制路径
}

//画矩形
-(void)drawRectangle:(CGContextRef)ctx andRect:(CGRect)rect{
    CGRect rectangleRect;
    
    rectangleRect = CGRectMake(0, TRIANGLE, rect.size.width, rect.size.height-TRIANGLE);
    
    //圆角效果
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rectangleRect cornerRadius:6.0f];
    [[UIColor grayColor] setFill];
    [roundedRect fillWithBlendMode:kCGBlendModeNormal alpha:1];
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString*)text pointX:(CGFloat)point{
    
    self.pointX = point;
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        //文字
        UILabel *label = [[UILabel alloc] init];
        label.text = text;
        label.numberOfLines = 0;
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:15];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentLeft;
        
        //label的最大size
        CGSize size = CGSizeMake(self.frame.size.width - 30,500);
        
        //计算文字内容的真实size
        CGSize labelsize = [self sizeForNoticeTitle:text font:15 size:size];
        
        [self addSubview:label];
        
        label.frame = CGRectMake(15, 15, labelsize.width, labelsize.height);
        
        self.frame  = CGRectMake(self.frame.origin.x, self.frame.origin.y, frame.size.width, label.frame.size.height+30);
        
        label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+3);
    }
    return self;
}

- (CGSize)sizeForNoticeTitle:(NSString*)text font:(CGFloat)font size:(CGSize)size {
    
    UIFont *textFont = [UIFont systemFontOfSize:font];
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : textFont, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [text boundingRectWithSize:size
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        
        rect.size.width = ceil(rect.size.width); // 取整数
        rect.size.height = ceil(rect.size.height);
        textSize = rect.size;
        
    } else {
        
        textSize = [text sizeWithFont:textFont constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return textSize;
}


@end
