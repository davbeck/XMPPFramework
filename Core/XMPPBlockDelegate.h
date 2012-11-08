#import <Foundation/Foundation.h>
#import "XMPPStream.h"

/**
 * An XMPPBlockDelegate is an internal class that handles a block callback for IQ results
 **/

@interface XMPPBlockDelegate : NSObject <XMPPStreamDelegate>

/**
 * The returned object will automatically add itself as a delegate
 * and listen for a result or error iq with iqId.
 * Once the proper IQ is recieved, the object removes itself as a delegate
 **/
+ (id)delegateWithStream:(XMPPStream *)stream iqId:(NSString *)iqId resultBlock:(XMPPIQResultBlock)resultBlock;

@end
