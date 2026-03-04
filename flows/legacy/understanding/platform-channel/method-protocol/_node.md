# Understanding: Method Protocol

> Method channel invocation protocol

## Phase: EXPLORING

## Sources

- `lib/flutter_dialer_method_channel.dart` - Dart invocation
- `android/src/main/kotlin/org/tele/flutter_dialer/FlutterDialerPlugin.kt` - Android handling

## Validated Understanding

### Protocol Specification

**Transport**: Flutter MethodChannel (binary messenger)

**Serialization**: Standard Flutter method channel serialization
- Method names: String
- Arguments: Map<String, Any> (none used in this plugin)
- Return values: Boolean, String, or null

### Method Signatures

```
isDefaultDialer() → bool?
setDefaultDialer() → bool?
canSetDefaultDialer() → bool?
```

### Invocation Pattern

**Dart → Android**:
```dart
final result = await methodChannel.invokeMethod<bool>('methodName');
```

**Android → Dart** (response):
```kotlin
result.success(booleanValue)  // Sends value to Dart
// OR
result.error(code, message, details)  // Sends error to Dart
```

### Method Handler (Android)

```kotlin
override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
        "isDefaultDialer" -> isDefaultDialer(result)
        "setDefaultDialer" -> setDefaultDialer(result)
        "canSetDefaultDialer" -> canSetDefaultDialer(result)
        else -> result.notImplemented()
    }
}
```

### Key Characteristics

1. **Synchronous handler, async from Dart**: Android handler is synchronous, Dart receives as Future
2. **No arguments**: All methods take zero parameters
3. **Boolean returns**: All methods return boolean (nullable on Dart side)
4. **notImplemented()**: Called for unknown method names

## Children

None - leaf node

## Flow Recommendation

**Type**: SDD

**Confidence**: high

**Rationale**: Protocol specification needs documentation

## Bubble Up

- Three methods, no arguments
- Boolean return type
- Standard Flutter serialization
- notImplemented() for unknown methods

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
