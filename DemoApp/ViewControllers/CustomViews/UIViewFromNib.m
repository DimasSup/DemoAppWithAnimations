//  Created by DimasSup on 25.06.14.

#import "UIViewFromNib.h"

@implementation UIViewFromNib

-(instancetype)initWithFrame:(CGRect)frame
{
    Class class = [self class];
    return [self initWithFrame:frame andNibName:NSStringFromClass(class)];
}

- (id)initWithFrame:(CGRect)frame andNibName:(NSString*)nibName
{
    @autoreleasepool {
        
        self =  [super initWithFrame:frame];
        
        Class class = [self class];
        
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:nibName
                                                          owner:self
                                                        options:nil];
        
        [self release];
        self = nil;
        for (id v in nibViews)
        {
            if([v isKindOfClass:class])
            {
                self = [v retain];
                break;
            }
        }
        
        if (self)
        {
            if(!CGRectIsEmpty(frame))
            {
                self.frame = frame;
            }
            
        }
        return self;
        
    }
}


@end
