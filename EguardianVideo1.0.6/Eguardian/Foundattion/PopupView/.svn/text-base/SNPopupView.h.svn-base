//
//  SNPopupView.h
//  360LBS
//
//  Created by linmingzhi987 on 12-9-29.
//  Copyright (c) 2012年 linmingzhi987. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchPeekView;

typedef enum {
	SNPopupViewBarLeftItem		= 1,
	SNPopupViewButton		= 2,
} SNPopupViewModel;

@class SNPopupView;

@protocol SNPopupViewModalDelegate <NSObject>

- (void)didDismissModal:(SNPopupView*)popupview;

@end

@interface SNPopupView : UIView {
    CGRect viewRect;
    TouchPeekView	*peekView;
    SNPopupViewModel popupViewMode;
    UIView *contentView;
}

@property (nonatomic, assign) id  delegate;
@property (nonatomic, retain) UIView *fatherView;

- (id) initWithPopupViewModel:(SNPopupViewModel) model ContentView:view Rect:(CGRect)frame stretCapWidth:(float) width View:(UIView *) tmpview;
- (void)presentModal;
//- (void)initContenView ;
- (BOOL)shouldBeDismissedFor:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)dismiss;
- (void)dismiss:(BOOL)animtaed;
- (void)dismissModal;

@end
