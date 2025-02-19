//
//  AppDelegate.swift
//
//  목적: 앱의 전체 생명주기(라이프사이클)를 관리하는 핵심 델리게이트
//  주요 기능:
//  - 앱 시작 시 초기 설정
//  - 앱의 상태 변화 처리
//  - 시스템 이벤트 처리
//  - 백그라운드 작업 관리
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 앱이 처음 실행될 때 호출되는 메서드
        // 앱의 초기 설정 및 커스터마이징을 수행합니다
        return true
    }

    // MARK: UISceneSession 생명주기

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // 새로운 scene 세션이 생성될 때 호출됩니다
        // 새로운 scene을 생성하기 위한 구성을 선택하는데 사용됩니다
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // 사용자가 scene 세션을 삭제할 때 호출됩니다
        // 앱이 실행되지 않는 동안 세션이 삭제된 경우, application:didFinishLaunchingWithOptions 직후에 호출됩니다
        // 삭제된 scene과 관련된 리소스를 해제하는데 사용됩니다
    }
}

