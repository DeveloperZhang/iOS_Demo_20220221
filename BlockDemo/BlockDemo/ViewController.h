//
//  ViewController.h
//  BlockDemo
//
//  Created by Vicent on 2022/4/5.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (ViewController* (^)(int num))returnMethod;

@end

