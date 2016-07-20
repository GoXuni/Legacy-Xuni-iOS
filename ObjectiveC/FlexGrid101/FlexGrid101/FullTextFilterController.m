//
//  FullTextFilterController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "FullTextFilterController.h"
#import "CustomerData.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"


@interface FullTextFilterController ()
@property (weak, nonatomic) IBOutlet UITextField *filterField;
@property (weak, nonatomic) IBOutlet FlexGrid *flex;

@end

@implementation FullTextFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filterField.returnKeyType = UIReturnKeyDone;
    self.filterField.keyboardType = UIKeyboardTypeDefault;
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.isReadOnly = true;
    self.flex.itemsSource = [CustomerData getCustomerData:100];
    
    
    [self.flex.flexGridFormatItem addHandler:^(XuniEventContainer<GridFormatItemEventArgs *> *eventContainer) {
        if(eventContainer.eventArgs.panel == self.flex.cells)
        {
            if([self.flex.editRange intersects:eventContainer.eventArgs.cellRange]) return;
            if(self.flex.columns[eventContainer.eventArgs.col].dataType==XuniDataTypeBoolean) return;
            
            NSError *error;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: self.filterField.text options:NSRegularExpressionCaseInsensitive error:&error];
            
            NSString* data = [self.flex getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:true].description;
            
            if (!error)
            {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:data];
                NSArray *allMatches = [regex matchesInString:data options:0 range:NSMakeRange(0, [data length])];
                for (NSTextCheckingResult *aMatch in allMatches)
                {
                    NSRange matchRange = [aMatch range];
                    [attributedString setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.flex.font.pointSize],NSForegroundColorAttributeName:[UIColor redColor]} range: matchRange];
                }
                
                CGRect t = [eventContainer.eventArgs.panel getCellRectForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
                
                GridColumn *col = [self.flex.columns objectAtIndex:eventContainer.eventArgs.col];
                
                CGSize sz = [attributedString size];
                
                NSTextAlignment align = col.horizontalAlignment;
                
                
                if (align == NSTextAlignmentRight) {
                    double mod = t.size.width - sz.width - 4;
                    if (mod < 4) mod = 4;
                    t.origin.x += mod;
                } else if (align == NSTextAlignmentCenter) {
                    double mod = (t.size.width - sz.width) / 2;
                    if (mod < 4) mod = 4;
                    t.origin.x += mod;
                } else {
                    t.origin.x += 4;
                }
                
                double mod = (t.size.height - sz.height) / 2;
                if (mod < 4) mod = 4;
                
                t.origin.y += mod;
                
                [attributedString drawInRect:t];
                eventContainer.eventArgs.cancel = true;
            }
        }

    } forObject:self];
    
}

- (IBAction)onTextChange:(UITextField *)sender {
    UITextField* textField = sender;
    FlexGrid *flex =  self.flex;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy"];
    
    if(textField.text.length)
    {
        flex.collectionView.filter = ^ BOOL (NSObject *item){
            CustomerData *d = (CustomerData*)item;
            
            if ([[NSString stringWithFormat:@"%lu", d.customerID].lowercaseString containsString:textField.text.lowercaseString]) {
                return true;
            }
            else if ([[NSString stringWithFormat:@"%lu", d.countryID].lowercaseString containsString:textField.text.lowercaseString]) {
                return true;
            }
            else if ([[NSString stringWithFormat:@"%@", d.email].lowercaseString containsString:textField.text.lowercaseString]) {
                return true;
            }
            else if ([d.firstName.lowercaseString containsString:textField.text.lowercaseString]) {
                return true;
            }
            else if ([d.lastName.lowercaseString containsString:textField.text.lowercaseString])
            {
                return true;
            }
            else if ([d.country.lowercaseString containsString:textField.text.lowercaseString]){
                return true;
            }
            else if ([d.city.lowercaseString containsString:textField.text.lowercaseString]){
                return true;
            }
            else if ([d.address.lowercaseString containsString:textField.text.lowercaseString]){
                return true;
            }
            else if ([[dateFormat stringFromDate:d.lastOrderDate].lowercaseString containsString:textField.text.lowercaseString]) {
                return true;
            }
            else {
                return false;
            }
        };
    }
    else
    {
        flex.collectionView.filter = nil;
    }

}



- (IBAction)finishedit:(UITextField *)sender {
    [sender resignFirstResponder];
}



@end
