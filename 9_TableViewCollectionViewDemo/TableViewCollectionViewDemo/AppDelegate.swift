//
// AppDelegate.swift
// TableViewCollectionViewDemo

// Created by 김영희 on 2025-02-19.

// 이 파일은 앱의 생명주기를 관리하는 핵심 델리게이트입니다.
// 주요 역할:
// - 앱 실행 시 초기 설정
// - 씬(Scene) 생명주기 관리
// - 시스템 이벤트 처리

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 앱 실행 후 초기화 작업을 위한 진입점입니다.
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

