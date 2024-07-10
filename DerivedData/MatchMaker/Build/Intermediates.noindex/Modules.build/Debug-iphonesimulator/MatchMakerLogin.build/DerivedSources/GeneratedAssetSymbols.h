#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"MatchMakerLogin";

/// The "accent" asset catalog color resource.
static NSString * const ACColorNameAccent AC_SWIFT_PRIVATE = @"accent";

/// The "border" asset catalog color resource.
static NSString * const ACColorNameBorder AC_SWIFT_PRIVATE = @"border";

/// The "textGray" asset catalog color resource.
static NSString * const ACColorNameTextGray AC_SWIFT_PRIVATE = @"textGray";

#undef AC_SWIFT_PRIVATE
