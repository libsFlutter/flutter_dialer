# Understanding: Phone Number Handling

> Extracting and processing phone numbers from tel: intents

## Phase: EXPLORING

## Sources

- `android/src/main/kotlin/org/tele/flutter_dialer/MainActivity.kt`

## Validated Understanding

### Intent Data Extraction

**Pattern**:
```kotlin
override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    Log.d(TAG, "onNewIntent: ${intent.action}")

    // Handle tel: scheme intents
    if (intent.action == Intent.ACTION_VIEW || intent.action == Intent.ACTION_DIAL) {
        val data = intent.data
        if (data != null && data.scheme == "tel") {
            val phoneNumber = data.schemeSpecificPart
            Log.d(TAG, "Received phone number: $phoneNumber")

            // You can handle the phone number here
        }
    }
}
```

### Validation Chain

```
intent received
      │
      ▼
Check action (VIEW or DIAL)
      │
      ▼
Get intent.data (Uri)
      │
      ▼
Check data != null
      │
      ▼
Check data.scheme == "tel"
      │
      ▼
Extract data.schemeSpecificPart (phone number)
```

### Phone Number Format

**Source**: `intent.data.schemeSpecificPart`

**Example**:
- Intent: `tel:+1-555-123-4567`
- `schemeSpecificPart`: `+1-555-123-4567`

**Format Variations**:
- `+1234567890` (international with +)
- `1234567890` (local, no country code)
- `*123#` (USSD codes)
- `123` (emergency/internal numbers)

### Current Implementation: Logging Only

**What Happens**:
1. Phone number extracted
2. Logged for debugging
3. No further processing

**Comment in Code**:
```kotlin
// You can handle the phone number here
// For example, pass it to your Flutter app
// or make a call directly
```

### Potential Implementations

**Option 1: Pass to Flutter**
```kotlin
// Send to Flutter via method channel
methodChannel.invokeMethod("onReceivedPhoneNumber", phoneNumber)
```

**Option 2: Auto-dial**
```kotlin
// Initiate call directly (requires CALL_PHONE permission)
val callIntent = Intent(Intent.ACTION_CALL)
callIntent.data = Uri.parse("tel:$phoneNumber")
startActivity(callIntent)
```

**Option 3: Show in UI**
```kotlin
// Update Flutter UI with phone number
// Store in shared preferences or send via channel
```

**Option 4: Log/Analytics**
```kotlin
// Log intent source for analytics
analytics.logEvent("tel_intent_received", phoneNumber)
```

### Security Considerations

**Validation**:
- ✓ Scheme is validated (must be "tel")
- ⚠ Phone number format not validated
- ⚠ No length limits
- ⚠ No character filtering

**Potential Risks**:
- Malformed phone numbers
- Very long strings (DoS)
- Special characters in schemeSpecificPart

**Recommendations**:
- Validate phone number format
- Limit length
- Sanitize before use
- Be cautious with automatic dialing

### Edge Cases

| Input | Handling |
|-------|----------|
| `tel:` (empty) | phoneNumber = "" |
| `tel:123` | phoneNumber = "123" |
| `tel:+1-555-1234` | phoneNumber = "+1-555-1234" |
| `tel:*123#` | phoneNumber = "*123#" (USSD) |
| null data | Skipped (null check) |
| `http:` scheme | Skipped (scheme check) |

## Children

None - leaf node

## Flow Recommendation

**Type**: SDD + TDD

**Confidence**: high

**Rationale**: 
- SDD: Needs specification for complete implementation
- TDD: Phone number validation and edge cases need tests

## Bubble Up

- Extracts schemeSpecificPart from tel: URI
- Validates action (VIEW/DIAL) and scheme (tel:)
- Null-safe extraction
- Currently logging only
- Needs business logic implementation

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
