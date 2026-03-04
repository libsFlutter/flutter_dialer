# Understanding: Error Propagation

> How errors flow from Android to Dart

## Phase: EXPLORING

## Sources

- `lib/flutter_dialer_method_channel.dart` - Dart error handling
- `android/src/main/kotlin/org/tele/flutter_dialer/FlutterDialerPlugin.kt` - Android error handling

## Validated Understanding

### Android Error Handling

**Pattern**: Try-catch with result.error()

```kotlin
private fun isDefaultDialer(result: Result) {
    try {
        Log.d(TAG, "isDefaultDialer() called")
        
        if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.M) {
            Log.d(TAG, "Android version < M, returning true")
            result.success(true)
            return
        }
        
        val telecomManager = context.getSystemService(Context.TELECOM_SERVICE) as TelecomManager
        val isDefault = telecomManager.defaultDialerPackage == context.packageName
        
        Log.d(TAG, "isDefaultDialer: $isDefault")
        result.success(isDefault)
    } catch (e: Exception) {
        Log.e(TAG, "Error checking if default dialer", e)
        result.error("IS_DEFAULT_DIALER_ERROR", "Failed to check if default dialer", e.message)
    }
}
```

**Error Code Pattern**: `[METHOD_NAME]_ERROR`
- `IS_DEFAULT_DIALER_ERROR`
- `SET_DEFAULT_DIALER_ERROR`
- `CAN_SET_DEFAULT_DIALER_ERROR`

### Dart Error Handling

**Pattern**: Try-catch with PlatformException

```dart
static Future<bool> isDefaultDialer() async {
    try {
        final result = await _channel.invokeMethod('isDefaultDialer');
        return result == true;
    } on PlatformException catch (e) {
        print('FlutterDialer: PlatformException in isDefaultDialer: ${e.code} - ${e.message}');
        return false;
    } catch (e) {
        print('FlutterDialer: Exception in isDefaultDialer: $e');
        return false;
    }
}
```

### Error Flow

```
Android Exception
       │
       ▼
catch (e: Exception)
       │
       ▼
result.error(code, message, details)
       │
       ▼
Flutter Engine (serializes to PlatformException)
       │
       ▼
Dart: on PlatformException catch (e)
       │
       ├─► e.code ← Android error code
       ├─► e.message ← Android error message
       └─► e.details ← Android error details
       │
       ▼
Log and return false
```

### Error Code Mapping

| Android Method | Error Code | Error Message |
|----------------|------------|---------------|
| isDefaultDialer | `IS_DEFAULT_DIALER_ERROR` | "Failed to check if default dialer" |
| setDefaultDialer | `SET_DEFAULT_DIALER_ERROR` | "Failed to set default dialer" |
| canSetDefaultDialer | `CAN_SET_DEFAULT_DIALER_ERROR` | "Failed to check if can set default dialer" |

### Logging Strategy

**Android**:
- `Log.d()` for normal flow (method entry, values, exit)
- `Log.e()` for errors (with full exception stack trace)
- TAG per class: "FlutterDialerPlugin", "TeleService", "MainActivity"

**Dart**:
- `print()` for errors only
- Format: `FlutterDialer: [ExceptionType] in [method]: [details]`
- No debug logging for normal flow

## Children

None - leaf node

## Flow Recommendation

**Type**: TDD (Test-Driven Development)

**Confidence**: high

**Rationale**: Error propagation is correctness-critical. Tests should verify:
- Error codes are propagated correctly
- Error messages are preserved
- Dart receives PlatformException with correct fields

## Bubble Up

- Android uses result.error(code, message, details)
- Dart receives PlatformException
- Error codes follow [METHOD]_ERROR pattern
- Dart logs and returns false (fail-safe)
- Full exception details preserved in propagation

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
