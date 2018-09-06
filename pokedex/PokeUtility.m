//
//  Utility.m
//  pokedex
//
//  Created by Drew Sullivan on 9/6/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokeUtility.h"

@implementation PokeUtility

+ (NSString *)getUserInput {
    NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
    NSData *inputData = [NSData dataWithData:[input availableData]];
    NSString *inputString = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
    inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *userInput = [inputString lowercaseString];
    return userInput;
}

@end
