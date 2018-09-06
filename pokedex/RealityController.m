//
//  RealityController.m
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RealityController.h"
#import "Person.h"

static NSArray *COMMANDS = nil;

@implementation RealityController

- (id)initWithStatus:(BOOL)isOngoing {
    COMMANDS = [NSArray arrayWithObjects:@"h = [h]unt pokemon",
                                         @"p = view [p]okedex",
                                         @"e = [e]dit pokemon name",
                                         @"r = [r]elease pokemon",
                                         @"t = [t]rade pokemon in for pokeballs",
                                         @"g = print [g]ame status",
                                         @"c = [c]reate user",
                                         @"s = [s]witch user",
                                         @"d = [d]one",
                                         nil];
    self = [super init];
    if (self) {
        self.isOngoing = isOngoing;
        self.people = [[NSMutableArray alloc] initWithCapacity:4];
    }
    return self;
}

- (void)changeActivePerson:(NSString *)name {
    for (Person *person in self.people) {
        if ([[person.name lowercaseString]isEqualToString:[name lowercaseString]]) {
            self.activePlayer = person;
            NSLog(@"Active User changed to: %@", self.activePlayer.name);
            return;
        }
    }
    NSLog(@"No such user.");
}

- (void)printPeople {
    for (Person *person in self.people) {
        NSLog(@"%@", person.name);
    }
}

- (void)printActivePlayer {
    NSLog(@"%@", self.activePlayer.name);
}

- (NSString *)getUserInput {
    NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
    NSData *inputData = [NSData dataWithData:[input availableData]];
    NSString *inputString = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
    inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *userInput = [inputString lowercaseString];
    return userInput;
}

- (NSMutableArray *)getUserNames {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for (Person *person in self.people) {
        [names addObject:[person.name capitalizedString]];
    }
    return names;
}

- (void)printCommands {
    NSLog(@"\n");
    NSLog(@"COMMANDS:\n");
    for (NSString *command in COMMANDS) {
        NSLog(@"%@", command);
    }
    NSLog(@"\n");
}

- (NSMutableArray *)getShorthandCommands {
    NSMutableArray *shorthandCommands = [[NSMutableArray alloc] init];
    for (NSString *command in COMMANDS) {
        NSString *shorthandCommand = [command substringToIndex:1];
        [shorthandCommands addObject:shorthandCommand];
    }
    return shorthandCommands;
}

- (NSArray *)getCommands {
    return COMMANDS;
}

- (BOOL)isNamespaced:(NSString *)letter {
    for (NSString *shorthandCommand in [self getShorthandCommands]) {
        if ([letter isEqualToString:shorthandCommand]) {
            NSLog(@"Sorry! That's a namespaced command!");
            return true;
        }
    }
    return false;
}

- (BOOL)isNameUnique:(NSString *)name {
    for (NSString *existingName in [self getUserNames]) {
        if ([name isEqualToString:[existingName lowercaseString]]) {
            return false;
        }
    }
    return true;
}

- (NSString *)getNewName:(NSString *)oldName {
    NSString *numberString;
    NSScanner *scanner = [NSScanner scannerWithString:oldName];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    int number = [numberString integerValue];
    NSString *newName = [NSString stringWithFormat:@"%@-%i", oldName, number + 1];
    return newName;
}

- (void)printGameStatus {
    NSLog(@"\n");
    NSLog(@"GAME STATUS:\n");
    for (Person *person in self.people) {
        NSLog(@"\n");
        NSLog(@"%@", [person.name uppercaseString]);
        NSLog(@"NUM POKEBALLS: %i", person.numPokeballs);
        [person viewPokedex];
    }
}

@end
