# Understanding: InCall Service

> Android InCallService for managing active calls

## Phase: ENTERING

## Hypothesis

This domain implements the Android InCallService to monitor and manage active phone calls. Expected to include:
- Service extending android.telecom.InCallService
- Call lifecycle callbacks (onCallAdded, onCallRemoved)
- Call state monitoring via Call.Callback

## Sources

- `android/src/main/kotlin/org/tele/flutter_dialer/TeleService.kt` - InCallService implementation

## Validated Understanding

[pending code analysis]

## Children

| Child | Status |
|-------|--------|
| call-lifecycle | PENDING |
| call-state-monitoring | PENDING |

## Flow Recommendation

**Type**: TDD (Test-Driven Development)

**Confidence**: high

**Rationale**: Correctness-critical logic. Call state management must handle all edge cases properly. Failures could cause missed calls or UI inconsistencies.

## Bubble Up

- Extends InCallService with BIND_INCALL_SERVICE permission
- Monitors call lifecycle: onCallAdded, onCallRemoved
- Registers Call.Callback for state changes
- State monitoring: onStateChanged, onCallDestroyed
- Logging with TAG = "TeleService"

---

*Created by /legacy ENTERING phase*
