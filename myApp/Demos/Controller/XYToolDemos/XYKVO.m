//
//  XYKVO.m
//  myApp
//
//  Created by 渠晓友 on 2020/6/15.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import "XYKVO.h"
#import <objc/message.h>

@interface KVOInfomation : NSObject
/** observer: 被观察对象 */
@property (nonatomic, readonly,weak)       NSObject * observer;
/** key */
@property (nonatomic, readonly,copy)         NSString *key;
/** options */
@property (nonatomic, readonly,assign)       NSKeyValueObservingOptions options;
/** key */
@property (nonatomic, readonly,copy)         xy_observerHandler handler;

- (instancetype)initWithObserver:(id)observer key:(NSString *)key opeitons:(NSKeyValueObservingOptions)options handler:(xy_observerHandler)handler;

@end
@implementation KVOInfomation
- (instancetype)initWithObserver:(id)observer key:(NSString *)key opeitons:(NSKeyValueObservingOptions)options handler:(xy_observerHandler)handler{
    
    if (self == [super init]) {
        _observer = observer;
        _key = key;
        _options = options;
        _handler = handler;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([(__bridge id)context isKindOfClass:self.class]) {
        KVOInfomation *info = (__bridge KVOInfomation *)(context);
        if (object == info.observer && [keyPath isEqualToString:info.key]) {
            info.handler(change);
        }
    }
}

- (void)dealloc
{
    NSLog(@"KVOInfomation - dealloc");
    NSLog(@"%@",self.observer.observationInfo);
    
    if (self.observer.observationInfo) {
        [self.observer removeObserver:self forKeyPath:self.key];
    }
    
}

@end



@implementation NSObject (XY_KVO)
static NSString *clzPre = @"xy_KVO";
static const void *xy_infosKey = &xy_infosKey;


- (void)sys_addObserver:(id)observer key:(NSString *)key options:(NSKeyValueObservingOptions)options observerHandler:(xy_observerHandler)handler
{
    KVOInfomation *info = [[KVOInfomation alloc] initWithObserver:observer key:key opeitons:options handler:handler];
    NSMutableArray *infos = objc_getAssociatedObject(self, xy_infosKey);
    if (!infos) {
        infos = [NSMutableArray array];
        objc_setAssociatedObject(self, xy_infosKey, infos, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [infos addObject:info];
    
    [self addObserver:info forKeyPath:key options:options context:(__bridge void * _Nullable)(info)];
}

- (void)xy_addObserverForKey:(NSString *)key options:(NSKeyValueObservingOptions)options observerHandler:(xy_observerHandler)handler
{
    // 1. 校验
    SEL setterSEL = [self selWithKey:key];
    Method setterMethod = class_getInstanceMethod(self.class, setterSEL);
    if (!setterMethod) {
        // 没有相应的 setter 方法实现。 如 WKWebView.title
        XYFunc
        [self sys_addObserver:self key:key options:options observerHandler:handler];
        return;
    }
    
    // 2. 创建子类
    Class clz = object_getClass(self);
    NSString *clzName = NSStringFromClass(clz);
    if (![clzName containsString:clzPre]) {
        clz = [self creatKVOClassWithOriginalClassName:clzName];
        
        // 设置成子类
        object_setClass(self, clz);
    }
    
    // 3. 添加方法,仅添加一次
    if (![self hasSeleter:setterSEL]) {
        const char *types = method_getTypeEncoding(setterMethod);
        BOOL s = class_addMethod(clz, setterSEL, (IMP)kvo_setter, types);
        NSLog(@"%d",s);
    }
    
    // 4. 保存KVO相关内容
    KVOInfomation *info = [[KVOInfomation alloc] initWithObserver:self key:key opeitons:options handler:handler];
    NSMutableArray *infos = objc_getAssociatedObject(self, xy_infosKey);
    if (!infos) {
        infos = [NSMutableArray array];
        objc_setAssociatedObject(self, xy_infosKey, infos, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [infos addObject:info];
}


static void kvo_setter(id self, SEL _cmd, id newValue)
{
    // 给父类发送修改值的消息
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = [self getterFromSetterName:setterName];
    if (!getterName) {
        NSLog(@" ----- 原来类中没有 getter 方法");
    }
    
    id oldValue = [self valueForKey:getterName];
    
    // 调用父类setter
    // 构造 objc_super 的结构体
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self)),
    };
    
    // 对 objc_msgSendSuper 进行类型转换，解决编译器报错的问题
    void (* objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    // id objc_msgSendSuper(struct objc_super *super, SEL op, ...) ,传入结构体、方法名称，和参数等
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue);
    
    // 回调 handler - 依据options
    NSMutableArray *infos = objc_getAssociatedObject(self, xy_infosKey);
    for (KVOInfomation *info in infos) {
        if ((info.observer == self) && ([info.key isEqualToString:getterName])) {
            NSDictionary *dict = @{
                @"observeredObj": info.observer,
                @"key": info.key,
                NSKeyValueChangeNewKey: newValue?:@"",
                NSKeyValueChangeOldKey: oldValue?:NSNull.null
            };
            info.handler(dict);
        }
    }
}

- (NSString *)getterFromSetterName:(NSString *)setterName{
    
    if (![setterName hasPrefix:@"set"] || ![setterName hasSuffix:@":"]) {
        return nil;
    }
    
    // 只要中间字符 - 首字母小写
    NSRange range = NSMakeRange(3, setterName.length - 4);
    NSString *key = [setterName substringWithRange:range];
    
    
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    return [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstLetter];
}


- (BOOL)hasSeleter:(SEL)seleter
{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(object_getClass(self), &count);
    
    for (unsigned int i = 0; i < count; i++) {
        Method m = methodList[i];
        SEL currentSeleter = method_getName(m);
        if (currentSeleter == seleter) {
            free(methodList);
            return YES;
        }
    }
    
    free(methodList);
    return NO;
}



/// 通过本类创建KVO监听的子类
- (Class)creatKVOClassWithOriginalClassName:(NSString *)originalClassName{
    
    NSString *originalClzName = originalClassName;
    
    NSString *newClassName = [clzPre stringByAppendingString:originalClzName];
    if (objc_getClass(newClassName.UTF8String)) {
        return NSClassFromString(newClassName);
    }
    
    Class newClass = objc_allocateClassPair(self.class, [newClassName UTF8String], 0);
    
    // 重写class 方法，指向父类，隐藏kvo子类
    const char *types = method_getTypeEncoding(class_getInstanceMethod(newClass, @selector(class)));
    class_addMethod(newClass, @selector(class), (IMP)kvo_class, types);
    
    objc_registerClassPair(newClass);
    
    return newClass;
}

static Class kvo_class(id self, SEL _cmd)
{
    return class_getSuperclass(object_getClass(self));
}

/// 通过key获取父类的 set 方法
/// @param key 监听的key
- (SEL)selWithKey:(NSString *)key{
    // 父类是否存在此set方法
    NSString *selName = [NSString stringWithFormat:@"%@%@%@",@"set",[self xy_firstCharUpper:key],@":"];
    SEL sel = NSSelectorFromString(selName);
    return sel;
}


- (NSString *)xy_firstCharUpper:(NSString *)string
{
    if (string.length == 0) return string;
    NSMutableString *stringM = [NSMutableString string];
    [stringM appendString:[NSString stringWithFormat:@"%c", [string characterAtIndex:0]].uppercaseString];
    if (string.length >= 2) [stringM appendString:[string substringFromIndex:1]];
    return stringM;
}

@end
