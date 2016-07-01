//
//  AppDelegate.h
//  iChatWithXMPP
//
//  Created by Rajesh on 6/29/16.
//  Copyright © 2016 Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "XMPP.h"
#import "XMPPRoster.h"
#import "XMPPLogging.h"

@protocol MessageDelegate <NSObject>

- (void)newMessageReceived:(NSString *)message from:(NSString *)from;

@end

@interface User : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) XMPPStream *xmppStream;
@property (nonatomic, strong) XMPPRoster *xmppRoster;
@property (nonatomic, assign) id <MessageDelegate> messageDelegate;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) User *user;

- (BOOL)connect;

@end

