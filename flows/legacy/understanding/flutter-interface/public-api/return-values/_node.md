# Understanding: Return Values

> Boolean return value semantics

## Phase: EXPLORING

## Sources

- `lib/flutter_dialer.dart` - All three methods

## Validated Understanding

### Method Semantics

| Method | Returns `true` | Returns `false` | Error Case |
|--------|---------------|-----------------|------------|
| `isDefaultDialer()` | App IS default dialer | App is NOT default OR error occurred | `false` |
| `setDefaultDialer()` | System dialog opened successfully | Failed to open dialog OR error | `false` |
| `canSetDefaultDialer()` | App can be set as default | Already default OR error occurred | `false` |

### Ambiguity in `false` Returns

**Problem**: `false` has multiple meanings:

1. `isDefaultDialer()`:
   - `false` = "Not default" (normal)
   - `false` = "Error checking" (abnormal)

2. `canSetDefaultDialer()`:
   - `false` = "Already default" (normal)
   - `false` = "Error checking" (abnormal)

3. `setDefaultDialer()`:
   - `false` = "Failed to open dialog" (abnormal)
   - `false` = "Error" (abnormal)

### Android Version Handling

From Android implementation:
- API < 23 (pre-Marshmallow): 
  - `isDefaultDialer()` returns `true` (feature doesn't exist)
  - `canSetDefaultDialer()` returns `false` (can't set)

## Children

None - leaf node

## Flow Recommendation

**Type**: SDD

**Confidence**: high

**Rationale**: API specification needs clear semantics documentation

## Bubble Up

- All methods return `Future<bool>`
- `true` = success/yes, `false` = no/error
- Error cases indistinguishable from legitimate `false`
- Android API 23+ required for full functionality

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
