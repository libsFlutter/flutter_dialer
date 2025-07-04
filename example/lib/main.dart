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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkDialerStatus();
  }

  Future<void> _checkDialerStatus() async {
    setState(() {
      isLoading = true;
    });

    try {
      final defaultStatus = await FlutterDialer.isDefaultDialer();
      final canSetStatus = await FlutterDialer.canSetDefaultDialer();
      
      setState(() {
        isDefault = defaultStatus;
        canSet = canSetStatus;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking dialer status: $e')),
      );
    }
  }

  Future<void> _setDefaultDialer() async {
    try {
      final success = await FlutterDialer.setDefaultDialer();
      if (success) {
        await _checkDialerStatus();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Default dialer set successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to set default dialer'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error setting default dialer: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Dialer Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _checkDialerStatus,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            isDefault ? Icons.phone_android : Icons.phone_iphone,
                            size: 48,
                            color: isDefault ? Colors.green : Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Default Dialer Status',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height: 8),
                          Text(
                            isDefault ? 'This app is the default dialer' : 'This app is NOT the default dialer',
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            canSet ? Icons.settings : Icons.block,
                            size: 48,
                            color: canSet ? Colors.blue : Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Can Set as Default',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height: 8),
                          Text(
                            canSet ? 'This app can be set as default dialer' : 'This app cannot be set as default dialer',
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  if (canSet)
                    ElevatedButton(
                      onPressed: _setDefaultDialer,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Set as Default Dialer',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  SizedBox(height: 16),
                  Text(
                    'Note: Setting as default dialer will open the system settings dialog.',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
