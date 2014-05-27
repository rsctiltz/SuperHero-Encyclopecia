//
//  ViewController.m
//  SuperheroPedia
//
//  Created by Ryan Tiltz on 5/27/14.
//  Copyright (c) 2014 Ryan Tiltz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property NSArray *superheroes;
@property (weak, nonatomic) IBOutlet UITableView *superheroTableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
NSURLRequest *request = [NSURLRequest requestWithURL:url];


    [super viewDidLoad];



        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)

    {
        self.superheroes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [self.superheroTableView reloadData];
        NSLog(@"Back from the web");
    }];

        NSLog(@"Just made the web call");

        //self.superheroes = @[@{@"name": @"Superman", @"age": @32},
                //         @{@"name": @"The Hulk", @"age": @38}];

    }
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
       {
           return self.superheroes.count;
       }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath
       {

           NSDictionary *superhero = [self.superheroes objectAtIndex:indexPath.row];
           UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySuperheroCellID"];
           NSURL *url = [NSURL URLWithString:superhero[@"avatar_url"]];


           cell.textLabel.text = superhero[@"name"];
           cell.detailTextLabel.text = superhero[@"description"];
           cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
           return cell;
           
       }

    @end
