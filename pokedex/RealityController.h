//
//  RealityController.h
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface RealityController : NSObject

@property (nonatomic, strong) Person *activePlayer;
@property (nonatomic, strong) NSMutableArray<Person*> *people;
@property (assign) BOOL isOngoing;
@property (assign) char previousCommand;

- (id)initWithStatus:(BOOL)isOngoing;
- (void)changeActivePerson:(NSString *)name;
- (void)printPeople;
- (void)printActivePlayer;
- (NSString *)getUserInput;
- (NSMutableArray *)getUserNames;
- (void)printCommands;
- (NSMutableArray *)getShorthandCommands;
- (BOOL)isNamespaced:(NSString *)userInput;
- (BOOL)isNameUnique:(NSString *)name;
- (NSString *)getNewName:(NSString *)name;

@end
