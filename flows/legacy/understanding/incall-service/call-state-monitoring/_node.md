# Understanding: Call State Monitoring

> Monitoring call state changes via Call.Callback

## Phase: EXPLORING

## Sources

- `android/src/main/kotlin/org/tele/flutter_dialer/TeleService.kt`

## Validated Understanding

### Call.Callback Implementation

**Registered in**: `onCallAdded()`

**Callbacks Implemented**:

1. **onStateChanged(Call, Int)**
   - Called when call state changes
   - State values (from android.telecom.Call):
     - `STATE_CONNECTING` (1)
     - `STATE_CONNECTED` (2)
     - `STATE_DISCONNECTING` (3)
     - `STATE_DISCONNECTED` (4)
     - `STATE_SELECT_PHONE_ACCOUNT` (5)
     - `STATE_RINGING` (6)
     - `STATE_ACTIVE` (7)
     - `STATE_HOLDING` (8)

2. **onCallDestroyed(Call)**
   - Called when call object is being destroyed
   - Final callback in call lifecycle

### Current Implementation

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

### Logging

**State Changes**:
```
Call state changed: [state_number]
```

**Destruction**:
```
Call destroyed
```

### State Transition Diagram

```
New Call
   │
   ▼
STATE_CONNECTING
   │
   ▼
STATE_CONNECTED / STATE_RINGING
   │
   ▼
STATE_ACTIVE
   │
   ▼
STATE_HOLDING (optional)
   │
   ▼
STATE_DISCONNECTING
   │
   ▼
STATE_DISCONNECTED
   │
   ▼
onCallDestroyed()
```

### Missing Callbacks (Not Implemented)

The following Call.Callback methods are available but not implemented:

- `onPostDialWait(Call, String)` - Waiting for post-dial string
- `onVideoProviderChanged(Call, VideoProvider)` - Video provider changed
- `onCallAttributesChanged(Call)` - Call attributes changed
- `onQueueChanged(Call, QueueInfo)` - Call queue changed
- `onPropertiesChanged(Call, ParcelableProperties)` - Call properties changed
- `onConferenceableCallsChanged(Call, List<Call>)` - Conferenceable calls changed
- `onCallAudioStateChanged(Call, Int)` - Call audio state changed

### Current State: Logging Only

**Assessment**: The current implementation only logs state changes. It does NOT:
- Update UI
- Notify Flutter/Dart code
- Store call history
- Handle user interactions

**Purpose**: Appears to be a skeleton implementation or debugging aid

## Children

None - leaf node

## Flow Recommendation

**Type**: TDD

**Confidence**: high

**Rationale**: State monitoring is correctness-critical. Tests should verify:
- All state transitions are logged
- Callback is properly registered
- State values are correctly interpreted

## Bubble Up

- Monitors onStateChanged with all call states
- Monitors onCallDestroyed
- Currently logging only (no business logic)
- Could be extended for UI integration or Flutter notifications

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
