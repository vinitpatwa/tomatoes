//
//  DetailVC.h
//  tomatoes
//
//  Created by Vinit Patwa on 1/21/14.
//  Copyright (c) 2014 Vinit Patwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *moviesTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *synopsisLabel;
@property (nonatomic, weak) IBOutlet UILabel *castLabel;
@property (nonatomic, weak) IBOutlet UIImageView *poster;
@property (nonatomic, strong) NSString *str;

@property (nonatomic, strong) Movie *movie;




@end
