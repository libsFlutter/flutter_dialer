# Changelog

## [2.0.0+101] - 2024-12-19

### Updated
- Package version updated to 2.0.0+101
- Prepared for publication to pub.dev

## [1.0.0+2] - 2024-12-19

### Fixed
- Fixed Android NDK version compatibility issue by updating to NDK 27.0.12077973
- Fixed deprecated TextTheme API usage in example app (headline6 → titleLarge, bodyText1 → bodyLarge, caption → bodySmall)
- Fixed Android activity launch issue by adding FLAG_ACTIVITY_NEW_TASK flag to setDefaultDialer intent
- Added missing Android resource files (styles.xml and launch_background.xml) to resolve build errors

### Technical Improvements
- Updated example/android/app/build.gradle.kts with correct NDK version
- Refactored example/lib/main.dart to use modern Flutter TextTheme API
- Enhanced FlutterDialerPlugin.kt with proper activity launch flags
- Created Android resource structure with proper theme definitions

## [1.0.0+1] - 2024-01-XX

### Added
- Initial release of flutter_dialer plugin
- Support for checking if app is default dialer
- Support for setting app as default dialer
- Support for checking if app can be set as default dialer
- Android InCallService integration for handling calls
- Tel: scheme intent handling
- Comprehensive Android permissions and manifest configuration
- Example app demonstrating all features

### Features
- `FlutterDialer.isDefaultDialer()` - Check if the app is the default dialer
- `FlutterDialer.setDefaultDialer()` - Set the app as the default dialer
- `FlutterDialer.canSetDefaultDialer()` - Check if the app can be set as default dialer

### Android Support
- Android API level 23+ (Android 6.0+)
- TelecomManager integration
- InCallService for call handling
- Proper intent filters for dialer replacement
- Required permissions for dialer functionality

### Documentation
- Comprehensive README with installation instructions
- Usage examples and code samples
- Android manifest configuration guide
- Example app with UI demonstration
