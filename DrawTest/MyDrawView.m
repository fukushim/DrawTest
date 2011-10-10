//
//  MyDrawView.m
//  DrawTest
//
//  Created by 福島 光輝 on 11/10/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


// 描画関係 http://www.stripe-net.jp/cocoa/documents/chapter4/chapter4-7.html
// http://d.hatena.ne.jp/jjj777/
// http://kinokorori.ninja-x.jp/silverlight/bezier_spline.html

#import "MyDrawView.h"
//#import <UIKit/UIKit.h>

@implementation MyDrawView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(NSPoint)genBezier:(NSArray*)array time:(float)t
{
	NSPoint p0 = [[array objectAtIndex:0] pointValue];
	NSPoint p1 = [[array objectAtIndex:1] pointValue];
	NSPoint p2 = [[array objectAtIndex:2] pointValue];
	NSPoint p3 = [[array objectAtIndex:3] pointValue];
	NSPoint retval;
	
	retval.x = p0.x*(1-t)*(1-t)*(1-t) + 3*p1.x*t*(1-t)*(1-t)
	+ 3*p2.x*t*t*(1-t) + p3.x*t*t*t;
	
	retval.y = p0.y*(1-t)*(1-t)*(1-t) + 3*p1.y*t*(1-t)*(1-t)
	+ 3*p2.y*t*t*(1-t) + p3.y*t*t*t;
		
	return retval;
}
- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
//	[[NSColor redColor] set];
//	NSRectFill([self bounds]);
	
	NSMutableArray* array = [[NSMutableArray alloc] init];

	NSPoint point0 = NSMakePoint(0,0);
	[array addObject:[NSValue valueWithPoint:point0]];	
	
	NSPoint point1 = NSMakePoint(0,1);
	[array addObject:[NSValue valueWithPoint:point1]];	
	
	NSPoint point2 = NSMakePoint(1,0);
	[array addObject:[NSValue valueWithPoint:point2]];	
	
	NSPoint point3 = NSMakePoint(1,1);
	[array addObject:[NSValue valueWithPoint:point3]];

	NSBezierPath *thePath = [NSBezierPath bezierPath];
	[thePath moveToPoint:point0];
	
	for( float time = 0; time <= 1.0; time += 0.05 )
	{
		NSPoint point = [self genBezier:array time:time];
		[thePath lineToPoint:NSMakePoint(point.x*100, point.y*100)];
	}
	[array release];
	array = nil;
	

	[NSBezierPath setDefaultLineJoinStyle:NSBevelLineJoinStyle];
	
	
	//[thePath appendBezierPathWithRect:NSMakeRect(50,50,100,100)];
	
	[thePath setLineWidth:1];
	[[NSColor redColor] set];
	
	[thePath stroke];
}
//// 不透明にしたい場合は、このメソッドをオーバーライドして、YESを返す。
//- (BOOL)isOpaque {
//	return YES;
//}
//
//// 座業系をひっくり返す場合は、このメソッドをオーバーライドして、YESを返す。
//- (BOOL)isFlipped {
//    return YES;
//}
@end
