//
//  XYHealthKitTool.m
//  myApp
//
//  Created by 渠晓友 on 2020/5/21.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import "XYHealthKitTool.h"
#import <HealthKit/HealthKit.h>
#import <objc/runtime.h>

@interface XYHealthKitTool ()

@end

@implementation XYHealthKitTool

#pragma mark - private

+ (HKHealthStore *)healthStore
{
    static void *const App_HealthKey = "App_HealthKey";
    
    UIApplication *app = [UIApplication sharedApplication];
    HKHealthStore * healthStore = objc_getAssociatedObject(app, App_HealthKey);
    
    if (healthStore) {
        return healthStore;
    }else
    {
        HKHealthStore *healthStore = HKHealthStore.new;
        objc_setAssociatedObject(app, App_HealthKey, healthStore, OBJC_ASSOCIATION_RETAIN);
        return healthStore;
    }
}

+ (void)getStepCountWithHandler:(StepCountHandler)handler {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
     
    NSDate *now = [NSDate date];
     
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
     
    NSDate *startDate = [calendar dateFromComponents:components];
     
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
     
    HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
     
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!results) {
//                NSLog(@"An error occured fetching the user's tracked food. In your app, try to handle this gracefully. The error was: %@.", error);
//                abort();
                if (handler) {
                    handler(0,error);
                }
                return ;
            }
     
            NSInteger totalSteps = 0;
            for (HKQuantitySample *sample in results) {
                totalSteps += [sample.quantity doubleValueForUnit:[HKUnit countUnit]];
            }
            
            if (handler) {
                handler(totalSteps,nil);
            }
        });
    }];
     
    [[self healthStore] executeQuery:query];
}

#pragma mark - public

+ (void)getTodayTotalStepCountHandler:(StepCountHandler)handler
{
    if ([HKHealthStore isHealthDataAvailable]){
        
        // 确定当前是否可用
        
        // 请求状态
        HKObjectType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:type];
        if (status == HKAuthorizationStatusNotDetermined) {
            
            // 首次未请求
            NSSet *types = [[NSSet alloc] initWithObjects:type, nil];
            [self.healthStore requestAuthorizationToShareTypes:types readTypes:types completion:^(BOOL success, NSError * _Nullable error) {
              
                if (success) {
                    // 请求步数
                    [self getStepCountWithHandler:handler];
                }else
                {
                    if (handler) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            handler(0,error);
                       });
                    }
                }
            }];
        }
        
        if (status == HKAuthorizationStatusSharingDenied) {
            
            // 用户拒绝
            if (handler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(0,[NSError errorWithDomain:@"用户拒绝" code:0 userInfo:nil]);
               });
            }
        }
        
        if (status == HKAuthorizationStatusSharingAuthorized) {
            
            // 用户许可，直接请求
            [self getStepCountWithHandler:handler];
        }
        
    }else
    {
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(0,[NSError errorWithDomain:@"健康数据不可用" code:0 userInfo:nil]);
           });
        }
    }
}

@end
