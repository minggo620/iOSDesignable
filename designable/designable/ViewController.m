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
@property (weak, nonatomic) IBOutlet UILabel *statusLb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"avatarIv.cornerRadius:%f",self.avatarIv.cornerRadius);
    NSLog(@"avatarIv.defineValue:%f",self.avatarIv.defineValue);
    
    self.statusLb.text = @"运行现实状态";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
