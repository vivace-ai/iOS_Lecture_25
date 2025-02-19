//
//  AppDelegate.swift
//  ViewControllerExamplesNoahC
//
//  Created by 김영희 on 2025-02-19.
//
//  파일 설명:
//  이 파일은 앱의 생명주기를 관리하는 AppDelegate 클래스를 포함하고 있습니다.
//  앱의 실행, 종료 및 상태 변화와 관련된 핵심 이벤트들을 처리하며,
//  UIKit 프레임워크와 앱 간의 상호작용을 조정하는 역할을 합니다.

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 앱 실행 후 초기 설정을 위한 진입점입니다.
        return true
    }

    // MARK: UISceneSession 생명주기

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // 새로운 씬 세션이 생성될 때 호출됩니다.
        // 새로운 씬을 생성하기 위한 구성을 선택하는 메서드입니다.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // 사용자가 씬 세션을 종료할 때 호출됩니다.
        // 앱이 실행되지 않는 동안 세션이 종료된 경우, application:didFinishLaunchingWithOptions 직후에 호출됩니다.
        // 종료된 씬과 관련된 리소스를 해제하기 위해 이 메서드를 사용하세요.
    }
}

