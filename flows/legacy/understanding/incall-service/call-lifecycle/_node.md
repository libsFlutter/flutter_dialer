# Understanding: Call Lifecycle

> InCallService call lifecycle management

## Phase: EXPLORING

## Sources

- `android/src/main/kotlin/org/tele/flutter_dialer/TeleService.kt`

## Validated Understanding

### Call Lifecycle Events

**Sequence**:
```
Incoming/Outgoing Call
       │
       ▼
onCallAdded(call)
       │
       ├─► Log call handle
       ├─► Register Call.Callback
       │
       ▼
... Call is active ...
       │
       ├─► onStateChanged() (multiple times)
       │   ├─► CONNECTING
       │   ├─► CONNECTED
       │   ├─► DISCONNECTING
       │   └─► DISCONNECTED
       │
       ▼
onCallRemoved(call)
       │
       ├─► Log removal
       │
       ▼
onCallDestroyed(call) (via callback)
       │
       └─► Log destruction
```

### onCallAdded

**Purpose**: Called when a new call is added to the system

**Implementation**:
```kotlin
override fun onCallAdded(call: Call) {
    super.onCallAdded(call)
    Log.d(TAG, "Call added: ${call.details.handle}")

    call.registerCallback(object : Call.Callback() {
        // ... callbacks
    })
}
```

**Actions**:
1. Call parent implementation
2. Log call handle (phone number)
3. Register Call.Callback for state changes

**Call Handle**: `call.details.handle` contains the phone number (URI)

---

### onCallRemoved

**Purpose**: Called when a call is removed from the system

**Implementation**:
```kotlin
override fun onCallRemoved(call: Call) {
    super.onCallRemoved(call)
    Log.d(TAG, "Call removed")
}
```

**Actions**:
1. Call parent implementation
2. Log removal

**Note**: Call may still exist in memory after removal

---

### Call.Callback Registration

**Pattern**:
```kotlin
call.registerCallback(object : Call.Callback() {
    override fun onStateChanged(call: Call, state: Int) {
        super.onStateChanged(call, state)
        Log.d(TAG, "Call state changed: $state")
    }

    override fun onCallDestroyed(call: Call) {
        super.onCallDestroyed(call)
        Log.d(TAG, "Call destroyed")
    }
})
```

**Purpose**: Monitor call state changes and destruction

---

## Children

None - leaf node

## Flow Recommendation

**Type**: TDD

**Confidence**: high

**Rationale**: Lifecycle management is correctness-critical. Tests should verify:
- Callbacks are registered correctly
- All lifecycle events are handled
- State transitions are tracked

## Bubble Up

- onCallAdded: Log handle, register callback
- onCallRemoved: Log removal
- Call.Callback tracks state changes and destruction
- Complete lifecycle tracking from add to destroy

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
