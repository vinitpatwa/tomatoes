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

- (void) reload1{
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=j26mp33uc2p8ds9cdkfp64tg";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"JSON: %@", data);
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"data: %@", object);
        
        self.movies = [object objectForKey:@"movies"];
        
        [self.tableView reloadData];

    }];

    
}

- (void)reload {
    // 1
    NSString *strUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=j26mp33uc2p8ds9cdkfp64tg";
//    NSURL *url = [NSURL URLWithString:strUrl];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        self.movies = [responseObject objectForKey:@"movies"];
        
        [self.tableView reloadData];
        
        
        NSLog(@"JSON: %@", responseObject);
        NSLog(@"#############");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Titles"
                                                     message:[NSString stringWithFormat:@"No Internet Connection"]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    
    }];
    
    
}


-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    
    cell.moviesTitleLabel.text = [movie objectForKey:@"title"];
    cell.synopsisLabel.text = [movie objectForKey:@"synopsis"];
    cell.castLabel.text = @"My Movie Cast ";
    
    NSDictionary *poster = [movie objectForKey:@"posters"];
    
    NSString *imageURL = [poster objectForKey:@"profile"];
   NSLog(@"thumbnail: %@", imageURL);
    
    [cell.poster setImageWithURL:[NSURL URLWithString:imageURL]];
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self performSegueWithIdentifier:@"DetailViewControllerSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"DetailViewControllerSegue"]){
        DetailViewController *cvc = (DetailViewController *)[segue destinationViewController];
        [cvc setSynopsisLabelText:@"My Name"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
