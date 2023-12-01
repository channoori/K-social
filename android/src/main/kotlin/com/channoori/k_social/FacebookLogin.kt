package com.channoori.korea_social_login

import android.app.Activity
import android.os.Bundle
import com.facebook.AccessToken
import com.facebook.CallbackManager
import com.facebook.GraphRequest
import com.facebook.login.LoginBehavior
import com.facebook.login.LoginManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat

/**
 * FacebookLogin
 *
 * @author by Channoori
 *
 * @property activity 로그인을 위해 Activity가 필요하여 변수로 가지고 있다.
 * @property loginManager Facebook LoginManager
 * @property resultDelegate Facebook의 콜백 Delegate.
 *
 */
class FacebookLogin {

    private val loginManager: LoginManager
    private lateinit var activity: Activity
    public val resultDelegate: FacebookLoginResultDelegate

    constructor() {
        loginManager = LoginManager.getInstance()
        val callbackManager = CallbackManager.Factory.create()
        resultDelegate = FacebookLoginResultDelegate(callbackManager)
        loginManager.registerCallback(callbackManager, resultDelegate)
    }

    open fun onMethodCall(call: MethodCall, result: MethodChannel.Result, activity: Activity) {
        this.activity = activity
        resultDelegate.setResult(result)
        when (call.method) {
            "facebook/login" -> {
                val permissions: List<String>? = call.argument<List<String>>("permissions")
                login(permissions.orEmpty())
            }

            "facebook/getAccessToken" -> {
                getAccessToken(result)
            }

            "facebook/getUserInfo" -> {
                val fields: String? = call.argument("fields")
                getUserInfo(fields.orEmpty(), result)
            }

            "facebook/logout" -> {
                logout(result)
            }
        }

    }

    private fun login(permissions: List<String>) {
        val preSession = AccessToken.getCurrentAccessToken() != null
        if (preSession) {
            loginManager.logOut()
        }
        loginManager.setLoginBehavior(LoginBehavior.NATIVE_WITH_FALLBACK)
        try {


            loginManager.logIn(activity, permissions)
        } catch (e: Exception) {
            e.message
        }
    }

    private fun logout(result: MethodChannel.Result) {
        val preSession = AccessToken.getCurrentAccessToken() != null
        if (preSession) {
            loginManager.logOut()
        }
        result.success(true)
    }

    private fun getAccessToken(result: MethodChannel.Result) {
        val accessToken: AccessToken? = AccessToken.getCurrentAccessToken()
        val isLoggedIn = accessToken != null && !accessToken.isExpired
        if (isLoggedIn) {
            if (accessToken != null) {
                val data: HashMap<String, Any> = FacebookLogin.convertAccessToken(accessToken)
                result.success(data)
            } else {
                result.success(null)
            }
        } else {
            result.success(null)
        }
    }

    private fun getUserInfo(fields: String, result: MethodChannel.Result) {
        val request: GraphRequest =
            GraphRequest.newMeRequest(AccessToken.getCurrentAccessToken()) { obj, response ->
                try {
                    result.success(obj?.toString())
                } catch (e: Exception) {
                    result.error("FAILED", e.message, null)
                }

            }
        val parameters: Bundle = Bundle()
        parameters.putString("fields", fields)
        request.parameters = parameters
        request.executeAsync()
    }

    /**
     * Facebook에서 제공하는 AccessToken을 파싱하기 쉽도록 HashMap<String, Any>변경해서 반환하는 함수이다.
     * EN) This function returns a HashMap<String, Any> modified with the AccessToken provided by Facebook to make it easier to parse.
     *
     * @property accessToken Facebook에서 제공하는 AccessToken을 받는다. EN) Get the AccessToken provided by Facebook.
     * @return HashMap<String, Any> 타입의 해시맵으로 반환을 하고 Flutter에서 파싱을 하고 있다. Date타입은 String타입으로 변경해서 보내고 있다.
     * EN) We are returning a hashmap of type HashMap<String, Any> and parsing it in Flutter. We are changing the Date type to a String type and sending it.
     *
     */
    companion object {
        fun convertAccessToken(accessToken: AccessToken): HashMap<String, Any> {
            val dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            val dateFormatter = SimpleDateFormat(dateFormat)
            val data = HashMap<String, Any>()

            data["tokenString"] = accessToken.token
            data["userId"] = accessToken.userId
            data["expirationDate"] = dateFormatter.format(accessToken.expires)
            data["refreshDate"] = dateFormatter.format(accessToken.lastRefresh)
            data["appID"] = accessToken.applicationId
            data["isExpired"] = accessToken.isExpired
            data["permissions"] = ArrayList(accessToken.permissions)
            data["declinedPermissions"] = ArrayList(accessToken.declinedPermissions)
            data["dataAccessExpirationDate"] =
                dateFormatter.format(accessToken.dataAccessExpirationTime)
            return data
        }
    }
}