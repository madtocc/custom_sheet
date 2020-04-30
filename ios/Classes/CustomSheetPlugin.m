#import "CustomSheetPlugin.h"
#if __has_include(<custom_sheet/custom_sheet-Swift.h>)
#import <custom_sheet/custom_sheet-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "custom_sheet-Swift.h"
#endif

@implementation CustomSheetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCustomSheetPlugin registerWithRegistrar:registrar];
}
@end
