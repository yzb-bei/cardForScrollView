//
//  ViewController.m
//  studyCard
//
//  Created by youzhenbei on 2017/7/6.
//  Copyright © 2017年 youzhenbei. All rights reserved.
//

#import "ViewController.h"
#import "CardScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scrollView];
}


- (void)scrollView {
    CGRect frame = CGRectInset(self.view.bounds, 20, 20);
    CardScrollView *cardScrollView  = [[CardScrollView alloc] initWithFrame:frame];
    cardScrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:cardScrollView];
    
    NSMutableArray *ar = [[NSMutableArray alloc] initWithCapacity:3];
    [ar addObject:@"1"];
    [ar addObject:@"2"];
    [ar addObject:@"3"];
    [ar addObject:@"4"];
    [ar addObject:@"5"];
    [ar addObject:@"6"];
    [cardScrollView setCards:ar];
}


@end
