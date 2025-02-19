//
//  SceneDelegate.swift
//
//  목적: 앱의 UI 생명주기(라이프사이클)를 관리하는 델리게이트
//  주요 기능:
//  - 앱의 화면(scene) 상태 변화 처리
//  - UI 윈도우 설정 및 관리
//  - 앱의 포그라운드/백그라운드 전환 처리
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // UIWindow를 설정하고 제공된 UIWindowScene에 연결하는 메서드입니다
        // 스토리보드를 사용하는 경우 window 프로퍼티가 자동으로 초기화되고 scene에 연결됩니다
        // 이 델리게이트는 연결되는 scene이나 세션이 새로운 것임을 의미하지 않습니다
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // 시스템에 의해 scene이 해제될 때 호출됩니다
        // scene이 백그라운드로 전환되거나 세션이 삭제될 때 발생합니다
        // scene과 관련된 모든 리소스를 해제하세요
        // scene은 나중에 다시 연결될 수 있습니다
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // scene이 비활성 상태에서 활성 상태로 전환될 때 호출됩니다
        // 일시 중지되었거나 아직 시작되지 않은 작업을 다시 시작하는 데 사용합니다
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // scene이 활성 상태에서 비활성 상태로 전환될 때 호출됩니다
        // 전화가 오는 것과 같은 일시적인 중단이 발생할 수 있습니다
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // scene이 백그라운드에서 포그라운드로 전환될 때 호출됩니다
        // 백그라운드 진입 시 수행한 변경사항을 되돌리는 데 사용합니다
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // scene이 포그라운드에서 백그라운드로 전환될 때 호출됩니다
        // 데이터 저장, 공유 리소스 해제, scene 상태 정보 저장 등을 수행합니다
    }


}

