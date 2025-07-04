package org.tele.flutter_dialer

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context
import android.content.Intent
import android.util.Log
import android.telecom.TelecomManager

/** FlutterDialerPlugin */
class FlutterDialerPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  companion object {
    private const val TAG = "FlutterDialerPlugin"
    private const val RC_DEFAULT_PHONE = 3289
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_dialer")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "isDefaultDialer" -> {
        isDefaultDialer(result)
      }
      "setDefaultDialer" -> {
        setDefaultDialer(result)
      }
      "canSetDefaultDialer" -> {
        canSetDefaultDialer(result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun isDefaultDialer(result: Result) {
    try {
      Log.d(TAG, "isDefaultDialer() called")
      
      if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.M) {
        Log.d(TAG, "Android version < M, returning true")
        result.success(true)
        return
      }

      val telecomManager = context.getSystemService(Context.TELECOM_SERVICE) as TelecomManager
      val isDefault = telecomManager.defaultDialerPackage == context.packageName
      
      Log.d(TAG, "isDefaultDialer: $isDefault")
      result.success(isDefault)
    } catch (e: Exception) {
      Log.e(TAG, "Error checking if default dialer", e)
      result.error("IS_DEFAULT_DIALER_ERROR", "Failed to check if default dialer", e.message)
    }
  }

  private fun setDefaultDialer(result: Result) {
    try {
      Log.d(TAG, "setDefaultDialer() called")
      
      val intent = Intent(TelecomManager.ACTION_CHANGE_DEFAULT_DIALER).apply {
        putExtra(TelecomManager.EXTRA_CHANGE_DEFAULT_DIALER_PACKAGE_NAME, context.packageName)
        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      }
      
      // Note: This will open the system dialog to change default dialer
      // The actual result will be handled by the activity
      context.startActivity(intent)
      
      Log.d(TAG, "setDefaultDialer: Started activity")
      result.success(true)
    } catch (e: Exception) {
      Log.e(TAG, "Error setting default dialer", e)
      result.error("SET_DEFAULT_DIALER_ERROR", "Failed to set default dialer", e.message)
    }
  }

  private fun canSetDefaultDialer(result: Result) {
    try {
      Log.d(TAG, "canSetDefaultDialer() called")
      
      if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.M) {
        Log.d(TAG, "Android version < M, returning false")
        result.success(false)
        return
      }

      val telecomManager = context.getSystemService(Context.TELECOM_SERVICE) as TelecomManager
      val canSet = telecomManager.defaultDialerPackage != context.packageName
      
      Log.d(TAG, "canSetDefaultDialer: $canSet")
      result.success(canSet)
    } catch (e: Exception) {
      Log.e(TAG, "Error checking if can set default dialer", e)
      result.error("CAN_SET_DEFAULT_DIALER_ERROR", "Failed to check if can set default dialer", e.message)
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
