//
//  AuthSevice.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 20.03.2021.
//

import Foundation
import VK_ios_sdk

class AuthSevice: NSObject, VKSdkDelegate, VKSdkUIDelegate {

    private let appId = "7795752"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state {
            case .initialized:
                print("initialized")
            case .authorized:
                print("authorized")
            default:
                fatalError(error?.localizedDescription as! String)
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
