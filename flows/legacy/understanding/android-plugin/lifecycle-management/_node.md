# Understanding: Lifecycle Management

> Flutter plugin lifecycle handling

## Phase: EXPLORING

## Sources

- `android/src/main/kotlin/org/tele/flutter_dialer/FlutterDialerPlugin.kt`

## Validated Understanding

### FlutterPlugin Interface

**Methods Implemented**:

```kotlin
override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, "flutter_dialer")
    channel.setMethodCallHandler(this)
}

override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
}
```

### Lifecycle Flow

```
Flutter Engine Starts
       │
       ▼
Plugin Registered
       │
       ▼
onAttachedToEngine() called
       │
       ├─► Store context
       ├─► Create MethodChannel
       └─► Set method call handler
       │
       ▼
Plugin Ready (methods can be called)
       │
       ▼
... Flutter app runs ...
       │
       ▼
Flutter Engine Stops
       │
       ▼
onDetachedFromEngine() called
       │
       ├─► Clear method call handler
       └─► Release resources
       │
       ▼
Plugin Destroyed
```

### Key Implementation Details

**Context Storage**:
```kotlin
private lateinit var context: Context
```
- Stored as class property
- Used by all three dialer methods
- Application context (not activity context)

**Channel Initialization**:
```kotlin
channel = MethodChannel(binding.binaryMessenger, "flutter_dialer")
```
- Created once during attachment
- Uses binary messenger from binding
- Channel name: "flutter_dialer"

**Handler Registration**:
```kotlin
channel.setMethodCallHandler(this)
```
- Plugin class IS the handler
- Implements `MethodCallHandler` interface
- Receives all method calls

**Cleanup**:
```kotlin
channel.setMethodCallHandler(null)
```
- Clears handler reference
- Prevents calls after detachment
- Allows garbage collection

### Thread Safety

**Current Implementation**: Not explicitly thread-safe

**Potential Issues**:
- `context` is `lateinit var` - could throw if accessed before initialization
- `channel` is accessed from multiple threads (Dart calls can be concurrent)

**Recommendation**: Consider making `channel` volatile or using synchronization if concurrent access is expected

## Children

None - leaf node

## Flow Recommendation

**Type**: SDD

**Confidence**: high

**Rationale**: Lifecycle management follows Flutter plugin template, needs documentation

## Bubble Up

- Implements FlutterPlugin interface
- onAttachedToEngine: initialize context, channel, handler
- onDetachedFromEngine: cleanup handler
- Context stored as class property
- Channel created once, reused

---

*Created by /legacy ENTERING phase, validated by /legacy EXPLORING phase*
