//
//  SAReactNative+Hussar.m
//  RNSensorsAnalyticsModule
//
//  Created by 彭远洋 on 2021/1/13.
//  Copyright © 2021 ziven.mac. All rights reserved.
//

#import "SAReactNative+Hussar.h"
#import <React/RCTUIManager.h>
#import <React/UIView+React.h>
#import <RCTText/RCTTextView.h>
#import <objc/runtime.h>

@interface SAViewUtils : NSObject

+ (NSString *)clickable:(UIView *)view;

@end

@implementation SAViewUtils

+ (NSNumber *)clickable:(UIView *)view {
    BOOL clickable = NO;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    Class manager = NSClassFromString(@"SAReactNativeManager");
    if (manager) {
        id sharedManager = [manager performSelector:NSSelectorFromString(@"sharedInstance")];
        NSSet *set = [sharedManager performSelector:NSSelectorFromString(@"viewProperties")];
        for (Class property in set) {
            NSNumber *reactTag = [property performSelector:NSSelectorFromString(@"reactTag")];
            if (reactTag.integerValue == view.reactTag.integerValue) {
                clickable = YES;
                break;
            }
        }
    }
#pragma clang diagnostic pop
    return @(clickable);
}

@end

@implementation RCTView (Hussar)

#if DEBUG
- (NSString *)description
{
    NSString *superDescription = super.description;
    NSRange semicolonRange = [superDescription rangeOfString:@";"];
    NSString *replacement = [NSString stringWithFormat:@"; reactTag: %@; clickable: %@;", self.reactTag, [SAViewUtils clickable:self]];

    return [superDescription stringByReplacingCharactersInRange:semicolonRange withString:replacement];
}
#endif

@end

@implementation RCTTextView (Hussar)

#if DEBUG
- (NSString *)description
{
    NSString *superDescription = super.description;
    NSRange semicolonRange = [superDescription rangeOfString:@";"];
    Ivar ivar = class_getInstanceVariable([RCTTextView class], "_textStorage");
    NSTextStorage *textStorage = object_getIvar(self, ivar);
    NSString *replacement = [NSString stringWithFormat:@"; reactTag: %@; clickable: %@; text: %@;", self.reactTag, [SAViewUtils clickable:self], textStorage.string];
    return [superDescription stringByReplacingCharactersInRange:semicolonRange withString:replacement];
}
#endif

@end
