//
//  RealityController.h
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface RealityController : NSObject

@property (nonatomic, strong) User *activeUser;
@property (nonatomic, strong) NSMutableArray<User*> *users;
@property (assign) BOOL isOngoing;
@property (assign) char previousCommand;

- (id)initWithStatus:(BOOL)isOngoing;
- (void)changeActiveUser:(NSString *)name;
- (void)printUsers;
- (void)printActiveUser;
- (NSString *)getUserInput;
- (NSMutableArray *)getUserNames;
- (void)printCommands;
- (NSMutableArray *)getShorthandCommands;
- (BOOL)isNamespaced:(NSString *)userInput;
- (BOOL)isNameUnique:(NSString *)name;
- (NSString *)getNewName:(NSString *)name;
- (void)printGameStatus;

@end
