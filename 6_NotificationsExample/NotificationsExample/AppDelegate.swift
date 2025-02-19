//
// AppDelegate.swift
// NotificationsExample
//
// MARK: - 파일 설명
/// 이 파일은 앱의 핵심 수명주기와 설정을 관리하는 델리게이트입니다.
/// 주요 역할:
/// - 앱의 시작점 (@main)으로 동작
/// - 앱 수준의 이벤트 처리 및 초기 설정
/// - 앱 전역 상태 관리
/// - 씬 세션의 생성 및 폐기 관리
/// - 시스템 수준의 이벤트 처리 (메모리 경고, 백그라운드 전환 등)

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 앱 실행 후 초기 설정을 위한 진입점입니다.
        // 앱의 커스텀 설정이나 초기화 코드를 이곳에 작성합니다.
        return true
    }

    // MARK: UISceneSession 수명주기

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // 새로운 씬 세션이 생성될 때 호출됩니다.
        // 새로운 씬을 생성하기 위한 구성을 선택하는 데 사용됩니다.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // 사용자가 씬 세션을 폐기할 때 호출됩니다.
        // 앱이 실행되지 않는 동안 세션이 폐기된 경우, application:didFinishLaunchingWithOptions 직후에 호출됩니다.
        // 폐기된 씬과 관련된 모든 리소스를 해제하는 데 사용됩니다 (해당 씬은 다시 복구되지 않습니다).
    }
}

