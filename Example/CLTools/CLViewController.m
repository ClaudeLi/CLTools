//
//  CLViewController.m
//  CLTools
//
//  Created by claudeli@yeah.net on 06/15/2018.
//  Copyright (c) 2018 claudeli@yeah.net. All rights reserved.
//

#import "CLViewController.h"
#import "CLTools.h"

@interface CLViewController ()

@end

@implementation CLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    @cl_weakify(self.view, weak_obj)
    weak_obj.backgroundColor = [UIColor blueColor];
    
    UUIDKeychainKey();
    NSLog(@"%@", UUIDKeychainKey());
    NSLog(@"%@", NSDocumentDirPath());
    NSRemoveFilesAtDirectory(NSTemporaryDirectory(), @"mp4");
    OpenURL([NSURL URLWithString:@"weixin://"], ^(BOOL success) {
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
