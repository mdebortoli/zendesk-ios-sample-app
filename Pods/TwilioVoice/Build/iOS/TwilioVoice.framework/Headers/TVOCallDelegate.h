//
//  TVOCallDelegate.h
//  TwilioVoice
//
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

@class TVOCall;

/**
 *  `TVOCallDelegate` provides callbacks when important changes to a `TVOCall` occur.
 */
@protocol TVOCallDelegate <NSObject>

/**
 * @name Required Methods
 */

/**
 * @brief Notifies the delegate that a Call has connected.
 *
 * @param call The `<TVOCall>` that was connected.
 *
 * @see TVOCall
 */
- (void)callDidConnect:(nonnull TVOCall *)call;

/**
 * @brief Notifies the delegate that a Call has failed to connect.
 *
 * @param call The `<TVOCall>` that failed to connect.
 * @param error The `<NSError>` that occurred.
 *
 * @see TVOCall
 */
- (void)call:(nonnull TVOCall *)call didFailToConnectWithError:(nonnull NSError *)error;

/**
 * @brief Notifies the delegate that a Call has disconnected.
 *
 * @param call The `<TVOCall>` that was disconnected.
 * @param error An `NSError` describing why disconnect occurred, or `nil` if the disconnect was expected.
 *
 * @see TVOCall
 */
- (void)call:(nonnull TVOCall *)call didDisconnectWithError:(nullable NSError *)error;

/**
 * @name Optional Methods
 */

@optional
/**
 * @brief Notifies the delegate that the called party is being alerted of a Call.
 *
 * @param call The `<TVOCall>` that the called party is being alerted of.
 *
 * @discussion This callback is invoked once before the `[TVOCallDelegate callDidConnect:]` callback. If
 * the `answerOnBridge` is `true` this represents the callee is being alerted of a Call.
 *
 * @see TVOCall
 */
- (void)callDidStartRinging:(nonnull TVOCall *)call;

/**
 * @brief Notifies the delegate that a Call starts to reconnect due to network change event.
 *
 * @discussion Reconnect is triggered when a network change is detected and Call is already in `TVOCallStateConnected` state.
 * If the call is either in `TVOCallStateConnecting` or in `TVOCallStateRinging` when network change happened
 * then the current call will disconnect.
 *
 * @param call The `<TVOCall>` that is reconnecting.
 * @param error The `<NSError>` that describes the reconnect reason. This would have one of the two possible values
 * with error codes `TVOErrorSignalingConnectionDisconnectedError` and `TVOErrorMediaConnectionError`.
 *
 * @see TVOCall
 */
- (void)call:(nonnull TVOCall *)call isReconnectingWithError:(nonnull NSError *)error;

/**
 * @brief Notifies the delegate that a Call is reconnected.
 *
 * @param call The `<TVOCall>` that is reconnected.
 *
 * @see TVOCall
 */
- (void)callDidReconnect:(nonnull TVOCall *)call;

@end
