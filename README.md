# flutter_dialer

Flutter plugin for replacing the default dialer app on Android.

## Support
- Currently support for Android only.

## Features
- Check if the app is the default dialer
- Set the app as the default dialer
- Handle incoming calls through InCallService
- Handle tel: scheme intents

## Installation

### Android

Add the following permissions to your `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.READ_CALL_LOG" />
<uses-permission android:name="android.permission.MODIFY_PHONE_STATE" />
<uses-permission android:name="android.permission.ANSWER_PHONE_CALLS" />
<uses-permission android:name="android.permission.MANAGE_OWN_CALLS" />
```

Add the following intent filters to your main activity:

```xml
<activity
  android:name=".MainActivity"
  android:exported="true">
  
  <!-- ReplaceDialer Intent Filters -->
  <intent-filter>
    <!-- Handle links from other applications -->
    <action android:name="android.intent.action.VIEW" />
    <action android:name="android.intent.action.DIAL" />
    <!-- Populate the system chooser -->
    <category android:name="android.intent.category.DEFAULT" />
    <!-- Handle links in browsers -->
    <category android:name="android.intent.category.BROWSABLE" />
    <!-- SCHEME TEL -->
    <data android:scheme="tel"/>
  </intent-filter>
  
  <intent-filter>
    <action android:name="android.intent.action.DIAL"/>
    <category android:name="android.intent.category.DEFAULT"/>
  </intent-filter>
</activity>
```

Add the InCallService for handling calls:

```xml
<service
  android:name=".TeleService"
  android:permission="android.permission.BIND_INCALL_SERVICE"
  android:exported="true">
  <meta-data
    android:name="android.telecom.IN_CALL_SERVICE_UI"
    android:value="true" />
  <intent-filter>
    <action android:name="android.telecom.InCallService" />
  </intent-filter>
</service>
```

## Usage

```dart
import 'package:flutter_dialer/flutter_dialer.dart';

// Check if this app is the default dialer
bool isDefault = await FlutterDialer.isDefaultDialer();
print('Is default dialer: $isDefault');

// Set this app as the default dialer
bool success = await FlutterDialer.setDefaultDialer();
if (success) {
  print('Default dialer set successfully');
} else {
  print('Failed to set default dialer');
}

// Check if this app can be set as default dialer
bool canSet = await FlutterDialer.canSetDefaultDialer();
print('Can set as default dialer: $canSet');
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_dialer/flutter_dialer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dialer Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDefault = false;
  bool canSet = false;

  @override
  void initState() {
    super.initState();
    _checkDialerStatus();
  }

  Future<void> _checkDialerStatus() async {
    final defaultStatus = await FlutterDialer.isDefaultDialer();
    final canSetStatus = await FlutterDialer.canSetDefaultDialer();
    
    setState(() {
      isDefault = defaultStatus;
      canSet = canSetStatus;
    });
  }

  Future<void> _setDefaultDialer() async {
    final success = await FlutterDialer.setDefaultDialer();
    if (success) {
      await _checkDialerStatus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Default dialer set successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to set default dialer')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Dialer Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Is Default Dialer: $isDefault',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Text(
              'Can Set as Default: $canSet',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 40),
            if (canSet)
              ElevatedButton(
                onPressed: _setDefaultDialer,
                child: Text('Set as Default Dialer'),
              ),
          ],
        ),
      ),
    );
  }
}
```

## Requirements

- Android API level 23+ (Android 6.0+)
- Flutter 3.3.0+

## License

This project is licensed under the MIT License.

