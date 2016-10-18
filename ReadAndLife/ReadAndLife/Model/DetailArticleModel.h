//
//  DetailArticleModel.h
//  MyRealityLife
//
//  Created by Jerry on 16/2/25.
//  Copyright © 2016年 zhouyuju. All rights reserved.
//

#import "BaseModel.h"

@interface DetailArticleModel : BaseModel

@property (nonatomic,copy)NSString * articleHtml;
@property (nonatomic,copy)NSString * contentLink;
+ (DetailArticleModel *)getDataWithDictionary:(NSDictionary *)dictionary;
@end
