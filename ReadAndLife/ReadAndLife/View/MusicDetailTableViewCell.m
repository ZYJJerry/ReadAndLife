//
//  MusicDetailTableViewCell.m
//  MyRealityLife
//
//  Created by Jerry on 16/2/26.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "MusicDetailTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "HelperDefine.h"

@implementation MusicDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellContentWithData:(MusicDetailModel *)model{
    [self.musicImage setImageWithURL:[NSURL URLWithString:model.cover]];
    self.title.text = model.story_title;
    self.authorName.text = [NSString stringWithFormat:@"By:%@",model.author[@"user_name"]];
    [self.authorIcon setImageWithURL:[NSURL URLWithString:model.author[@"web_url"]] placeholderImage:nil];
    self.authorIcon.layer.cornerRadius = 20;
    self.authorIcon.layer.masksToBounds = YES;
    model.story = [self filterHTML:model.story];
    [self.nameView.layer setShadowOffset:CGSizeMake(1, 1)];
    [self.nameView.layer setShadowOpacity:0.3];
    self.nameView.layer.cornerRadius = 1;
    self.nameView.layer.shadowColor = [[UIColor blackColor]CGColor];
//    self.nameView.layer.masksToBounds = YES;
//    self.nameView.layer.borderWidth = 1;
//    self.nameView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blueColor]);
    self.storyContent.text = model.story;
//    self.backgroundColor = RGB(255, 255, 191);
}
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"\n"];
        
    }
    return html;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
