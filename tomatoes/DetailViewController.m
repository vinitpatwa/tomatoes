//
//  DetailVC.m
//  tomatoes
//
//  Created by Vinit Patwa on 1/21/14.
//  Copyright (c) 2014 Vinit Patwa. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        NSLog(@"some %@",self.castLabel.text);
    
	// Do any additional setup after loading the view.
    self.castLabel.text = self.str;
    self.moviesTitleLabel.text = self.movie->title;
    self.synopsisLabel.text = self.movie->synopsis;
    self.castLabel.text = self.movie->cast;
    [self.poster setImageWithURL:[NSURL URLWithString:self.movie->profilePoster]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
