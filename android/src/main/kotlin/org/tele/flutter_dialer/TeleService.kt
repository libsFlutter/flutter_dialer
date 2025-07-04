package org.tele.flutter_dialer

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.telecom.Call
import android.telecom.InCallService
import android.util.Log

class TeleService : InCallService() {
    companion object {
        private const val TAG = "TeleService"
    }

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "TeleService created")
    }

    override fun onCallAdded(call: Call) {
        super.onCallAdded(call)
        Log.d(TAG, "Call added: ${call.details.handle}")
        
        // Register call callbacks
        call.registerCallback(object : Call.Callback() {
            override fun onStateChanged(call: Call, state: Int) {
                super.onStateChanged(call, state)
                Log.d(TAG, "Call state changed: $state")
            }

            override fun onCallDestroyed(call: Call) {
                super.onCallDestroyed(call)
                Log.d(TAG, "Call destroyed")
            }
        })
    }

    override fun onCallRemoved(call: Call) {
        super.onCallRemoved(call)
        Log.d(TAG, "Call removed")
    }

    override fun onBind(intent: Intent): IBinder? {
        return super.onBind(intent)
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "TeleService destroyed")
    }
} 