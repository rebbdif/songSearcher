//
//  MainViewController.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <NSURLSessionDownloadDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url=[NSURL URLWithString:@"https://www.google.com"];
    NSURLSessionDataTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *responceStr=[[NSString alloc]initWithData:data encoding:NSWindowsCP1251StringEncoding];
        NSLog(@"DATA: \n%@\nEND DATA\n",responceStr);
    }];
    [task resume];
    
    NSURL *image =[NSURL URLWithString:@"https://www.google.ru/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwjpyKGW3NbTAhWDkywKHU1kDLsQjRwIBw&url=http%3A%2F%2Fwww.spacex.com%2Ffalcon-heavy&psig=AFQjCNExX05cC9L-SpuPkYl8LlgSNzchwg&ust=1494003845329451"];
    NSURLSessionDownloadTask *downloadTask=[session downloadTaskWithURL:image completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       //тут используем картинку
        NSLog(@"\n");
    }];
    [downloadTask resume];
    
    NSURLSession *delegateSession=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *delegateDownloadTask=[delegateSession downloadTaskWithURL:image];
    [delegateDownloadTask resume];

    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"session %@", session);
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"download completed \n");
}

@end
