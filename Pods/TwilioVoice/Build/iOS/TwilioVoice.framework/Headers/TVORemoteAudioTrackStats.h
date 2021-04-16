//
//  TVORemoteAudioTrackStats.h
//  TwilioVoice
//
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

#import "TVORemoteTrackStats.h"

/**
 * `TVORemoteAudioTrackStats` represents stats about a remote audio track.
 */
@interface TVORemoteAudioTrackStats : TVORemoteTrackStats

/**
 * @brief Audio output level.
 */
@property (nonatomic, assign, readonly) NSUInteger audioLevel;

/**
 * @brief Packet jitter measured in milliseconds.
 */
@property (nonatomic, assign, readonly) NSUInteger jitter;

/**
 *  @brief Developers shouldn't initialize this class directly.
 *
 *  @discussion Remote audio track stats cannot be created explicitly.
 */
- (null_unspecified instancetype)init __attribute__((unavailable("TVORemoteAudioTrackStats cannot be created explicitly.")));

@end
