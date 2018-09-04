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

- (id)initWithStatus:(BOOL)isOngoing;
- (void)changeActivePerson:(NSString *)name;
- (void)printPeople;
- (void)printActivePlayer;
- (NSString *)getUserInput;
- (NSMutableArray *)getUserNames;

@end
