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
    UUIDKeychainKey();
    NSLog(@"%@", UUIDKeychainKey());
    NSLog(@"%@", NSDocumentDirPath());
    NSRemoveFilesAtDirectory(NSTemporaryDirectory(), @"mp4");
    OpenURL(@"weixin://", ^(BOOL success) {
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
