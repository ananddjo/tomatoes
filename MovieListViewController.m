//
//  MovieListViewController.m
//  tomatoes
//
//  Created by Anand Joshi on 1/12/14.
//  Copyright (c) 2014 Yahoo! Inc. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieCell.h"
#import "Movie.h"

@interface MovieListViewController ()

@property (nonatomic, strong) NSArray *moviesArr;

@end

@implementation MovieListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.moviesArr = [NSArray array];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.moviesArr = [object valueForKeyPath:@"movies"];
            //NSLog(@"%@", self.moviesArr);
            [self.tableView reloadData];
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.moviesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MovieCell";
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *movieDict = [self.moviesArr objectAtIndex:indexPath.row];
    cell.movieTitle.text = [movieDict objectForKey:@"title"];
    cell.movieSummary.text = [movieDict objectForKey:@"synopsis"];
    NSDictionary *posterDict = [movieDict objectForKey:@"posters"];
    NSData *posterImg = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[posterDict objectForKey:@"thumbnail"]]];
    cell.posterImageView.image = [UIImage imageWithData:posterImg];
    
    NSArray *movieCastArr = [movieDict objectForKey:@"abridged_cast"];
    NSMutableString *castStr = [[NSMutableString alloc] initWithString: @""];
    for (id castObj in movieCastArr) {
        [castStr appendString:[castObj objectForKey:@"name"]];
        [castStr appendString:@", "];
    }
    [castStr deleteCharactersInRange:NSMakeRange([castStr length]-2, 1)];
    cell.movieCast.text = castStr;

    return cell;
}

@end
