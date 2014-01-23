//
//  MoviesViewController.m
//  tomatoes
//
//  Created by Vinit Patwa on 1/20/14.
//  Copyright (c) 2014 Vinit Patwa. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "DetailViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Movie.h"
#import "SVProgressHUD.h"
#import "YRDropdownView.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSArray *movies;

- (void)reload;

- (void)prepareForSegue;


@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reload];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self reload];
    }
    return self;
}



- (void)reload {
    NSLog(@"In reload");
    [SVProgressHUD showWithStatus:@"Updating" maskType:SVProgressHUDMaskTypeBlack];    
    // 2) Get a concurrent queue form the system
    dispatch_queue_t concurrentQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 3) Call data from rotten APIs in background
    dispatch_async(concurrentQueue, ^{
//        [NSThread sleepForTimeInterval:10.0];
        
        NSString *strUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=j26mp33uc2p8ds9cdkfp64tg";
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.movies = [responseObject objectForKey:@"movies"];
            [self.tableView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);

//            [YRDropdownView showDropdownInView:self.view
//                                         title:@"Error Retrieving Titles"
//                                        detail:@"No Internet Connection."];
            
//            [YRDropdownView showDropdownInView:self.view
//                                         title:@"Warning"
//                                        detail:@"Me too! I want to try a really long detail message to see how it handles the line breaks and what not. Here's to hoping it works right the first time!"
//                                         image:[UIImage imageNamed:@"bg-yellow"]
//                                      animated:YES
//                                     hideAfter:5];
            
//                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Titles"
//                                                         message:[NSString stringWithFormat:@"No Internet Connection"]
//                                                        delegate:nil
//                                               cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [av show];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"#############");
                [SVProgressHUD dismiss];
            });
            
        }];
        
    });
}


-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    Movie *mov = [Movie alloc];
    mov = [mov initWithDictionary:movie];
    cell.moviesTitleLabel.text = mov->title;
    cell.synopsisLabel.text = mov->synopsis;
    cell.castLabel.text = mov->cast;
    cell.posterUrl = mov->profilePoster;
    [cell.poster setImageWithURL:[NSURL URLWithString:cell.posterUrl]];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshList)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

- (void)refreshList
{
    [self reload];
    [self.refreshControl performSelector:@selector(endRefreshing)];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"DetailViewControllerSegue"]){
        DetailViewController *cvc = (DetailViewController *)[segue destinationViewController];
        MovieCell *curCell = sender;
        cvc.movie = [[Movie alloc] initWithTitle:curCell.moviesTitleLabel.text synopsis:curCell.synopsisLabel.text profilePoster:curCell.posterUrl cast:curCell.castLabel.text];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}









@end
