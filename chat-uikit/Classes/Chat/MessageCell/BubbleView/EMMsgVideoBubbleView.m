//
//  EMMsgVideoBubbleView.m
//  EaseChat
//
//  Created by XieYajie on 2019/2/14.
//  Copyright © 2019 XieYajie. All rights reserved.
//

#import "EMMsgVideoBubbleView.h"

@implementation EMMsgVideoBubbleView

- (instancetype)initWithDirection:(AgoraChatMessageDirection)aDirection
                             type:(AgoraChatMessageType)aType
                        viewModel:(EaseChatViewModel *)viewModel
{
    self = [super initWithDirection:aDirection type:aType viewModel:viewModel];
    if (self) {
        [self _setupSubviews];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setupSubviews];
    }
    return self;
}

#pragma mark - Subviews

- (void)_setupSubviews
{
    self.shadowView = [[UIView alloc] init];
    self.shadowView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    [self addSubview:self.shadowView];
    [self.shadowView Ease_makeConstraints:^(EaseConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.playImgView = [[UIImageView alloc] init];
    self.playImgView.image = [UIImage easeUIImageNamed:@"msg_video_white"];
    self.playImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.playImgView];
    [self.playImgView Ease_makeConstraints:^(EaseConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@50);
    }];
}

#pragma mark - Setter

- (void)setModel:(EaseMessageModel *)model
{
    AgoraChatMessageType type = model.type;
    if (type == AgoraChatMessageTypeVideo) {
        AgoraChatVideoMessageBody *body = (AgoraChatVideoMessageBody *)model.message.body;
        NSString *imgPath = body.thumbnailLocalPath;
        if ([imgPath length] == 0 && model.direction == AgoraChatMessageDirectionSend) {
            imgPath = body.localPath;
        }
        
        if (body.thumbnailSize.height == 0 || body.thumbnailSize.width == 0) {
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"chat-uikit" ofType:@"bundle"];
            imgPath = [bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"video_default_thumbnail"]];
        }
        [self setThumbnailImageWithLocalPath:imgPath remotePath:body.thumbnailRemotePath thumbImgSize:body.thumbnailSize imgSize:body.thumbnailSize];
    }
}

@end
