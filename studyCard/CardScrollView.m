//
//  CardScrollView.m
//  studyCard
//
//  Created by youzhenbei on 2017/7/6.
//  Copyright © 2017年 youzhenbei. All rights reserved.
//

#import "CardScrollView.h"
#import "CardView.h"

#define kCardMaxCount       (6.0f)
#define kHorizontalMargin   (25.0f)
#define kVerticalMargin     (25.0f)
#define kCardMargin         (20.0f)

#define kMakeScale(scale)            CGAffineTransformMakeScale(scale, scale)
#define kMakeTranslateY(view, tranY) CGAffineTransformTranslate(view.transform, 0, tranY)

@interface CardScrollView ()
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *cardViewArrayM;
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) NSInteger lastItemIndex;

@property (nonatomic, assign) CGPoint centerPoint;
@end

@implementation CardScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveCardGesture:)];
    [self addGestureRecognizer:pan];
    return self;
}

#pragma mark - Event
- (void)moveCardGesture:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint offset = [pan translationInView:self];
        UIView *card = _cardViewArrayM[0];
        card.center = CGPointMake(card.center.x, card.center.y+offset.y);
        [pan setTranslation:CGPointMake(0, 0) inView:self];
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        UIView *card = _cardViewArrayM[0];
        CGPoint cardPoint = card.center;
        if (abs((int)self.center.y) - abs((int)cardPoint.y) > card.bounds.size.height/3.0f) {
            //去第一个去掉，
            //整顿后面的View
            [UIView animateWithDuration:0.25 animations:^{
                [self removeCurrentCardView:card];
            }];
        }else{
            [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                card.center = _centerPoint;
            } completion:nil];
        }
    }
}

#pragma mark private
- (void)resetSubCardView {
    for (int i = 0; i < _cardViewArrayM.count; i++) {
        CardView *card = _cardViewArrayM[i];
        [self setCarView:card Index:i];
    }
}

- (void)setCarView:(UIView *)card Index:(NSInteger) index {
    CGFloat scale = 1 - index * 0.05f;
    card.transform = kMakeScale(scale);
    card.transform = kMakeTranslateY(card, (index * kCardMargin)/scale);
}

- (void)removeCurrentCardView:(UIView *) card{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = card.frame;
        frame.origin.y = 0 - frame.size.height;
        card.frame = frame;
        [_cardViewArrayM removeObject:card];
        [self resetSubCardView];
    }completion:^(BOOL finished) {
        [card removeFromSuperview];
        [_cards removeObjectAtIndex:0];
        if (_cards.count > _cardViewArrayM.count) {
            [self insertSubview:card atIndex:0];
            card.center = _centerPoint;
            [self.cardViewArrayM addObject:card];
        }
        [self resetSubCardView];
        if (_cards.count == 1) {
            [self removeGestureRecognizer:self.gestureRecognizers.lastObject];
        }
    } ];
    
}

#pragma set / get
- (void)setCards:(NSMutableArray *)cards {
    _cards = cards;
    NSInteger count = _cards.count > kCardMaxCount ? kCardMaxCount : cards.count;
    _itemCount = count;
    
    CGFloat h = (self.bounds.size.height - kVerticalMargin * 2.0f);
    CGFloat w = (self.bounds.size.width - kHorizontalMargin * 2.0f);
    CGFloat x = (self.bounds.size.width - w)/2.0f;
    CGFloat y = (self.bounds.size.height - h)/2.0f;
    
    for (int i = 0; i < count; i++) {
        CardView *cardView = [CardView new];
        cardView.frame = CGRectMake( x, y, w, h);
        [self insertSubview:cardView atIndex:0];
        [self setCarView:cardView Index:i];
        if (0 == i) {
            _centerPoint = cardView.center;
        }
        [self.cardViewArrayM addObject:cardView];
        
        self.centerPoint = cardView.center;
    }
}

- (NSMutableArray *)cardViewArrayM{
    if (_cardViewArrayM == nil) {
        _cardViewArrayM = [NSMutableArray arrayWithCapacity:3];
    }
    return _cardViewArrayM;
    
}


@end
