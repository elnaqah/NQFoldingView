NQFoldingView
=============

Control for ipad and iphone that is a view contain image that fold and unfold with animation 
and the image can be pinched

![NQFoldingView](http://farm8.staticflickr.com/7438/9149431570_1aebb8c01b.jpg)

You can use it as :

initialize
```objc
 NQFoldingUIView * foldingView=[[NQFoldingUIView alloc] initWithFrame:self.view.bounds WithImage:[UIImage imageNamed:@"image Name.png"] WithType:NQHorizontalFolding];
```
set delegate
```objc
    foldingView.delegate=self;
```
add to View
```objc
    [self.view addSubview:foldingView];
```

you can use the delegate method 
```objc
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
```
This controller under MIT license just mention me in the app thanks

The MIT License (MIT)

Copyright (c) 2013 ahmed elnaqah

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

