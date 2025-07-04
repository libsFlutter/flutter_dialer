# Changelog

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
