//
//  MusicDetailViewController.h
//  ReadAndLife
//
//  Created by Jerry on 16/3/2.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol playSongDelegate <NSObject>

- (void)playerPlay:(NSURL *)url;

@end

@interface MusicDetailViewController : UIViewController
- (instancetype)initWithArray:(NSArray *)dataArray;
@property (nonatomic,weak)id<playSongDelegate> delagate;
@end
