//
//  Movie.m
//  tomatoes
//
//  Created by Vinit Patwa on 1/22/14.
//  Copyright (c) 2014 Vinit Patwa. All rights reserved.
//

#import "Movie.h"

@implementation Movie



-(id)initWithDictionary: (NSDictionary *)dict{
    
    if(self = [super  init])
    {
        
        title = [dict objectForKey:@"title"];
        synopsis = [dict objectForKey:@"synopsis"];
        //        detailedPoster = [[dict objectForKey:@"posters"] objectForKey:@"detailed"];
        profilePoster = [[dict objectForKey:@"posters"] objectForKey:@"profile"];
        
        //NSString *cast;
        
    }
    
    return self;
    
}


-(id)initWithTitle:(NSString *)movTitle synopsis:(NSString *)movSynopsis profilePoster:(NSString *)movProfilePoster   {
    
    if(self = [super  init])
    {
        
        title = movTitle;
        synopsis = movSynopsis;
        //        detailedPoster = [[dict objectForKey:@"posters"] objectForKey:@"detailed"];
        profilePoster = movProfilePoster;
        
        //NSString *cast;
        
    }
    
    return self;
    
}

@end
