//
//  AMTagListView.m
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMTagListView.h"

@interface AMTagListView ()

@property (nonatomic, copy) AMTagListViewTapHandler tapHandler;
@property (nonatomic, strong) id orientationNotification;
@property (nonatomic, strong) id tagNotification;

@end

@implementation AMTagListView

#pragma mark - Setup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // Default margins
    _marginX = 4;
    _marginY = 4;
    self.clipsToBounds = YES;
    _tags = [@[] mutableCopy];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    __weak AMTagListView *weakSelf = self;
    self.orientationNotification = [center addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [weakSelf rearrangeTags];
    }];
    self.tagNotification = [center addObserverForName:AMTagViewNotification object:nil queue:nil usingBlock:^(NSNotification *notification) {
        if (weakSelf == notification.userInfo[@"superview"]) {
            if (_tapHandler) {
                weakSelf.tapHandler(notification.object);
            }
        }
    }];
}

- (void)setTapHandler:(AMTagListViewTapHandler)tapHandler
{
    _tapHandler = tapHandler;
}

#pragma mark - Tag insertion

- (void)addTag:(NSString*)text
{
    [self addTag:text andRearrange:YES];

}

- (void)addTag:(NSString*)text andRearrange:(BOOL)rearrange
{
    AMTagView* tagView = [[AMTagView alloc] initWithFrame:CGRectZero];
    [tagView setupWithText:text];
    
    CGRect frame = tagView.frame;
    frame.size.width = MIN(frame.size.width, self.frame.size.width - self.marginX * 2);
    tagView.frame = frame;
    
    [self.tags addObject:tagView];
    
    if (rearrange) {
        [self rearrangeTags];
    }
    
    if ([self.tagListDelegate respondsToSelector:@selector(tagList:shouldAddTagWithText:resultingContentSize:)]) {
        if (![self.tagListDelegate tagList:self shouldAddTagWithText:tagView.tagText resultingContentSize:self.contentSize]) {
            [self removeTag:tagView];
        }
    }
}

- (void)addTagView:(AMTagView *)tagView
{
    [self addTagView:tagView andRearrange:YES];
}

- (void)addTagView:(AMTagView *)tagView andRearrange:(BOOL)rearrange
{
    UIFont* font = [[[tagView class] appearance] textFont] ? [[[tagView class] appearance] textFont] : kDefaultFont;
    CGSize size = [tagView.tagText sizeWithAttributes:@{NSFontAttributeName: font}];
    float padding = [[[tagView class] appearance] textPadding] ? [[[tagView class] appearance] textPadding] : kDefaultTextPadding;
    float tagLength = [[[tagView class] appearance] tagLength] ? [[[tagView class] appearance] tagLength] : kDefaultTagLength;
    
    size.width = (int)size.width + padding * 2 + tagLength;
    size.height = (int)size.height + padding;
    size.width = MIN(size.width, self.frame.size.width - self.marginX * 2);
    
    tagView.frame = (CGRect){0, 0, size.width, size.height};
    [self.tags addObject:tagView];
    
    if (rearrange) {
        [self rearrangeTags];
    }
    
    if ([self.tagListDelegate respondsToSelector:@selector(tagList:shouldAddTagWithText:resultingContentSize:)]) {
        if (![self.tagListDelegate tagList:self shouldAddTagWithText:tagView.tagText resultingContentSize:self.contentSize]) {
            [self removeTag:tagView];
        }
    }
}

- (void)addTags:(NSArray*)array
{
    [self addTags:array andRearrange:YES];
}

- (void)addTags:(NSArray*)array andRearrange:(BOOL)rearrange
{
    for (NSString* text in array) {
        [self addTag:text andRearrange:rearrange];
    }
}

#pragma mark - Tag removal

- (void)removeTag:(AMTagView*)view
{
    [view removeFromSuperview];
    [self.tags removeObject:view];
    [self rearrangeTags];
}

- (void)removeAllTags
{
    for (AMTagView *tag in self.tags) {
        [tag removeFromSuperview];
    }
    [self.tags removeAllObjects];
    [self rearrangeTags];
}

#pragma mark - Service

- (void)rearrangeTags
{
    [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    __block float maxY = 0;
    __block float maxX = 0;
    __block CGSize size;
    for (AMTagView *obj in self.tags) {
        size = obj.frame.size;
        [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[AMTagView class]]) {
                maxY = MAX(maxY, obj.frame.origin.y);
            }
        }];
        
        [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[AMTagView class]]) {
                if (obj.frame.origin.y == maxY) {
                    maxX = MAX(maxX, obj.frame.origin.x + obj.frame.size.width);
                }
            }
        }];
        
        // Go to a new line if the tag won't fit
        if (size.width + maxX > (self.frame.size.width - self.marginX)) {
            maxY += size.height + self.marginY;
            maxX = 0;
        }
        obj.frame = (CGRect){maxX + self.marginX, maxY, size.width, size.height};
        [self addSubview:obj];
    };
    
    [self setContentSize:(CGSize){self.frame.size.width, maxY + size.height +self.marginY}];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self rearrangeTags];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_tagNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:_orientationNotification];
}

@end
