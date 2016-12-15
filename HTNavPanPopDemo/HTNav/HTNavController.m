//
//  HTNavController.m
//  HTNavPanPopDemo
//
//  Created by taotao on 11/12/2016.
//  Copyright © 2016 taotao. All rights reserved.
//

#import "HTNavController.h"
#import "UIView+PositionExt.h"


#define kBgDisplayPercent               0.1

@interface HTNavController ()
@property (nonatomic,strong)NSMutableArray *imgs;
@property (nonatomic,strong)UIImageView *lastImageView;
@property (nonatomic,strong)UIPanGestureRecognizer* beginRecognizer;
@property (nonatomic,assign) CGPoint panBeginPoint;
@property (nonatomic,assign) CGFloat panLength;
@property (nonatomic,assign) CGFloat bgViewMoveLenPercent;

@end

@implementation HTNavController

#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.interactivePopGestureRecognizer.enabled = NO;
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.view addGestureRecognizer:panRecognizer];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self mkScreenShot];
    [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.imgs removeLastObject];
    return [super popViewControllerAnimated:animated];
}

#pragma mark - lazy methods
-(NSMutableArray *)imgs
{
    if(_imgs== nil)
    {
        _imgs = [[NSMutableArray alloc] init];
    }
    return _imgs;
}
-(UIImageView *)lastImageView
{
    if(_lastImageView == nil)
    {
        _lastImageView = [[UIImageView alloc] init];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        self.lastImageView.frame = keyWindow.bounds;
        UIView *cover  = [[UIView alloc] init];
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.3;
        cover.frame = _lastImageView.bounds;
        [_lastImageView addSubview:cover];
        
    }
    return _lastImageView;
}

#pragma mark - private methods
- (void)mkScreenShot
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    [self.imgs addObject:img];
}

#pragma mark - selectors
-(void)panView:(UIPanGestureRecognizer*)recognizer
{
    if (self.childViewControllers.count <= 1) {
        return;
    }
    
    CGPoint tranPoint = [recognizer translationInView:self.view];
    if(recognizer.state == UIGestureRecognizerStateBegan){
        self.beginRecognizer = recognizer;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        self.panBeginPoint = [recognizer locationInView:keyWindow];
        
        UIImage *img = [self.imgs lastObject];
        self.lastImageView.image = img;
        [keyWindow insertSubview:self.lastImageView atIndex:0];
        
        self.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.view.layer.shadowOffset = CGSizeMake(-2, 0);
        self.view.layer.shadowOpacity = 0.8;
    }
    
    if(recognizer.state == UIGestureRecognizerStateChanged){
        CGFloat panEnableX =  self.view.frame.size.width * 0.25;
        if (self.panBeginPoint.x > panEnableX) {
            return;
        }
        if (tranPoint.x > 0) {
            //添加移动效果
            CGPoint currentPoint = [recognizer locationInView:[UIApplication sharedApplication].keyWindow];
            CGFloat panLength = (currentPoint.x - _panBeginPoint.x);
            if (panLength >= 0) {
                self.panLength = panLength;
                [self moveNavigationViewWithLenght:panLength];
                [self moveBackgroundImageViewWithLength:panLength];
            }
        }
    }
    
    if ((recognizer.state == UIGestureRecognizerStateEnded) || (recognizer.state == UIGestureRecognizerStateCancelled)) {
        if (self.panLength <= 0) {
            return;
        }
        
        CGFloat boundX =  self.view.frame.size.width * 0.25;
        CGRect originF = {{0,0},self.view.frame.size};
        if(tranPoint.x > boundX){
            CGRect targetF = {{self.view.frame.size.width,0},self.view.frame.size};
            [UIView animateWithDuration:0.3 animations:^{
                self.view.frame = targetF;
                self.lastImageView.x = 0;
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                [self.lastImageView removeFromSuperview];
                self.view.frame = originF;
                self.panLength = 0;
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                self.view.frame = originF;
                self.lastImageView.x = - originF.size.width;
            } completion:^(BOOL finished) {
                [self.lastImageView removeFromSuperview];
                self.panLength = 0;
            }];
        }
    }
}


/**
 *  移动视图界面
 *
 *  @param length 移动的长度
 */
- (void)moveNavigationViewWithLenght:(CGFloat)length{
    
    //图片位置设置
    self.view.frame = CGRectMake(length, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    //图片动态阴影
   
}

/**
 *  移动视图界面
 *
 *  @param length 移动的长度
 */
- (void)moveBackgroundImageViewWithLength:(CGFloat)length{
   
    CGSize viewSize = self.view.frame.size;
    CGFloat deltaX = viewSize.width * kBgDisplayPercent;
    CGFloat bgLength = length * (1 - kBgDisplayPercent);
    CGFloat x = bgLength - viewSize.width + deltaX;
    //图片位置设置
    self.lastImageView.frame = CGRectMake(x, self.view.frame.origin.y, viewSize.width, viewSize.height);
    //图片动态阴影
}

@end
