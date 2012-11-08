#import "XMPPBlockDelegate.h"
#import "XMPP.h"

@interface XMPPBlockDelegate ()
{
	XMPPStream *_stream;
	NSString *_iqId;
	XMPPIQResultBlock _resultBlock;
	
	id _strongSelf;
}

@end

@implementation XMPPBlockDelegate

/**
 * The returned object will automatically add itself as a delegate
 * and listen for a result or error iq with iqId.
 * Once the proper IQ is recieved, the object removes itself as a delegate
 **/
+ (id)delegateWithStream:(XMPPStream *)stream iqId:(NSString *)iqId resultBlock:(XMPPIQResultBlock)resultBlock
{
	XMPPBlockDelegate *delegate = [[XMPPBlockDelegate alloc] init];
	
	delegate->_stream = stream;
	delegate->_iqId = [iqId copy];
	delegate->_resultBlock = [resultBlock copy];
	delegate->_strongSelf = delegate;
	
	[stream addDelegate:delegate delegateQueue:dispatch_get_current_queue()];
	
	return self;
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
	if ([[iq attributeStringValueForName:@"id"] isEqualToString:_iqId]) {
		_resultBlock(iq, nil);
		
		[_stream removeDelegate:self];
		_strongSelf = nil;
		
		return YES;
	}
	
	return NO;
}

@end
