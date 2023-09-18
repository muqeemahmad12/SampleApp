//
//  NewAdViewController.m
//  SampleApp
//
//  Created by Muqeem.Ahmad on 12/09/23.
//

#import "NewAdViewController.h"
#import "SampleApp-Swift.h"
//@import MainViewController

@interface NewAdViewController ()

@end

@implementation NewAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MySwiftObject *myOb = [[MySwiftObject alloc]init];
    UIView *adView = [myOb testAd];
    adView.backgroundColor = [UIColor redColor];
    [self.view addSubview:adView];
}

- (void)myTestWithAString:(MySwiftObject*)myOb {
//    [[myOb objcRevealViewController] revealSideMenu];
}

- (void) someMethod {
    NSLog(@"SomeMethod Ran");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
