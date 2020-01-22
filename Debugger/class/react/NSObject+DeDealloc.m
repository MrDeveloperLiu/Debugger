//
//  NSObject+DeDealloc.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSObject+DeDealloc.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "DeReact.h"

@implementation NSObject (DeDealloc)

NSMutableArray<NSString *> *deSwwizzlingClasses () {
    static NSMutableArray *classes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classes = [NSMutableArray arrayWithCapacity:1];
    });
    return classes;
}

void deSwwizzlingDeallocMethod (Class cls) {
    NSString *className = NSStringFromClass(cls);
    NSMutableArray *classes = deSwwizzlingClasses();
    if ([classes containsObject:className]) {
        return;
    }
    
    SEL deallocSelector = sel_registerName("dealloc");
    __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
    
    IMP newDeallocImpl = imp_implementationWithBlock(^(__unsafe_unretained id self){
        
        DeComboneDispose *dispose = [(NSObject *)self deallocDispose];
        [dispose dispose];
        
        if (NULL == originalDealloc) {
            
            struct objc_super superCls;
            superCls.receiver = self;
            superCls.super_class = class_getSuperclass(cls);
                        
            void (*superDealloc)(struct objc_super *superCls, SEL op) = (__typeof(superDealloc))objc_msgSendSuper;
            superDealloc(&superCls, deallocSelector);
        }else{
            originalDealloc(self, deallocSelector);
        }
    });
    
    BOOL addMethod = class_addMethod(cls, deallocSelector, newDeallocImpl, "v@:");
    if (!addMethod) {
        Method deallocMethod = class_getInstanceMethod(cls, deallocSelector);
        originalDealloc = (__typeof(originalDealloc))method_getImplementation(deallocMethod);
        originalDealloc = (__typeof(originalDealloc))method_setImplementation(deallocMethod,
                                                                              newDeallocImpl);
    }
    [classes addObject:className];
}

- (DeSignal *)deallocSignal{
    DeSignal *signal = objc_getAssociatedObject(self, _cmd);
    if (!signal) {
        DeSubject *subject = [DeSubject subject];
        [self.deallocDispose addDispose:[DeDispose disposeWithBlock:^{
            [subject sendCompleted];
        }]];
        signal = subject;        
        objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN);
    }
    return signal;
}

- (DeComboneDispose *)deallocDispose{
    DeComboneDispose *dispose = objc_getAssociatedObject(self, _cmd);
    if (!dispose) {
        deSwwizzlingDeallocMethod(self.class);
        
        dispose = [DeComboneDispose comboneDispose];
        objc_setAssociatedObject(self, _cmd, dispose, OBJC_ASSOCIATION_RETAIN);
    }
    return dispose;
}
@end
