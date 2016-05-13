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
    
    NSLog(@"avatarIv.cornerRadius:%f",self.avatarIv.cornerRadius);
    NSLog(@"avatarIv.defineValue:%f",self.avatarIv.defineValue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
