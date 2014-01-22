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
        
        NSLog(@"Cast:%@",[dict objectForKey:@"abridged_cast"] );
        NSArray *array = [dict objectForKey:@"abridged_cast"];
        NSMutableArray *cast_array = [NSMutableArray arrayWithCapacity:array.count];
        
        for(NSDictionary *item in array) {
            [cast_array addObject:[item objectForKey:@"name"]];
        }
        NSLog(@"cast_array:%@", cast_array);
        cast = [cast_array componentsJoinedByString:@","];
                NSLog(@"cast_string:%@", cast);
        
        
    }
    
    return self;
    
}


-(id)initWithTitle:(NSString *)movTitle synopsis:(NSString *)movSynopsis profilePoster:(NSString *)movProfilePoster  cast:(NSString *)movCast {
    
    if(self = [super  init])
    {
        
        title = movTitle;
        synopsis = movSynopsis;
        //        detailedPoster = [[dict objectForKey:@"posters"] objectForKey:@"detailed"];
        profilePoster = movProfilePoster;
        
        cast = movCast;
        
    }
    
    return self;
    
}

@end
