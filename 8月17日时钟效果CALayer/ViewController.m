//
//  ViewController.m
//  8月17日时钟效果CALayer
//
//  Created by 李景浩 on 16/8/17.
//  Copyright © 2016年 李大米. All rights reserved.
//

#import "ViewController.h"

#define angle2Rad(angle) ((angle)/180.0 * M_PI)
//每一秒旋转6度
#define perSecond 6
//每一分转动6度
#define perMinute 6
//每一小时转动30度
#define perHour 30
//每转动一分钟，时针转动多少。60分钟一小时转动30度，即每分钟时针转动：30/60 = 0.5
#define perMinHour 0.5
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockView;

@property(weak,nonatomic)CALayer *secondL;
@property(weak,nonatomic)CALayer *minuteL;
@property(weak,nonatomic)CALayer *hourL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    调用时针
    [self hourB];
//    调用分针
    [self minuteB];
//    调用秒针
    [self secondB];
    
//    获取显示时间
    [self uppTime];
//    让指针动起来
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(uppTime) userInfo:nil repeats:YES];
}

/**
 *  获取时间
 */
-(void)uppTime{
#pragma  用日历calendar获取年月日时分秒等
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calender components:NSCalendarUnitSecond |NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
//    获取秒
    NSInteger currSec = cmp.second;
//    获取分
    NSInteger currMin = cmp.minute;
//    获取时
    NSInteger currHour = cmp.hour;
    
#pragma 秒，当前时间 * 每一秒的角度
    CGFloat angle = currSec * perSecond;
    self.secondL.transform = CATransform3DMakeRotation(angle2Rad(angle), 0, 0, 1);
    
//    使分针转动
    CGFloat minAngle = currMin * perMinute;
    self.minuteL.transform = CATransform3DMakeRotation(angle2Rad(minAngle), 0, 0, 1);
    
//    使时针转动 .时针本身转动的角度 + 每一分钟时针转动的角度
    CGFloat hourAngle = currHour * perHour + currMin * perMinHour;
    self.hourL.transform = CATransform3DMakeRotation(angle2Rad(hourAngle), 0, 0, 1);
    
}

/**
 *  创建秒针
 */
-(void)secondB{
//关闭动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CALayer *layer = [CALayer layer];
    
    layer.bounds = CGRectMake(0, 0, 1, 80);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(self.clockView.bounds.size.width * 0.5, self.clockView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.secondL = layer;
//    注意，别搞错了，是添加在这个图片上的
    [self.clockView.layer addSublayer:layer];
    
    [CATransaction commit];
    
}
/**
 *  创建分针
 */
-(void)minuteB{

    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 1, 70);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.position = CGPointMake(self.clockView.bounds.size.width * 0.5, self.clockView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    self.minuteL = layer;
    [self.clockView.layer addSublayer:layer];
}
/**
 *  创建小时针
 */
-(void)hourB{
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 1, 55);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.position = CGPointMake(self.clockView.bounds.size.width * 0.5, self.clockView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    self.hourL = layer;
    [self.clockView.layer addSublayer:layer];
    
    
}

@end
