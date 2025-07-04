package org.tele.flutter_dialer

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.net.Uri
import android.util.Log

class MainActivity: FlutterActivity() {
    companion object {
        private const val TAG = "MainActivity"
    }

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
                // For example, pass it to your Flutter app
                // or make a call directly
            }
        }
    }
} 