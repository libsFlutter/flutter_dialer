# Understanding: Activity Intents

> MainActivity handling tel: scheme intents and VIEW/DIAL actions

## Phase: SYNTHESIZING

## Synthesis from Children

### Intent Filters (from intent-filters/*)

**Two Intent Filters**:

1. **Full tel: Filter**:
   - Actions: VIEW, DIAL
   - Categories: DEFAULT, BROWSABLE
   - Data: tel: scheme

2. **Simple DIAL Filter**:
   - Action: DIAL only
   - Category: DEFAULT
   - No data restriction

**Purpose**:
- Launch app from browser tel: links
- Handle system dialer intents
- Allow app to be default dialer candidate

### Phone Number Handling (from phone-number-handling/*)

**Extraction Pattern**:
```kotlin
val phoneNumber = intent.data.schemeSpecificPart
```

**Validation**:
- Check action is VIEW or DIAL
- Check data is not null
- Check scheme is "tel"

**Current State**: Logging only (no business logic)

**Potential Implementations**:
- Pass to Flutter via method channel
- Auto-dial with validation
- Show in UI
- Log/analytics

**Security Considerations**:
- Scheme validated ✓
- Phone format not validated ⚠
- No length limits ⚠

### Complete Understanding

The activity-intents domain is a **skeleton implementation** for handling incoming tel: intents:

1. **Proper Configuration**: Manifest intent filters correctly declared
2. **Intent Handling**: onNewIntent properly overridden
3. **Validation**: Basic null and scheme checks
4. **Logging**: Phone numbers logged for debugging
5. **No Business Logic**: Comment indicates "You can handle the phone number here"

**Assessment**:
- ✓ Intent filters properly configured
- ✓ onNewIntent correctly implemented
- ✓ Validation chain (action, null, scheme)
- ✓ Phone number extraction
- ✓ Logging for debugging
- ⚠ No Flutter communication
- ⚠ No phone number validation
- ⚠ No business logic implementation

**Integration with Plugin**:
- Currently standalone (doesn't communicate with FlutterDialerPlugin)
- Could be integrated via method channel
- Could trigger FlutterDialer methods after receiving number

## Flow Recommendation

**Primary**: SDD (Spec-Driven Development)
- Intent filter specification
- Intent handling pattern
- Phone number processing

**Secondary**: TDD (Test-Driven Development)
- Intent validation tests
- Edge case handling
- Security validation

## ADR Candidates

1. **Logging-Only Design**: Why no business logic implementation?
2. **Integration Decision**: Should this communicate with FlutterDialerPlugin?

## Bubble Up to Root

- Extends FlutterActivity
- Two intent filters (tel: VIEW/DIAL + DIAL-only)
- onNewIntent handles VIEW/DIAL actions
- Extracts phone number from tel: scheme
- Currently logging only
- Needs business logic implementation

---

*Synthesized by /legacy SYNTHESIZING phase*
