//
//  FXMeWebViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/21.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXMEWebViewController.h"

@interface FXMeWebViewController () <UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForward;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;


@end

@implementation FXMeWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.delegate = self;
    
}

- (IBAction)goBack:(id)sender
{
    [self.webView goBack];
    
    
}
- (IBAction)goForward:(id)sender
{
    [self.webView goForward];
    
    
}

- (IBAction)refresh:(id)sender
{
    
    [self.webView reload];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBack.enabled = webView.canGoBack;
    self.goForward.enabled = webView.canGoForward;
    
    
}


@end
