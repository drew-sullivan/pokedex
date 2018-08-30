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

- (Person *)changeActivePerson:(NSString *)name {
    for (Person *person in self.people) {
        if ([person.name isEqualToString:name]) {
            return person;
            break;
        }
    }
    return nil;
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
    return inputString;
}

@end
