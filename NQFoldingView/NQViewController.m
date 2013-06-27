//
//  NQViewController.m
//  NQFoldingView
//
//  Created by AhmedElnaqah on 6/27/13.
//  Copyright (c) 2013 elnaqah. All rights reserved.
//
//The MIT License (MIT)
//
//Copyright (c) 2013 ahmed elnaqah
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.


#import "NQViewController.h"

@interface NQViewController ()

@end

@implementation NQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NQFoldingUIView * foldingView=[[NQFoldingUIView alloc] initWithFrame:self.view.bounds WithImage:[UIImage imageNamed:@"vector-tree.png"] WithType:NQHorizontalFolding];
    foldingView.delegate=self;
    [self.view addSubview:foldingView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
#pragma mark NQFoldingUIViewDelegate
-(void)foldingViewDidAnimateToFold
{
    NSLog(@"did animate to fold");
}

-(void)foldingViewDidAnimateToFlat
{
    NSLog(@"did animate to flat");
}

-(void)foldingViewWillAnimateToFlat
{
    NSLog(@"will animate to flat");
}

-(void)foldingViewWillAnimateToFold
{
    NSLog(@"will animate to fold");
}

@end
