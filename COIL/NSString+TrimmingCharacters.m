//
//  NSString+TrimmingCharacters.m
//  COIL
//
//  Created by Aseem 9 on 11/02/16.
//  Copyright © 2016 Aseem 9. All rights reserved.
//

#import "NSString+TrimmingCharacters.h"

@implementation NSString (TrimmingCharacters)
-(NSString *)StringByEscapingCharacters
{
   return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end
