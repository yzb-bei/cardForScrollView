//
//  CardView.m
//  studyCard
//
//  Created by youzhenbei on 2017/7/6.
//  Copyright © 2017年 youzhenbei. All rights reserved.
//

#import "CardView.h"

@interface CardView ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [self randomColor];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

- (UILabel *)label{
    if (_label == nil) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:50.0f];
        [self addSubview:_label];
    }
    return _label;
}

-(UIColor *) randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
