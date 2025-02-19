//
// SceneDelegate.swift
// NotificationsExample
//
// MARK: - 파일 설명
/// 이 파일은 앱의 UI 씬(scene) 수명주기를 관리하는 델리게이트입니다.
/// iOS 13 이상에서 멀티 윈도우 지원을 위한 씬 기반 생명주기 이벤트를 처리합니다.
/// 주요 역할:
/// - 앱의 UI 씬 설정 및 초기화
/// - 씬의 상태 변화 관리 (활성/비활성, 포그라운드/백그라운드)
/// - 시스템 이벤트에 따른 리소스 관리

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // UIWindow를 생성하고 제공된 UIWindowScene에 연결하는 메서드입니다.
        // 스토리보드를 사용하는 경우 window 프로퍼티가 자동으로 초기화되고 씬에 연결됩니다.
        // 이 델리게이트는 연결되는 씬이나 세션이 새로운 것임을 의미하지 않습니다.
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // 시스템에 의해 씬이 해제될 때 호출됩니다.
        // 씬이 백그라운드로 전환되거나 세션이 폐기된 직후에 발생합니다.
        // 다음 연결 시 재생성할 수 있는 이 씬과 관련된 모든 리소스를 해제하세요.
        // 세션이 반드시 폐기되는 것은 아니므로 씬이 나중에 다시 연결될 수 있습니다.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 씬이 비활성 상태에서 활성 상태로 전환될 때 호출됩니다.
        // 씬이 비활성 상태일 때 일시 중지되었거나 아직 시작되지 않은 작업을 다시 시작하는 데 사용합니다.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // 씬이 활성 상태에서 비활성 상태로 전환될 때 호출됩니다.
        // 수신 전화와 같은 일시적인 중단이 발생할 때 실행됩니다.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // 씬이 백그라운드에서 포그라운드로 전환될 때 호출됩니다.
        // 백그라운드 진입 시 수행한 변경사항을 되돌리는 데 사용합니다.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // 씬이 포그라운드에서 백그라운드로 전환될 때 호출됩니다.
        // 데이터 저장, 공유 리소스 해제, 현재 상태로 복원하는 데 필요한 씬별 상태 정보를
        // 저장하는 데 사용합니다.
    }


}

