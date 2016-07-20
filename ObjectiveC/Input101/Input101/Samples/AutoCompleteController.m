//
//  AutoCompleteController.m
//  Input101
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "AutoCompleteController.h"
@import XuniInputDynamicKit;
#import "AutoCompleteData.h"

@interface AutoCompleteController ()<UITableViewDelegate,UITableViewDataSource,XuniAutoCompleteDelegate>
@property (weak, nonatomic) IBOutlet XuniAutoComplete *customDropdown;
@property (weak, nonatomic) IBOutlet XuniAutoComplete *highlightDropdown;
@property (weak, nonatomic) IBOutlet XuniAutoComplete *delayDropdown;
@property (weak, nonatomic) IBOutlet XuniAutoComplete *filterDropdown;

@end

@implementation AutoCompleteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AutoComplete";
    // Do any additional setup after loading the view.
    
    _highlightDropdown.dropDownHeight = 200;
    _highlightDropdown.displayMemberPath = @"name";
    _highlightDropdown.isAnimated = YES;
    _highlightDropdown.itemsSource = [AutoCompleteData demoData];
	_highlightDropdown.showButton = NO;

    _delayDropdown.dropDownHeight = 200;
    _delayDropdown.displayMemberPath = @"name";
    _delayDropdown.isAnimated = YES;
    _delayDropdown.itemsSource = [AutoCompleteData demoData];
    _delayDropdown.delay = 1000;
	_delayDropdown.showButton = NO;
    
//    _customDropdown.autoComplete = self;
    _customDropdown.tableView.delegate = self;
    _customDropdown.tableView.dataSource = self;
    _customDropdown.dropDownHeight = 200;
    _customDropdown.displayMemberPath = @"name";
    _customDropdown.isAnimated = YES;
    _customDropdown.highlightedColor = [UIColor redColor];
    _customDropdown.itemsSource = [AutoCompleteData demoData1];
    
    _filterDropdown.dropDownHeight = 200;
    _filterDropdown.displayMemberPath = @"name";
    _filterDropdown.isAnimated = YES;
    _filterDropdown.delegate = self;
    _filterDropdown.itemsSource = [AutoCompleteData demoData];
    _filterDropdown.filteringArgs.cancel = YES;
    
}

-(void)filtering:(XuniAutoComplete *)sender eventArgs:(XuniAutoCompleteFilteringEventArgs *)eventArgs
{
    sender.collectionView.filter = ^ BOOL (NSObject *item){
        AutoCompleteData *data = (AutoCompleteData*)item;
        NSString *string = data.name;
        if ([[[string substringToIndex:1] lowercaseString] isEqualToString:@"b"]) {
            return true;
        }
        return false;
    };
    sender.itemsSource = [NSMutableArray arrayWithArray:sender.collectionView.items];
//    sender.filteringArgs.cancel = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _customDropdown.temporaryItemSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"simpleIdentifier"];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"simpleIdentifier"];
    }
    
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:122 / 255.0 blue:255 / 255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedBackgroundView;
    [cell.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    CGRect rect = cell.contentView.frame;
    AutoCompleteData *data = (AutoCompleteData *)[_customDropdown.temporaryItemSource objectAtIndex:indexPath.row];
    NSString *imageName = data.imageString;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    image.frame = CGRectMake(8, 0, 48, 48);
    [cell.contentView addSubview:image];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(65, 10, rect.size.width - 40, rect.size.height / 2)];
    label1.text = data.name;
    [cell.contentView addSubview:label1];
    
    [_customDropdown normalizeCellText:label1 WithSubstring:label1.text];
    if(_customDropdown.filterString)
    {
        [_customDropdown highlightedSubstring:_customDropdown.filterString inFilterCellText:label1];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset.
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings.
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set cell's layout margins.
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _customDropdown.selectedIndex = indexPath.row;
    _customDropdown.isDropDownOpen = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
