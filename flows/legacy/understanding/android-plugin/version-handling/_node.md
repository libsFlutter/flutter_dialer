# Understanding: Version Handling

> Android API level version checking

## Phase: EXPLORING

## Sources

- `android/src/main/kotlin/org/tele/flutter_dialer/FlutterDialerPlugin.kt`

## Validated Understanding

### API Level Requirements

**Minimum API**: 23 (Android 6.0 Marshmallow)

**Reason**: `TelecomManager` default dialer APIs were added in API 23

### Version Check Pattern

**isDefaultDialer()**:
```kotlin
if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.M) {
    Log.d(TAG, "Android version < M, returning true")
    result.success(true)
    return
}
```

**canSetDefaultDialer()**:
```kotlin
if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.M) {
    Log.d(TAG, "Android version < M, returning false")
    result.success(false)
    return
}
```

### Version Handling Logic

| Method | API < 23 Behavior | Rationale |
|--------|-------------------|-----------|
| `isDefaultDialer()` | Returns `true` | Feature doesn't exist, assume "yes" (safe default) |
| `canSetDefaultDialer()` | Returns `false` | Can't set on old versions, so "no" |
| `setDefaultDialer()` | No version check | Will fail gracefully via exception |

### Design Decisions

**Why return `true` for isDefaultDialer on API < 23?**
- Feature doesn't exist on old Android versions
- Returning `true` prevents UI from showing "Set as Default" button
- Avoids confusing users with unavailable feature

**Why return `false` for canSetDefaultDialer on API < 23?**
- Accurate: you literally cannot set default dialer on old versions
- Prevents attempt to open non-existent system dialog

**Why no version check in setDefaultDialer?**
- Intent will fail if API not supported
- Exception will be caught and logged
- Returns `false` to caller

### Logging

**Format**:
```
Android version < M, returning [value]
```

**Purpose**: Debugging - helps identify if unexpected behavior is due to old Android version

### Build.VERSION_CODES

**Constant Used**: `Build.VERSION_CODES.M`

**Value**: 23 (Marshmallow)

**Usage**:
```kotlin
if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.M)
```

## Children

None - leaf node

## Flow Recommendation

**Type**: SDD

**Confidence**: high

**Rationale**: Version handling is part of Android plugin specification

## Bubble Up

- API 23+ required for full functionality
- Graceful degradation for older versions
- Different return values for < M based on method
- Logging for debugging version issues

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
