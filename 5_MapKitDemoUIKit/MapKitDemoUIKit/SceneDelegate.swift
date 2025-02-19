//
//  SceneDelegate.swift
//  MapKitDemoUIKit
//
//  Created by Kim Young Hee on 2025-02-18.
//

import UIKit

// UIResponder: 이벤트 처리를 위한 인터페이스를 정의하는 추상 기본 클래스
// 앱에서 발생하는 다양한 이벤트를 처리하는 기본 클래스입니다
//
// UIWindowSceneDelegate: 앱의 UI 장면 수명 주기를 관리하는 프로토콜
// 앱의 화면(Scene) 상태 변화를 처리하는 메서드들을 포함합니다
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // UIWindow: 앱의 UI를 표시하는 컨테이너
    // 앱의 뷰 계층구조를 관리하는 객체입니다
    var window: UIWindow?

    // scene(_:willConnectTo:options:): 새로운 UI 장면이 앱에 추가될 때 호출
    // 새로운 화면이 앱에 연결될 때 초기 설정을 수행합니다
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        // 이 메서드를 사용하여 UIWindow를 UIWindowScene에 연결하고 구성합니다
        // 스토리보드를 사용하는 경우 window 프로퍼티가 자동으로 초기화되고 장면에 연결됩니다
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    // sceneDidDisconnect: 장면이 시스템에 의해 해제될 때 호출
    // 앱이 백그라운드로 이동하거나 세션이 종료될 때 정리 작업을 수행합니다
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        // 시스템에 의해 장면이 해제될 때 호출됩니다
        // 장면이 백그라운드로 진입하거나 세션이 폐기될 때 발생합니다
        // 다음 연결 시 재생성할 수 있는 리소스들을 해제합니다
    }

    // sceneDidBecomeActive: 장면이 활성 상태가 되었을 때 호출
    // 앱이 포그라운드에서 실행되고 사용자와 상호작용할 준비가 되었을 때 호출됩니다
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        // 장면이 비활성 상태에서 활성 상태로 전환될 때 호출됩니다
        // 일시 중지되었거나 아직 시작되지 않은 작업들을 다시 시작하는데 사용합니다
    }

    // sceneWillResignActive: 장면이 비활성 상태로 전환되기 직전에 호출
    // 전화가 오거나 다른 앱으로 전환될 때 등 일시적인 중단이 발생할 때 호출됩니다
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        // 장면이 활성 상태에서 비활성 상태로 전환되기 직전에 호출됩니다
        // 전화나 알림 등의 일시적인 중단으로 인해 발생할 수 있습니다
    }

    // sceneWillEnterForeground: 장면이 백그라운드에서 포그라운드로 전환될 때 호출
    // 앱이 다시 사용자에게 보여질 때 필요한 준비 작업을 수행합니다
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        // 장면이 백그라운드에서 포그라운드로 전환될 때 호출됩니다
        // 백그라운드 진입 시 수행한 변경사항을 되돌리는데 사용합니다
    }

    // sceneDidEnterBackground: 장면이 포그라운드에서 백그라운드로 전환될 때 호출
    // 앱이 백그라운드로 이동할 때 데이터 저장 등의 정리 작업을 수행합니다
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        // 장면이 포그라운드에서 백그라운드로 전환될 때 호출됩니다
        // 데이터 저장, 공유 리소스 해제, 현재 상태 복원에 필요한 정보 저장 등을 수행합니다
    }
}

