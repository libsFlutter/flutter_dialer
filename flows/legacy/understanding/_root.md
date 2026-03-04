# Understanding: Flutter Dialer Plugin

> Entry point for recursive understanding. Children are top-level logical domains.

## Project Overview

**Flutter plugin for replacing the default dialer app on Android**

- **Platform**: Android only (API level 23+)
- **Architecture**: Flutter plugin with method channel communication
- **Purpose**: Enable Flutter apps to become the system default dialer and handle calls
- **License**: NativeMindNONC

## Validated Understanding

After analyzing source code:

### Core Functionality
1. **Default Dialer Management**: Check/set app as system default dialer via `TelecomManager`
2. **Call Handling**: InCallService monitors call state changes (added, removed, destroyed)
3. **Intent Handling**: MainActivity handles `tel:` scheme and `ACTION_DIAL`/`ACTION_VIEW` intents

### Architecture Pattern
- Flutter Dart API → Platform Interface → Method Channel → Android Plugin
- Standard Flutter plugin architecture with proper separation of concerns

### Key Methods
```dart
FlutterDialer.isDefaultDialer()     // Check if app is default dialer
FlutterDialer.setDefaultDialer()    // Set app as default dialer (opens system dialog)
FlutterDialer.canSetDefaultDialer() // Check if app can be set as default
```

### Android Integration
- Uses `TelecomManager.defaultDialerPackage` for checking default dialer
- Uses `TelecomManager.ACTION_CHANGE_DEFAULT_DIALER` for setting default
- InCallService extends `android.telecom.InCallService`
- Requires multiple phone-related permissions (CALL_PHONE, READ_PHONE_STATE, etc.)

## Identified Domains

> Logical domains discovered. Each becomes a child directory for deeper exploration.

| Domain | Hypothesis | Priority | Status |
|--------|------------|----------|--------|
| flutter-interface | Dart/Flutter API layer - public interface for dialer operations | HIGH | CONFIRMED |
| platform-channel | Method channel communication between Flutter and Android | HIGH | CONFIRMED |
| android-plugin | Android plugin implementation handling system dialer APIs | HIGH | CONFIRMED |
| incall-service | Android InCallService for managing active calls | MEDIUM | CONFIRMED |
| activity-intents | MainActivity handling tel: scheme intents and VIEW/DIAL actions | MEDIUM | CONFIRMED |

## Source Mapping

> Which source paths map to which logical domains

| Source Path | -> Domain |
|-------------|----------|
| `lib/flutter_dialer.dart` | flutter-interface |
| `lib/flutter_dialer_platform_interface.dart` | flutter-interface |
| `lib/flutter_dialer_method_channel.dart` | platform-channel |
| `android/src/main/kotlin/org/tele/flutter_dialer/FlutterDialerPlugin.kt` | android-plugin |
| `android/src/main/kotlin/org/tele/flutter_dialer/TeleService.kt` | incall-service |
| `android/src/main/kotlin/org/tele/flutter_dialer/MainActivity.kt` | activity-intents |

## Cross-Cutting Concerns

> Things that span multiple domains (may become ADRs)

- **Method Channel Protocol**: `flutter_dialer` channel name used across Flutter and Android
- **Error Handling**: PlatformException handling pattern in Dart, try-catch in Kotlin with logging
- **Logging**: Android Log.d/Log.e pattern for debugging (TAG per class)
- **Android Permissions**: CALL_PHONE, READ_PHONE_STATE, MODIFY_PHONE_STATE, ANSWER_PHONE_CALLS, MANAGE_OWN_CALLS
- **API Level**: Android M (API 23+) minimum for dialer management

## Children Spawned

```
[
  "flutter-interface",
  "platform-channel", 
  "android-plugin",
  "incall-service",
  "activity-intents"
]
```

## Flow Recommendations

Based on analysis:

| Domain | Recommended Flow | Rationale |
|--------|------------------|-----------|
| flutter-interface | SDD | Internal service logic, no stakeholder-facing features |
| platform-channel | SDD | Technical implementation detail |
| android-plugin | SDD + TDD | Core logic + correctness-critical (system integration) |
| incall-service | TDD | Call state management is correctness-critical |
| activity-intents | SDD | Intent handling is standard Android pattern |

## Synthesis

> Updated after all children complete

[pending children completion]

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
