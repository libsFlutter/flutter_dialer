# Understanding: InCall Service

> Android InCallService for managing active calls

## Phase: SYNTHESIZING

## Synthesis from Children

### Call Lifecycle (from call-lifecycle/*)

**Service Lifecycle**:
- `onCreate()`: Service created
- `onCallAdded()`: New call added, register callback
- `onCallRemoved()`: Call removed from system
- `onDestroy()`: Service destroyed

**Call Lifecycle**:
```
onCallAdded → [Call Active] → onCallRemoved → onCallDestroyed
```

**Callback Registration**: In `onCallAdded()`, registers `Call.Callback` for state tracking

### Call State Monitoring (from call-state-monitoring/*)

**Call.Callback Methods**:
- `onStateChanged(call, state)`: Monitors all state transitions
- `onCallDestroyed(call)`: Final callback

**Call States**:
- STATE_CONNECTING, STATE_CONNECTED, STATE_DISCONNECTING, STATE_DISCONNECTED
- STATE_RINGING, STATE_ACTIVE, STATE_HOLDING
- STATE_SELECT_PHONE_ACCOUNT

**Current Implementation**: Logging only (no business logic)

### Complete Understanding

The InCallService implementation is a **skeleton/minimal implementation**:

1. **Proper Structure**: Correctly extends InCallService
2. **Lifecycle Tracking**: Logs all lifecycle events
3. **State Monitoring**: Registers Call.Callback for state changes
4. **No Business Logic**: Currently only logs, no UI integration or Flutter notifications
5. **Manifest Registration**: Properly declared with BIND_INCALL_SERVICE permission

**Assessment**:
- ✓ Correct service extension
- ✓ Proper manifest registration
- ✓ Lifecycle callbacks implemented
- ✓ State monitoring via Call.Callback
- ✓ Comprehensive logging
- ⚠ No business logic (logging only)
- ⚠ No Flutter integration (doesn't notify Dart code)
- ⚠ No UI integration (doesn't show call screen)

**Purpose**: Appears to be either:
- A debugging/monitoring tool
- A skeleton for future implementation
- Partial implementation of full dialer UI

## Flow Recommendation

**Primary**: TDD (Test-Driven Development)
- Correctness-critical call handling
- Lifecycle edge cases
- State transition coverage

**Secondary**: SDD (Spec-Driven Development)
- Service specification
- Manifest requirements
- Callback patterns

## ADR Candidates

1. **Logging-Only Design**: Why no business logic or Flutter integration?
2. **Missing States**: Why not implement all Call.Callback methods?

## Bubble Up to Root

- Extends InCallService
- BIND_INCALL_SERVICE permission required
- Lifecycle: onCallAdded, onCallRemoved
- State monitoring via Call.Callback
- Currently logging only
- No Flutter/Dart integration

---

*Synthesized by /legacy SYNTHESIZING phase*
