//
//  AnmalHinderViewController.m
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production.
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import "AnmalHinderViewController.h"
#import "DescriptionViewController.h"

@implementation AnmalHinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appdel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    categoriesArray = [[NSMutableArray alloc] init];
    arrowImagesArray  = [[NSMutableArray alloc] init];
    savedDataDict = [[NSMutableDictionary alloc] init];

    
    [stageLabel setTextColor:BtnBgColor];
    [headerLabel setTextColor:AppBlueColor];
    [infoBgView setBackgroundColor:AppBlueColor];
    [nextBtn setBackgroundColor:BtnBgColor];
    
    if (IS_IPHONE_4_OR_LESS) {
        [formScroll setContentSize:CGSizeMake(320, 568)];
    }

    [self performSelector:@selector(afterViewDidLoad) withObject:nil afterDelay:0.005];
    
}


-(void)afterViewDidLoad
{
    
    categoriesArray = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CategoriesList" ofType:@"plist"]];

    
    isFromViewDidLoad = YES;
    isScrolledToRow = YES;
    isMainCatSelected = NO;
    isSubCatSelected = NO;
    selectedSectionIndex = 0;
    selectedRowIndex = 0;
    selectedAnmalTitle = @"";

    
    if ([appdel.userDefaultObject objectForKey:AnmalDataKey]) {
        savedDataDict = [appdel.userDefaultObject objectForKey:AnmalDataKey];
        
        if ([savedDataDict objectForKey:@"selected_cat"]) {
            selectedAnmalTitle = [savedDataDict objectForKey:@"selected_cat"];
            
            if ([[savedDataDict objectForKey:@"is_main_cat_selected"] intValue] == 1) {
                isMainCatSelected = YES;
                selectedSectionIndex =[[savedDataDict objectForKey:@"selected_section"] intValue];
            }
            
            if ([[savedDataDict objectForKey:@"is_sub_cat_selected"] intValue] == 1) {
                isSubCatSelected = YES;
                selectedSectionIndex =[[savedDataDict objectForKey:@"selected_section"] intValue];
                selectedRowIndex =[[savedDataDict objectForKey:@"selected_row"] intValue];
            }
        }
    }
    
    
    NSString *arrowNameStr = @"";
    
    for (int i=0; i<categoriesArray.count; i++) {
        
        if (i%2 == 0) {
            arrowNameStr = @"arrow_down_white.png";
        }
        else
        {
            arrowNameStr = @"arrow_down_gray.png";
        }
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(272, 0, 29, 13)];
        [arrowImage setImage:[UIImage imageNamed:arrowNameStr]];
        [arrowImage setHidden:YES];
        arrowImage.tag = i;
        
        [arrowImagesArray addObject:arrowImage];
    }
    
    boolArray = [[NSMutableArray alloc] init];
    
    BOOL isArrow = NO;
    
    for (int i=0;i<categoriesArray.count;i++) {
        [boolArray addObject:[NSNumber numberWithBool:NO]];
        
        [[categoriesArray objectAtIndex:i] setObject:@"no" forKey:@"is_selected"];
        [[categoriesArray objectAtIndex:i] setObject:[NSString stringWithFormat:@"%d",isArrow] forKey:@"is_arrow"];
        
        
        if (isMainCatSelected == YES) {
            
            if (selectedSectionIndex < categoriesArray.count) {
                [[categoriesArray objectAtIndex:selectedSectionIndex] setObject:@"yes" forKey:@"is_selected"];
            }
        }
        
        
        NSMutableArray *subArray = [[NSMutableArray alloc] initWithArray:[[categoriesArray objectAtIndex:i] objectForKey:@"sub_cats"]];
        
        for (int j=0; j<subArray.count; j++) {
            NSMutableDictionary *subDict = [[NSMutableDictionary alloc] init];
            [subDict setObject:[subArray objectAtIndex:j] forKey:@"title"];
            [subDict setObject:@"no" forKey:@"is_selected"];
            
            
            if (isSubCatSelected == YES) {
                
                if (selectedSectionIndex < categoriesArray.count) {
                    if (i == selectedSectionIndex) {
                        if (selectedRowIndex < subArray.count) {
                            
                            if (j == selectedRowIndex) {
                                [subDict setObject:@"yes" forKey:@"is_selected"];
                            }
                        }
                    }
                }
            }
            
            [subArray replaceObjectAtIndex:j withObject:subDict];
        }
        
        [[categoriesArray objectAtIndex:i] setObject:subArray forKey:@"sub_cats"];
        
        
        if (isArrow == YES) {
            isArrow = NO;
        }
        
        if (subArray.count > 0) {
            isArrow = YES;
        }
    }
    
    [categoryTable reloadData];

}

#pragma mark - IBACTIONS

-(IBAction)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)nextButtonTapped
{
    if (![appdel.userDefaultObject objectForKey:AnmalDataKey]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select category" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{
        DescriptionViewController *desc = [[DescriptionViewController alloc] init];
        [self.navigationController pushViewController:desc animated:YES];
    }
}


#pragma mark - Tableview Methods

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return categoriesArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
    
}

#define DarkColor [UIColor colorWithRed:(56.0)/255.0   green:(76.0)/255.0   blue:(89.0)/255.0    alpha:(1.0)]


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [headerview setBackgroundColor:[UIColor whiteColor]];
    
    
    NSString *titleStr = [[categoriesArray objectAtIndex:section] objectForKey:@"title"];

    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setFrame:headerview.frame];
    [titleButton setBackgroundColor:[UIColor whiteColor]];
    [titleButton setTitle:[titleStr uppercaseString] forState:UIControlStateNormal];
    titleButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    titleButton.titleLabel.minimumScaleFactor=0.5;
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0]];
    [titleButton addTarget:self action:@selector(sectionTouched:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    titleButton.tag = section;
    titleButton.contentEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 13);
    [headerview addSubview:titleButton];

    if (section == selectedSectionIndex) {
            if (isFromViewDidLoad == YES) {
                isFromViewDidLoad = NO;
                [boolArray replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:([boolArray[section] boolValue])?NO:YES]];
                [categoryTable reloadSections:[NSIndexSet indexSetWithIndex:selectedSectionIndex] withRowAnimation:UITableViewRowAnimationNone];
            }
    }

    
    NSString *upArrowImageName = @"arrow_up_gray.png";
    
    if (section%2 == 0) {
        upArrowImageName = @"arrow_up_white.png";
        [titleButton setBackgroundColor:[UIColor colorWithRed:(232.0/255.0) green:(232.0/255.0) blue:(232.0/255.0) alpha:1.0]];
    }


    NSString *isSelectedStr = [[categoriesArray objectAtIndex:section] objectForKey:@"is_selected"];


    if ([isSelectedStr isEqualToString:@"yes"]) {
        
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [titleButton setBackgroundColor:DarkColor];
    }
    
    
    if (section != 0) {
        
        UIImageView *arrowImageView = (UIImageView *)[arrowImagesArray objectAtIndex:section];
        
        [headerview addSubview:arrowImageView];
        [arrowImageView setFrame:CGRectMake(272, 0, 29, 13)];
        
        if ([[[categoriesArray objectAtIndex:section] objectForKey:@"is_arrow"] intValue] == 1) {
            [arrowImageView setHidden:NO];
        }
        else{
            [arrowImageView setHidden:YES];
        }
        
        if ([[boolArray objectAtIndex:section-1] boolValue] == 1) {
            [arrowImageView setHidden:YES];
        }
    }
    
    if ([[boolArray objectAtIndex:section] boolValue] == 1) {
        
        NSMutableArray *subArray = [[NSMutableArray alloc] initWithArray:[[categoriesArray objectAtIndex:section] objectForKey:@"sub_cats"]];

        if (subArray.count > 0) {
            UIImageView *upArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(272, 37, 29, 13)];
            [upArrowImage setImage:[UIImage imageNamed:upArrowImageName]];
            [headerview addSubview:upArrowImage];
        }
    }
    
    return headerview;
}


- (void)sectionTouched:(UIButton *)sender
{
    isMainCatSelected = YES;
    isSubCatSelected = NO;
    selectedSectionIndex = (int)sender.tag;
    selectedRowIndex = 0;
    
    selectedAnmalTitle = [[categoriesArray objectAtIndex:sender.tag] objectForKey:@"title"];
    [self updateLocalData];
    
    [self resetAllSelectedItems];
    [[categoriesArray objectAtIndex:sender.tag] setObject:@"yes" forKey:@"is_selected"];


    [boolArray replaceObjectAtIndex:sender.tag withObject:[NSNumber numberWithBool:([boolArray[sender.tag] boolValue])?NO:YES]];
    
    [categoryTable reloadData];
}




-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if ([boolArray[section] boolValue])
    {
        NSMutableArray *subArray = [[NSMutableArray alloc] initWithArray:[[categoriesArray objectAtIndex:section] objectForKey:@"sub_cats"]];
        
        return subArray.count;
    }
    else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *rid = [[NSString alloc] initWithFormat:@"Cell-%ld_array", (long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    
    
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:rid];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    NSMutableArray *subArray = [[NSMutableArray alloc] initWithArray:[[categoriesArray objectAtIndex:indexPath.section] objectForKey:@"sub_cats"]];
    
    UIView *cellBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [cellBgView setBackgroundColor:[UIColor whiteColor]];

    
    NSString *titleStr = [[subArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setFrame:CGRectMake(0, 0, 320, 50)];
    [titleButton setBackgroundColor:[UIColor whiteColor]];
    [titleButton setTitle:[titleStr uppercaseString] forState:UIControlStateNormal];
    titleButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    titleButton.titleLabel.minimumScaleFactor=0.5;
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0]];
    [titleButton addTarget:self action:@selector(cellButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    titleButton.tag = indexPath.row;
    titleButton.contentEdgeInsets = UIEdgeInsetsMake(0, 38, 0, 13);
    [cellBgView addSubview:titleButton];

    
    if (indexPath.section%2 == 0) {
        if (indexPath.row%2 == 0) {
            [titleButton setBackgroundColor:[UIColor whiteColor]];
        }
        else{
            [titleButton setBackgroundColor:[UIColor colorWithRed:(232.0/255.0) green:(232.0/255.0) blue:(232.0/255.0) alpha:1.0]];
        }
    }
    else{
        if (indexPath.row%2 == 0) {
            [titleButton setBackgroundColor:[UIColor colorWithRed:(232.0/255.0) green:(232.0/255.0) blue:(232.0/255.0) alpha:1.0]];
        }
        else{
            [titleButton setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
    
    NSString *isSelectedStr = [[subArray objectAtIndex:indexPath.row] objectForKey:@"is_selected"];
    
    if ([isSelectedStr isEqualToString:@"yes"]) {
        
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [titleButton setBackgroundColor:DarkColor];
    }
    
    
    [cell addSubview:cellBgView];
    
    return cell;
}



- (void)cellButtonTapped:(UIButton *)sender
{
    
    NSIndexPath *indexPath = [categoryTable indexPathForCell:(UITableViewCell *)sender.superview.superview];
    
    isMainCatSelected = NO;
    isSubCatSelected = YES;
    
    selectedSectionIndex = (int)indexPath.section;
    selectedRowIndex = (int)indexPath.row;

    [self resetAllSelectedItems];
    
    NSMutableArray *subArray = [[NSMutableArray alloc] initWithArray:[[categoriesArray objectAtIndex:indexPath.section] objectForKey:@"sub_cats"]];
    
    selectedAnmalTitle = [NSString stringWithFormat:@"%@",[[subArray objectAtIndex:indexPath.row] objectForKey:@"title"]];

    [self updateLocalData];
    
    [[subArray objectAtIndex:indexPath.row] setObject:@"yes" forKey:@"is_selected"];
    [[categoriesArray objectAtIndex:indexPath.section] setObject:subArray forKey:@"sub_cats"];
    
    [categoryTable reloadData];
    
}

-(void)resetAllSelectedItems
{
    for (int i=0;i<categoriesArray.count;i++) {
        [[categoriesArray objectAtIndex:i] setObject:@"no" forKey:@"is_selected"];
        
        NSMutableArray *subArray = [[NSMutableArray alloc] initWithArray:[[categoriesArray objectAtIndex:i] objectForKey:@"sub_cats"]];
        
        for (int j=0; j<subArray.count; j++) {
            [[subArray objectAtIndex:j] setObject:@"no" forKey:@"is_selected"];
        }
        [[categoriesArray objectAtIndex:i] setObject:subArray forKey:@"sub_cats"];
    }
}




-(void)updateLocalData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:selectedAnmalTitle forKey:@"selected_cat"];

    [dict setObject:[NSString stringWithFormat:@"%d",isMainCatSelected] forKey:@"is_main_cat_selected"];
    [dict setObject:[NSString stringWithFormat:@"%d",isSubCatSelected] forKey:@"is_sub_cat_selected"];
    
    [dict setObject:[NSString stringWithFormat:@"%d",selectedSectionIndex] forKey:@"selected_section"];
    [dict setObject:[NSString stringWithFormat:@"%d",selectedRowIndex] forKey:@"selected_row"];
    
    [appdel.userDefaultObject setObject:dict forKey:AnmalDataKey];
    [appdel.userDefaultObject synchronize];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
