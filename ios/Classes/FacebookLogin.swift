//
//  FacebookLogin.swift
//  korea_social_login
//
//  Created by Channoori Park on 11/27/23.
//

import Foundation
import FBSDKLoginKit
import Flutter

/// FacebookLogin
/// 페이스북에서 사용되는 클래스 입니다.
class FacebookLogin: NSObject {
    let loginManager: LoginManager = LoginManager()
    
    private var mainWindow: UIWindow? {
        if let applicationWindow = UIApplication.shared.delegate?.window ?? nil {
            return applicationWindow
        }
        
        
        if #available(iOS 13.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.session.role == .windowApplication }),
               let sceneDelegate = scene.delegate as? UIWindowSceneDelegate,
               let window = sceneDelegate.window as? UIWindow  {
                return window
            }
        }
        
        return nil
    }
    
    /**
     Flutter에서 MethodCall이 들어오면 'facebook'이 포함되어 있다면, 여기로 들어오게 된다.
     - Parameters:
     - call: Flutter에서 들어오는 MethodCall
     - result: Flutter에서 들어오는 Result
     */
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? [String: Any]
        
        switch call.method {
            
        case "facebook/login":
            let permissions = args?["permissions"] as! [String]
            self.login(permissions: permissions, result: result)
            
        case "facebook/getAccessToken":
            if let token = AccessToken.current, !token.isExpired {
                let accessToken = getAccessToken(accessToken: token)
                result(accessToken)
            }else{
                result(nil)
            }
            
        case "facebook/getUserInfo":
            let fields = args?["fields"] as! String
            getUserInfo(fields: fields, flutterResult: result)
            
        case "facebook/logout":
            loginManager.logOut()
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    
    
    
    /// 페이스북 로그인을 실행하는 Func
    /// - Parameters:
    ///   - permissions: 로그인할 때 permission을 담고 있는 String Array
    ///   - result: Flutter로 다시 보낼 수 있는 FlutterResult
    private func login(permissions: [String], result: @escaping FlutterResult) {
        let rootViewController = mainWindow?.rootViewController
        
        loginManager.logIn(permissions: permissions, from: rootViewController) { (response, error) -> Void in
            if let response = response {
                if response.isCancelled {
                    result(FlutterError(code: "CANCELLED", message: "User has cancelled with facebook", details: nil))
                } else {
                    if let token = response.token {
                        let accessToken = self.getAccessToken(accessToken: token)
                        result(accessToken)
                    }
                }
            } else if let error = error {
                result(FlutterError(code: "FAILED", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    
    /// 페이스북에서 나오는 AccessToken을 가지고 Result로 보내기 위해 [String: Any]로 변환하는 func
    /// - Parameter accessToken: 페이스북에서 나오는 AccessToken
    /// - Returns: Map형식으로 Return한다.
    private func getAccessToken(accessToken: AccessToken) -> [String: Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let data = [
            "tokenString": accessToken.tokenString,
            "userId": accessToken.userID,
            "expirationDate":
                dateFormatter.string(from: accessToken.expirationDate),
            "refreshDate":
                dateFormatter.string(from: accessToken.refreshDate),
            "appID":accessToken.appID,
            "isExpired":accessToken.isExpired,
            "permissions":accessToken.permissions.map {item in item.name},
            "declinedPermissions":accessToken.declinedPermissions.map {item in item.name},
            "dataAccessExpirationDate":dateFormatter.string(from: accessToken.dataAccessExpirationDate),
        ] as [String : Any]
        return data
    }
    
    
    /// 페이스북 로그인이 되어 있다면 UserInfo를 가져올 수 있는 func
    /// - Parameters:
    ///   - fields: UserInfo에서 가져올 field명 한 String으로 나열해야한다.
    ///   - flutterResult: Flutter로 다시 보낼 수 있는 FlutterResult
    private func getUserInfo(fields: String, flutterResult: @escaping FlutterResult) {
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":fields])
        graphRequest.start { (connection, result, error) -> Void in
            if (error != nil) {
                flutterResult(FlutterError(code: "FAILED", message: error!.localizedDescription, details: nil))
            } else {
                let resultDic = result as! NSDictionary
                flutterResult(resultDic)
            }
        }
    }
    
}
