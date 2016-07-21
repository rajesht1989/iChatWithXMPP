//
//  GroupChatViewController.m
//  iChatWithXMPP
//
//  Created by Rajesh on 7/21/16.
//  Copyright © 2016 Org. All rights reserved.
//

#import "GroupChatViewController.h"
#import "AppDelegate.h"

@interface GroupChatViewController () <MessageDelegate,RoomDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *chatView;
@property (weak, nonatomic) IBOutlet UITextField *groupTextField;

@property (weak, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) XMPPRoom *room;

@end

@implementation GroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (AppDelegate *)appDelegate {
    if (!_appDelegate) {
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [_appDelegate setRoomDelegate:self];
        [_appDelegate setMessageDelegate:self];
    }
    return _appDelegate;
}
- (IBAction)createChat:(id)sender {
    if (_groupTextField.text.length > 0) {
        [[self appDelegate] createRoom:_groupTextField.text];
    }
}

- (void)roomCreated:(XMPPRoom *)room {
    [self setRoom:room];
}

- (IBAction)sendMessageNow:(id)sender
{
    if (!_room) {
        NSLog(@"Please create a room");
        return;
    }
    NSString *messageStr = _textView.text;
    if([messageStr length] > 0)
    {
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:messageStr];
        NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
        [message addAttributeWithName:@"type" stringValue:@"chat"];
        [message addChild:body];

        [_room sendMessage:[XMPPMessage messageFromElement:body]];
        
        [_textView setText:nil];
    }
}


- (void)newMessageReceived:(NSString *)message from:(NSString *)from {
    [_chatView setText:[NSString stringWithFormat:@"%@\n%@\n%@\n",_chatView.text,from,message]];
    [self scrollTextViewToBottom:_chatView];
}


- (void)scrollTextViewToBottom:(UITextView *)textView {
    if(textView.text.length > 0 ) {
        NSRange bottom = NSMakeRange(textView.text.length -1, 1);
        [textView scrollRangeToVisible:bottom];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
