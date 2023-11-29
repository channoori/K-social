package com.channoori.korea_social_login

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** KoreaSocialLoginPlugin */
class KoreaSocialLoginPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private val facebook: FacebookLogin = FacebookLogin()
  private lateinit var activityPluginBinding: ActivityPluginBinding

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "korea_social_login")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method.contains("facebook")) {
      // * 페이스북 관련 MethodCall
      facebook.onMethodCall(call, result, this.activityPluginBinding.activity)
    }
  }



  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.attachToActivity(binding)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    this.disposeActivity()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    this.attachToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    this.disposeActivity()
  }

  private fun attachToActivity(binding: ActivityPluginBinding) {
    this.activityPluginBinding = binding
    activityPluginBinding.addActivityResultListener(facebook.resultDelegate)
  }

  private fun disposeActivity() {
    activityPluginBinding?.removeActivityResultListener(facebook.resultDelegate)
  }
}
