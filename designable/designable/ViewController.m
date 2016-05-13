//
//  ViewController.m
//  designable
//
//  Created by minggo on 16/5/12.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "ViewController.h"
#import "MGOImageView.h"
#import "UIView+MGO.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MGOImageView *avatarIv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat cornerRadius = self.avatarIv.cornerRadius;
    NSLog(@"avatarIv.cornerRadius:%f",cornerRadius);
    [self.avatarIv setCornerRadius:30];
    cornerRadius = self.avatarIv.cornerRadius;
    NSLog(@"avatarIv.cornerRadius:%f",cornerRadius);
    NSLog(@"avatarIv.defineValue:%f",self.avatarIv.defineValue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
