//
//  LQGCDTimer.m
//  LQGCDTimer
//
//  Created by UED on 2020/11/13.
//

#import "LQGCDTimer.h"

@interface LQGCDTimer ()

@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic, strong) NSMapTable *mapTable;

@end

@implementation LQGCDTimer

+ (instancetype)shareHandler {
    static LQGCDTimer *timer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timer = [LQGCDTimer alloc];
        timer.queue = dispatch_queue_create("LQGCDTimer", DISPATCH_QUEUE_CONCURRENT);
        timer.mapTable = [[NSMapTable alloc] init];
    });
    return timer;
}

- (void)autoStartTimerWithMark:(NSString *)mark timeInterval:(float)timeInterval acceptable:(float)acceptable handler:(void (^)(void))handler {
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    dispatch_source_set_timer(source, DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC, acceptable * NSEC_PER_SEC);
    dispatch_source_set_event_handler(source, handler);
    dispatch_resume(source);
    [self.mapTable setObject:source forKey:mark];
}

- (void)stopTimerWithMark:(NSString *)mark {
    dispatch_source_t source = [self.mapTable objectForKey:mark];
    if (source) {
        dispatch_cancel(source);
    }
    [self.mapTable removeObjectForKey:mark];
}

- (void)suspendTimerWithMark:(NSString *)mark {
    dispatch_source_t source = [self.mapTable objectForKey:mark];
    if (source) {
        dispatch_suspend(source);
    }
}

- (void)stopAllTimer {
    for (NSString *mark in self.mapTable) {
        dispatch_source_t source = [self.mapTable objectForKey:mark];
        if (source) {
            dispatch_cancel(source);
        }
    }
    [self.mapTable removeAllObjects];
}

- (void)handStartTimerWithMark:(NSString *)mark timeInterval:(float)timeInterval acceptable:(float)acceptable handler:(void (^)(void))handler {
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    dispatch_source_set_timer(source, DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC, acceptable * NSEC_PER_SEC);
    dispatch_source_set_event_handler(source, handler);
    [self.mapTable setValue:source forKey:mark];
}

- (void)startWithMark:(NSString *)mark {
    dispatch_source_t source = [self.mapTable objectForKey:mark];
    if (source) {
        dispatch_resume(source);
    }
}

@end
