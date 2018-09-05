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

@implementation RealityController

- (id)initWithStatus:(BOOL)isOngoing {
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
    NSArray *COMMANDS = [NSArray arrayWithObjects:@"s = Switch user", @"p = view Pokedex", @"e = Edit pokemon name", @"r = Release pokemon", @"h = Hunt pokemon", @"c = Create user", @"t = Trade pokemon", @"d = Done", nil];
    NSLog(@"\n");
    NSLog(@"COMMANDS:\n");
    for (NSString *command in COMMANDS) {
        NSLog(@"%@", command);
    }
    NSLog(@"\n");
}

@end
