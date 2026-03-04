# Understanding: Default Dialer API

> Android TelecomManager integration for default dialer management

## Phase: EXPLORING

## Sources

- `android/src/main/kotlin/org/tele/flutter_dialer/FlutterDialerPlugin.kt`

## Validated Understanding

### TelecomManager API Usage

**Service Acquisition**:
```kotlin
val telecomManager = context.getSystemService(Context.TELECOM_SERVICE) as TelecomManager
```

### Checking Default Dialer

**Method**: `isDefaultDialer()`

**API**: `TelecomManager.defaultDialerPackage`

**Logic**:
```kotlin
val isDefault = telecomManager.defaultDialerPackage == context.packageName
```

**Returns**:
- `true`: Current app is the default dialer
- `false`: Another app (or no app) is the default dialer

**Behavior**:
- Synchronous call
- No permissions required
- Safe to call repeatedly

---

### Setting Default Dialer

**Method**: `setDefaultDialer()`

**API**: `TelecomManager.ACTION_CHANGE_DEFAULT_DIALER`

**Implementation**:
```kotlin
val intent = Intent(TelecomManager.ACTION_CHANGE_DEFAULT_DIALER).apply {
    putExtra(
        TelecomManager.EXTRA_CHANGE_DEFAULT_DIALER_PACKAGE_NAME,
        context.packageName
    )
    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
}
context.startActivity(intent)
```

**Key Points**:
1. **Opens System Dialog**: This does NOT directly set the default; it opens the system settings dialog
2. **User Confirmation Required**: User must manually confirm the change
3. **Activity Flag**: `FLAG_ACTIVITY_NEW_TASK` required because we're starting from a non-Activity context
4. **Extra Parameter**: `EXTRA_CHANGE_DEFAULT_DIALER_PACKAGE_NAME` specifies which app to set

**Returns**: `true` immediately after opening dialog (doesn't wait for user confirmation)

**Permissions Required**:
- `CALL_PHONE`
- `READ_PHONE_STATE`
- (Manifest must declare these)

---

### Checking If Can Set

**Method**: `canSetDefaultDialer()`

**Logic**:
```kotlin
val canSet = telecomManager.defaultDialerPackage != context.packageName
```

**Returns**:
- `true`: App is NOT currently default (can attempt to set)
- `false`: App is ALREADY default (no need to set)

**Use Case**: UI can hide "Set as Default" button if already default

---

### Error Handling

**Pattern**:
```kotlin
try {
    // ... TelecomManager operations
    result.success(value)
} catch (e: Exception) {
    Log.e(TAG, "Error description", e)
    result.error("ERROR_CODE", "Error message", e.message)
}
```

**Error Codes**:
- `IS_DEFAULT_DIALER_ERROR`
- `SET_DEFAULT_DIALER_ERROR`
- `CAN_SET_DEFAULT_DIALER_ERROR`

**Common Exceptions**:
- `SecurityException`: Missing permissions
- `ClassCastException`: TELECOM_SERVICE not available
- `NullPointerException`: Context or manager is null

## Children

None - leaf node

## Flow Recommendation

**Type**: SDD + TDD

**Confidence**: high

**Rationale**: 
- SDD: TelecomManager API usage needs specification
- TDD: Correctness-critical, should test all code paths

## Bubble Up

- Uses `defaultDialerPackage` property
- Uses `ACTION_CHANGE_DEFAULT_DIALER` intent
- Returns boolean for all operations
- Requires phone state permissions
- Opens system dialog (async user action)

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
