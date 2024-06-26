// DO NOT EDIT - Auto generated

// Generated with objc_viewmodel.j2

#import "SwiftInterfaceHeader.h"
	
#import "ACSColumn.h"
#import "ACSParseContext.h"
#import "ACSRemoteResourceInformationConvertor.h"
#import "ACSHorizontalAlignmentConvertor.h"

//cpp includes
#import "Column.h"
#import "json.h"
#import "Enums.h"
#import "RemoteResourceInformation.h"


#import "ACSColumnSet.h"
#import "ColumnSet.h"


@implementation  ACSColumnSet {
    std::shared_ptr<ColumnSet> mCppObj;
}

- (instancetype _Nonnull)initWithColumnSet:(const std::shared_ptr<ColumnSet>)cppObj
{
    if (self = [super initWithStyledCollectionElement: cppObj])
    {
        mCppObj = cppObj;
    }
    return self;
}


- (NSArray<ACSColumn *> * _Nonnull)getColumns
{
 
    auto getColumnsCpp = mCppObj->GetColumns();
    NSMutableArray*  objList = [NSMutableArray new];
    for (const auto& item: getColumnsCpp)
    {
        [objList addObject: [[ACSColumn alloc] initWithColumn:item]];
    }
    return objList;


}


- (void)getResourceInformation:(NSArray<ACSRemoteResourceInformation *>* _Nonnull)resourceInfo
{
    std::vector<AdaptiveCards::RemoteResourceInformation> resourceInfoVector;
    for (id resourceInfoObj in resourceInfo)
    {
        resourceInfoVector.push_back([ACSRemoteResourceInformationConvertor convertObj:resourceInfoObj]);
    }

 
    mCppObj->GetResourceInformation(resourceInfoVector);
    
}

- (ACSHorizontalAlignment)getHorizontalAlignment
{

    auto getHorizontalAlignmentCpp = mCppObj->GetHorizontalAlignment();
    return [ACSHorizontalAlignmentConvertor convertCpp:getHorizontalAlignmentCpp];

}

- (void)setHorizontalAlignment:(enum ACSHorizontalAlignment)value
{
    auto valueCpp = [ACSHorizontalAlignmentConvertor convertObj:value];
 
    mCppObj->SetHorizontalAlignment(valueCpp);

}




@end
