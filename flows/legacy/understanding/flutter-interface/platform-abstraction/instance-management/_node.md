# Understanding: Instance Management

> Dependency injection via static instance pattern

## Phase: EXPLORING

## Sources

- `lib/flutter_dialer_platform_interface.dart`

## Validated Understanding

### Static Instance Pattern

```dart
abstract class FlutterDialerPlatform extends PlatformInterface {
  FlutterDialerPlatform() : super(token: _token);

  static final Object _token = Object();
  static FlutterDialerPlatform _instance = MethodChannelFlutterDialer();

  static FlutterDialerPlatform get instance => _instance;

  static set instance(FlutterDialerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
```

### Key Characteristics

1. **Default Implementation**: `_instance` initialized to `MethodChannelFlutterDialer()`
   - Provides out-of-box behavior
   - Can be overridden for testing

2. **Token Verification**: `PlatformInterface.verifyToken(instance, _token)`
   - Ensures only valid subclasses can be set
   - Prevents incorrect implementations

3. **Testability**: Tests can inject mock:
   ```dart
   FlutterDialerPlatform.instance = MockFlutterDialerPlatform();
   ```

### Current Issue

The `FlutterDialer` class does NOT use this pattern. It directly creates `MethodChannel`:

```dart
// Current (doesn't use platform interface):
static const MethodChannel _channel = MethodChannel('flutter_dialer');

// Should be:
final platform = FlutterDialerPlatform.instance;
```

## Children

None - leaf node

## Flow Recommendation

**Type**: SDD

**Confidence**: high

**Rationale**: Architecture pattern needs specification

## Bubble Up

- Standard Flutter plugin dependency injection
- Enables unit testing with mocks
- Token-based type safety
- Currently unused by main API

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
