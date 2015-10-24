// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from museinfo.djinni

#import <Foundation/Foundation.h>

/** Provides access to Muse firmware and hardware versions. */

@interface IXNMuseVersion : NSObject
- (id)initWithMuseVersion:(IXNMuseVersion *)museVersion;
- (id)initWithRunningState:(NSString *)runningState hardwareVersion:(NSString *)hardwareVersion firmwareVersion:(NSString *)firmwareVersion bootloaderVersion:(NSString *)bootloaderVersion firmwareBuildNumber:(NSString *)firmwareBuildNumber firmwareType:(NSString *)firmwareType protocolVersion:(int32_t)protocolVersion;

/** Provides access to the running state (app / bootloader / test). */
@property (nonatomic, readonly) NSString *runningState;

/** Provides access to hardware version. */
@property (nonatomic, readonly) NSString *hardwareVersion;

/** Provides access to firmware version. */
@property (nonatomic, readonly) NSString *firmwareVersion;

/** Provides access to Muse bootloader version. */
@property (nonatomic, readonly) NSString *bootloaderVersion;

/** Provides access to Muse firmware build number. */
@property (nonatomic, readonly) NSString *firmwareBuildNumber;

/** Type of firmware (consumer, research, test). */
@property (nonatomic, readonly) NSString *firmwareType;

/** Provides access to Muse communication protocol version. */
@property (nonatomic, readonly) int32_t protocolVersion;

@end