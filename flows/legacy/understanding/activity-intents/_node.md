# Understanding: Activity Intents

> MainActivity handling tel: scheme intents and VIEW/DIAL actions

## Phase: ENTERING

## Hypothesis

This domain handles Android intents that launch the dialer app with phone numbers. Expected to include:
- MainActivity extending FlutterActivity
- Intent handling for tel: scheme URLs
- Phone number extraction from intent data

## Sources

- `android/src/main/kotlin/org/tele/flutter_dialer/MainActivity.kt` - Intent handling

## Validated Understanding

[pending code analysis]

## Children

| Child | Status |
|-------|--------|
| intent-filters | PENDING |
| phone-number-handling | PENDING |

## Flow Recommendation

**Type**: SDD (Spec-Driven Development)

**Confidence**: high

**Rationale**: Standard Android pattern implementation. Intent handling follows well-defined Android conventions.

## Bubble Up

- Extends FlutterActivity
- Handles onNewIntent for ACTION_VIEW and ACTION_DIAL
- Extracts phone number from tel: scheme (data.schemeSpecificPart)
- Logging with TAG = "MainActivity"
- Intent data validation (null checks)

---

*Created by /legacy ENTERING phase*
