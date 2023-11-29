package com.channoori.korea_social_login

import android.content.Intent
import com.facebook.CallbackManager
import com.facebook.FacebookCallback
import com.facebook.FacebookException
import com.facebook.login.LoginResult
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

/**
 * Facebook관련 콜백 Delegate
 *
 * @property callbackManager
 * @property result MethodChannel Result
 *
 */
open class FacebookLoginResultDelegate: FacebookCallback<LoginResult>, PluginRegistry.ActivityResultListener {
    private var callbackManager: CallbackManager
    private lateinit var result: MethodChannel.Result

    constructor(callbackManager: CallbackManager) {
        this.callbackManager = callbackManager
    }

    fun setResult(result: MethodChannel.Result) {
        this.result = result
    }

    override fun onCancel() {
        result.error("CANCELLED", "user has cancelled login with facebook", null)
    }

    override fun onError(error: FacebookException) {
        result.error("FAILED", error.message, null)
    }

    override fun onSuccess(result: LoginResult) {
        val accessToken = FacebookLogin.convertAccessToken(result.accessToken)
        this.result.success(accessToken)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        return callbackManager.onActivityResult(requestCode, resultCode, data)
    }
}