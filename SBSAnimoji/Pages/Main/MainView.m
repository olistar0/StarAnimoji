//
//  MainView.m
//  SBSAnimoji
//
//  Created by Simon Støvring on 05/11/2017.
//  Copyright © 2017 SimonBS. All rights reserved.
//

#import "MainView.h"
#import "AVTRecordView.h"

@interface MainView ()
@property (nonatomic, strong) SBSPuppetView *puppetView;
@property (nonatomic, strong) UICollectionView *thumbnailsCollectionView;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *previewButton;
@property (nonatomic, strong) UIButton *expandPreviewButton;
@property (nonatomic, strong) UIButton *shrinkPreviewButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UIView *puppetViewSeparatorView;
@property (nonatomic, strong) NSLayoutConstraint *puppetViewHeightConstraint;
@end

@implementation MainView

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
        [self setupLayout];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    
    self.puppetView = [[SBSPuppetView alloc] init];
    self.puppetView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.puppetView];

    self.expandPreviewButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.expandPreviewButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.expandPreviewButton setTitle:@"+" forState:UIControlStateNormal];
    self.expandPreviewButton.titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    [self addSubview:self.expandPreviewButton];

    self.shrinkPreviewButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shrinkPreviewButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.shrinkPreviewButton setTitle:@"-" forState:UIControlStateNormal];
    self.shrinkPreviewButton.titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    [self addSubview:self.shrinkPreviewButton];
    
    self.puppetViewSeparatorView = [[UIView alloc] init];
    self.puppetViewSeparatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.puppetViewSeparatorView.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    [self addSubview:self.puppetViewSeparatorView];
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewLayout.minimumInteritemSpacing = 14;
    collectionViewLayout.minimumLineSpacing = 10;
    self.thumbnailsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
    self.thumbnailsCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.thumbnailsCollectionView.backgroundColor = [UIColor whiteColor];
    self.thumbnailsCollectionView.contentInset = UIEdgeInsetsMake(15, 7, 15, 7);
    self.thumbnailsCollectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.thumbnailsCollectionView];
    
    self.durationLabel = [[UILabel alloc] init];
    self.durationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.durationLabel.textAlignment = NSTextAlignmentRight;
    self.durationLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.durationLabel.hidden = YES;
    [self addSubview:self.durationLabel];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.deleteButton.hidden = YES;
    [self.deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [self addSubview:self.deleteButton];
    
    self.previewButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.previewButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.previewButton.hidden = YES;
    [self.previewButton setImage:[UIImage imageNamed:@"start-previewing"] forState:UIControlStateNormal];
    [self addSubview:self.previewButton];
    
    self.recordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.recordButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.recordButton setImage:[UIImage imageNamed:@"start-recording"] forState:UIControlStateNormal];
    [self addSubview:self.recordButton];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.shareButton.hidden = YES;
    [self.shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self addSubview:self.shareButton];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicatorView.hidesWhenStopped = YES;
    [self addSubview:self.activityIndicatorView];
}

- (void)setupLayout {
    [self.puppetView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.puppetView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.puppetView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor].active = YES;
    self.puppetViewHeightConstraint = [self.puppetView.heightAnchor constraintEqualToConstant:335];
    self.puppetViewHeightConstraint.active = YES;

    [self.expandPreviewButton.leadingAnchor constraintEqualToAnchor:self.puppetView.leadingAnchor constant:12].active = YES;
    [self.expandPreviewButton.topAnchor constraintEqualToAnchor:self.puppetView.topAnchor constant:8].active = YES;
    [self.expandPreviewButton.widthAnchor constraintEqualToConstant:44].active = YES;
    [self.expandPreviewButton.heightAnchor constraintEqualToConstant:44].active = YES;

    [self.shrinkPreviewButton.leadingAnchor constraintEqualToAnchor:self.expandPreviewButton.trailingAnchor constant:4].active = YES;
    [self.shrinkPreviewButton.topAnchor constraintEqualToAnchor:self.expandPreviewButton.topAnchor].active = YES;
    [self.shrinkPreviewButton.widthAnchor constraintEqualToAnchor:self.expandPreviewButton.widthAnchor].active = YES;
    [self.shrinkPreviewButton.heightAnchor constraintEqualToAnchor:self.expandPreviewButton.heightAnchor].active = YES;
    
    [self.puppetViewSeparatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.puppetViewSeparatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.puppetViewSeparatorView.topAnchor constraintEqualToAnchor:self.puppetView.bottomAnchor].active = YES;
    [self.puppetViewSeparatorView.heightAnchor constraintEqualToConstant:2].active = YES;
    
    [self.thumbnailsCollectionView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.thumbnailsCollectionView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.thumbnailsCollectionView.topAnchor constraintEqualToAnchor:self.puppetViewSeparatorView.bottomAnchor].active = YES;
    [self.thumbnailsCollectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    [self.durationLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -20].active = YES;
    [self.durationLabel.topAnchor constraintEqualToAnchor:self.puppetView.topAnchor constant: 15].active = YES;
    
    [self.recordButton.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:0].active = YES;
    [self.recordButton.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor constant:0].active = YES;

    [self.shareButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -20].active = YES;
    [self.shareButton.bottomAnchor constraintEqualToAnchor:self.puppetView.bottomAnchor constant: -20].active = YES;

    [self.deleteButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -20].active = YES;
    [self.deleteButton.topAnchor constraintEqualToAnchor:self.puppetView.topAnchor constant: 15].active = YES;
    
    [self.previewButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -20].active = YES;
    [self.previewButton.topAnchor constraintEqualToAnchor:self.deleteButton.bottomAnchor constant: 15].active = YES;

    [self.activityIndicatorView.centerXAnchor constraintEqualToAnchor:self.shareButton.centerXAnchor].active = YES;
    [self.activityIndicatorView.centerYAnchor constraintEqualToAnchor:self.shareButton.centerYAnchor].active = YES;
}

- (CGFloat)puppetViewHeight {
    return self.puppetViewHeightConstraint.constant;
}

- (void)setPuppetViewHeight:(CGFloat)height animated:(BOOL)animated {
    CGFloat minimumHeight = 200.0;
    CGFloat maximumHeight = MAX(minimumHeight, self.bounds.size.height - 140.0);
    self.puppetViewHeightConstraint.constant = MIN(MAX(height, minimumHeight), maximumHeight);
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        }];
    } else {
        [self layoutIfNeeded];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat itemsPerRow = 4;
    UICollectionView *collectionView = self.thumbnailsCollectionView;
    UIEdgeInsets contentInset = self.thumbnailsCollectionView.contentInset;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    CGFloat availableWidth = self.bounds.size.width - contentInset.left - contentInset.right - (itemsPerRow - 1) * flowLayout.minimumInteritemSpacing;
    CGFloat itemLength = floor(availableWidth / itemsPerRow);
    flowLayout.itemSize = CGSizeMake(itemLength, itemLength);
}

@end
