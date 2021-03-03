//
//  XYAuthenticationTool.m
//  AFNetworking
//
//  Created by 渠晓友 on 2021/3/3.
//

#import "XYAuthenticationTool.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface XYAuthenticationTool()
/** 上下文 */
@property (nonatomic, strong)   LAContext* context;
@end

@implementation XYAuthenticationTool

+ (instancetype)sharedInstance{
    static dispatch_once_t predicate;
    static XYAuthenticationTool * instance;
    dispatch_once(&predicate, ^{
        instance = [[XYAuthenticationTool alloc] init];
        instance.context = [LAContext new];
    });
    return instance;
}

+ (XYAuthType)authType
{
    XYAuthType result = XYAuthTypeNone;
    XYAuthenticationTool * instance = [XYAuthenticationTool sharedInstance];
    getCanEvaluateResult();
    if (@available(iOS 11.0, *)) { // 11 之后有的 face ID
        switch (instance.context.biometryType) {
            case LABiometryTypeNone:
                result = XYAuthTypeNone;
                break;
            case LABiometryTypeFaceID:
                result = XYAuthTypeFaceID;
                break;
            case LABiometryTypeTouchID:
                result = XYAuthTypeTouchID;
                break;
            default:
                break;
        }
    } else {
        // Fallback on earlier versions, 之前只能判断是否有 touchID
        BOOL canEvalyate = getCanEvaluateResult();
        if (canEvalyate) {
            result = XYAuthTypeTouchID;
        }else
        {
            result = XYAuthTypeNone;
        }
    }
    return result;
}

+ (void)startAuthWithTip:(NSString *)tipString reply:(void (^)(BOOL, NSError * _Nonnull))reply{
    
    if (!reply) {
        @throw [NSException exceptionWithName:@"生物认证必须有回调" reason:nil userInfo:nil];
    }
    
    XYAuthenticationTool *instance = [XYAuthenticationTool sharedInstance];
    instance.context = LAContext.new; // 每次使用新的 content
    getCanEvaluateResult();
    if (@available(iOS 9.0, *)) {
        [instance.context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:tipString reply:^(BOOL success, NSError * _Nullable error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                reply(success,error);
            });
        }];
    } else {
        // Fallback on earlier versions
        [instance.context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:tipString reply:^(BOOL success, NSError * _Nullable error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                reply(success,error);
            });
        }];
    }
}


#pragma mark - private func

/// 获取当前上下文能否通过评估
bool getCanEvaluateResult(){
    XYAuthenticationTool *instance = [XYAuthenticationTool sharedInstance];
    BOOL canEvalyate = NO;
    if (@available(iOS 9.0, *)) {
        canEvalyate = [instance.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:NULL];
    } else {
        // Fallback on earlier versions
        canEvalyate = [instance.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL];
    }
    return canEvalyate;
}



@end
