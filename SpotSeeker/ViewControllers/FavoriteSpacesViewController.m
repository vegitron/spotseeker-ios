//
//  FavoriteSpotsViewController.m
//  SpotSeeker
//
//  Created by Patrick Michaud on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteSpacesViewController.h"

@implementation FavoriteSpacesViewController

@synthesize favorites;
@synthesize no_favorites;

- (IBAction)btnClickClose:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark load spots

-(void)searchFinished:(NSArray *)spots {
    self.current_spots = spots;
    [self sortSpots];
    if (self.current_spots.count > 0) {
        [self.spot_table reloadData];
    }
    else {
        self.spot_table.hidden = YES;
        self.no_favorites.hidden = NO;
    }
}

#pragma mark -
#pragma mark viewcontroller loading

- (void)viewDidAppear:(BOOL)animated {
    
    // If someone unfavorites something after being here, redraw the table
    NSArray *current_favorites = [Favorites getFavoritesIDList];
    if (self.favorites.count != current_favorites.count) {
        self.favorites = current_favorites;
        [self fetchFavorites];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.favorites = [Favorites getFavoritesIDList];
    [self fetchFavorites];
}

- (void)fetchFavorites {
    NSMutableDictionary *id_lookup = [[NSMutableDictionary alloc] init];
    [id_lookup setObject:self.favorites forKey:@"id"];
    
    Space *search_spot = [[Space alloc] init];
    search_spot.delegate = self;
    [search_spot getListBySearch:id_lookup];
    self.spot = search_spot;
    
}

- (NSUInteger)supportedInterfaceOrientations
{
    //decide number of origination tob supported by Viewcontroller.
    return UIInterfaceOrientationMaskPortrait;
}

@end
