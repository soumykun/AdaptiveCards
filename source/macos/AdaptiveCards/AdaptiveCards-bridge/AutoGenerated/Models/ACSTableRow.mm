// DO NOT EDIT - Auto generated

// Generated with objc_viewmodel.j2

#import "SwiftInterfaceHeader.h"

#import "ACSTableCell.h"
#import "ACSVerticalContentAlignmentConvertor.h"
#import "ACSHorizontalAlignmentConvertor.h"
#import "ACSContainerStyleConvertor.h"

//cpp includes
#import "Enums.h"
#import "TableCell.h"


#import "ACSTableRow.h"
#import "TableRow.h"



@implementation  ACSTableRow {
    std::shared_ptr<TableRow> mCppObj;
}

- (instancetype _Nonnull)initWithTableRow:(const std::shared_ptr<TableRow>)cppObj
{
    if (self = [super initWithBaseCardElement: cppObj])
    {
        mCppObj = cppObj;
    }
    return self;
}

- (NSArray<ACSTableCell *> * _Nonnull)getCells
{
 
    auto getCellsCpp = mCppObj->GetCells();
    NSMutableArray*  objList = [NSMutableArray new];
    for (const auto& item: getCellsCpp)
    {
        [objList addObject: [[ACSTableCell alloc] initWithTableCell:item]];
    }
    return objList;


}

- (void)setCells:(NSArray<ACSTableCell *>* _Nonnull)value
{
	// 	    std::vector<AdaptiveCards::TableCell> valueVector;
    // for (id valueObj in value)
    // {
    //     valueVector.push_back([ACSTableCellConvertor convertObj:valueObj]);
    // }

 
    // mCppObj->SetCells(valueVector);
    
}

- (ACSVerticalContentAlignment)getVerticalCellContentAlignment
{
 
    auto getVerticalCellContentAlignmentCpp = mCppObj->GetVerticalCellContentAlignment();
    return getVerticalCellContentAlignmentCpp.has_value() ? [ACSVerticalContentAlignmentConvertor convertCpp:getVerticalCellContentAlignmentCpp.value_or(AdaptiveCards::VerticalContentAlignment::Top)] : ACSVerticalContentAlignmentNil;

}

- (void)setVerticalCellContentAlignment:(enum ACSVerticalContentAlignment)value
{
		
    auto valueCpp = [ACSVerticalContentAlignmentConvertor convertObj:value];
 
    mCppObj->SetVerticalCellContentAlignment(valueCpp);
    
}

- (ACSHorizontalAlignment)getHorizontalCellContentAlignment
{
 
    auto getHorizontalCellContentAlignmentCpp = mCppObj->GetHorizontalCellContentAlignment();
    return getHorizontalCellContentAlignmentCpp.has_value() ? [ACSHorizontalAlignmentConvertor convertCpp:getHorizontalCellContentAlignmentCpp.value_or(AdaptiveCards::HorizontalAlignment::Left)] : ACSHorizontalAlignmentNil;

}

- (void)setHorizontalCellContentAlignment:(enum ACSHorizontalAlignment)value
{
		
    auto valueCpp = [ACSHorizontalAlignmentConvertor convertObj:value];
 
    mCppObj->SetHorizontalCellContentAlignment(valueCpp);
    
}

- (ACSContainerStyle)getStyle
{
 
    auto getStyleCpp = mCppObj->GetStyle();
    return [ACSContainerStyleConvertor convertCpp:getStyleCpp];

}

- (void)setStyle:(enum ACSContainerStyle)value
{
		
    auto valueCpp = [ACSContainerStyleConvertor convertObj:value];
 
    mCppObj->SetStyle(valueCpp);
    
}


@end
