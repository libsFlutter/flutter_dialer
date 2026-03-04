# Understanding: Intent Filters

> Android manifest intent filters for tel: scheme handling

## Phase: EXPLORING

## Sources

- `README.md` - Manifest configuration
- `android/src/main/kotlin/org/tele/flutter_dialer/MainActivity.kt` - Handler

## Validated Understanding

### Manifest Declaration

**Location**: `android/src/main/AndroidManifest.xml`

**Activity**: `MainActivity`

**Exported**: `true` (accessible from other apps)

### Intent Filter 1: tel: Scheme (Full)

```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <action android:name="android.intent.action.DIAL" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="tel"/>
</intent-filter>
```

**Components**:

| Component | Value | Purpose |
|-----------|-------|---------|
| **Action** | VIEW | Handle view requests (tel: URLs) |
| **Action** | DIAL | Handle dial requests |
| **Category** | DEFAULT | Required for all implicit intents |
| **Category** | BROWSABLE | Allow launching from browser |
| **Data** | tel: | Handle telephone scheme |

**Use Cases**:
- Browser clicks on `tel:+1234567890` link
- Other apps send tel: intent
- QR code scanner reads tel: URL
- Email client tel: links

---

### Intent Filter 2: DIAL Only (Simple)

```xml
<intent-filter>
    <action android:name="android.intent.action.DIAL"/>
    <category android:name="android.intent.category.DEFAULT"/>
</intent-filter>
```

**Purpose**: Simpler DIAL-only handler (no BROWSABLE, no data scheme restriction)

**Use Cases**:
- System dialer chooser
- Voice assistant dial commands

---

### Intent Resolution Flow

```
User clicks tel: link
       │
       ▼
Android Intent Resolver
       │
       ├─► Finds all apps with tel: scheme filter
       │
       ▼
System Chooser (if multiple dialers)
       │
       ▼
Selected App (MainActivity)
       │
       ▼
onNewIntent(intent) called
```

### Matching Rules

**Intent matches filter if**:
1. Action matches one of the filter's actions
2. Category includes DEFAULT (if not, intent fails)
3. Data scheme matches (tel:)

**Example Matching Intents**:

| Intent | Matches Filter 1 | Matches Filter 2 |
|--------|-----------------|------------------|
| `ACTION_VIEW` with `tel:123` | ✓ | ✗ (wrong action) |
| `ACTION_DIAL` with `tel:123` | ✓ | ✓ |
| `ACTION_DIAL` (no data) | ✗ (needs tel:) | ✓ |
| `ACTION_CALL` with `tel:123` | ✗ (wrong action) | ✗ |

### BROWSABLE Category

**Purpose**: Allow the activity to be launched from a browser

**Security Consideration**:
- Without BROWSABLE: Browser cannot launch app
- With BROWSABLE: Must validate all incoming data
- Current implementation: Validates scheme is "tel"

### DEFAULT Category

**Required**: For all implicit intents

**Without DEFAULT**: Activity won't receive standard intents

## Children

None - leaf node

## Flow Recommendation

**Type**: SDD

**Confidence**: high

**Rationale**: Standard Android manifest configuration, needs documentation

## Bubble Up

- Two intent filters (full tel: + simple DIAL)
- VIEW and DIAL actions supported
- BROWSABLE allows browser launching
- DEFAULT required for implicit intents
- tel: scheme validation in code

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
