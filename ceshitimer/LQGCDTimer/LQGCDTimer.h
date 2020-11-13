//
//  LQGCDTimer.h
//  LQGCDTimer
//
//  Created by UED on 2020/11/13.
//

#import <Foundation/Foundation.h>

@interface LQGCDTimer : NSObject

+ (instancetype)shareHandler;

/// 自动开启定时器
/// @param mark 定时器标记
/// @param timeInterval 时间间隔
/// @param acceptable 误差范围
/// @param handler 回调
- (void)autoStartTimerWithMark:(NSString *)mark
                  timeInterval:(float)timeInterval
                    acceptable:(float)acceptable
                       handler:(void(^)(void))handler;

/// 手动开启定时器
/// @param mark 定时器标记
/// @param timeInterval 时间间隔
/// @param acceptable 误差范围
/// @param handler 回调
- (void)handStartTimerWithMark:(NSString *)mark
                  timeInterval:(float)timeInterval
                    acceptable:(float)acceptable
                       handler:(void(^)(void))handler;

/// 手动开启某定时器
/// @param mark 定时器标记
- (void)startWithMark:(NSString *)mark;

/// 停止某定时器
/// @param mark 定时器标记
- (void)stopTimerWithMark:(NSString *)mark;

/// 停止所有定时器
- (void)stopAllTimer;

/// 暂停某定时器
/// @param mark 定时器标记
- (void)suspendTimerWithMark:(NSString *)mark;

@end
