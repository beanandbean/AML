//
//  BBConstantDictionay.m
//  AML
//
//  Created by wangsw on 6/1/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBConstantDictionay.h"

@implementation BBConstantDictionay

+ (int)layoutAttribute:(NSString *)attribute {
    if ([attribute isEqualToString:@"width"]) {
        return NSLayoutAttributeWidth;
    } else if ([attribute isEqualToString:@"height"]) {
        return NSLayoutAttributeHeight;
    } else if ([attribute isEqualToString:@"top"]) {
        return NSLayoutAttributeTop;
    } else if ([attribute isEqualToString:@"bottom"]) {
        return NSLayoutAttributeBottom;
    } else if ([attribute isEqualToString:@"left"]) {
        return NSLayoutAttributeLeft;
    } else if ([attribute isEqualToString:@"right"]) {
        return NSLayoutAttributeRight;
    } else if ([attribute isEqualToString:@"centerX"]) {
        return NSLayoutAttributeCenterX;
    } else if ([attribute isEqualToString:@"centerY"]) {
        return NSLayoutAttributeCenterY;
    } else if ([attribute isEqualToString:@"baseline"]) {
        return NSLayoutAttributeBaseline;
    } else {
        return NSLayoutAttributeNotAnAttribute;
    }
}

+ (int)controlEvent:(NSString *)event {
    if ([event isEqualToString:@"touchDown"]) {
        return UIControlEventTouchDown;
    } else if ([event isEqualToString:@"touchDownRepeat"]) {
        return UIControlEventTouchDownRepeat;
    } else if ([event isEqualToString:@"touchDragInside"]) {
        return UIControlEventTouchDragInside;
    } else if ([event isEqualToString:@"touchDragOutside"]) {
        return UIControlEventTouchDragOutside;
    } else if ([event isEqualToString:@"touchDragEnter"]) {
        return UIControlEventTouchDragEnter;
    } else if ([event isEqualToString:@"touchDragExit"]) {
        return UIControlEventTouchDragExit;
    } else if ([event isEqualToString:@"touchUpInside"]) {
        return UIControlEventTouchUpInside;
    } else if ([event isEqualToString:@"touchUpOutside"]) {
        return UIControlEventTouchUpOutside;
    } else if ([event isEqualToString:@"touchCancel"]) {
        return UIControlEventTouchCancel;
    } else if ([event isEqualToString:@"valueChanged"]) {
        return UIControlEventValueChanged;
    } else if ([event isEqualToString:@"editingDidBegin"]) {
        return UIControlEventEditingDidBegin;
    } else if ([event isEqualToString:@"editingChanged"]) {
        return UIControlEventEditingChanged;
    } else if ([event isEqualToString:@"editingDidEnd"]) {
        return UIControlEventEditingDidEnd;
    } else if ([event isEqualToString:@"editingDidEndOnExit"]) {
        return UIControlEventEditingDidEndOnExit;
    } else if ([event isEqualToString:@"allTouchEvents"]) {
        return UIControlEventAllTouchEvents;
    } else if ([event isEqualToString:@"allEditingEvents"]) {
        return UIControlEventAllEditingEvents;
    } else if ([event isEqualToString:@"applicationReserved"]) {
        return UIControlEventApplicationReserved;
    } else if ([event isEqualToString:@"systemReserved"]) {
        return UIControlEventSystemReserved;
    } else if ([event isEqualToString:@"allEvents"]) {
        return UIControlEventAllEvents;
    } else {
        return -1;
    }
}

@end
