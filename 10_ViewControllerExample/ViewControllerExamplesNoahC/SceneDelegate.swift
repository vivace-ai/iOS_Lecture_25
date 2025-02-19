//
//  SceneDelegate.swift
//  ViewControllerExamplesNoahC
//
//  Created by 김영희 on 2025-02-19.
//
//  파일 설명:
//  이 파일은 앱의 UI 씬(화면) 생명주기를 관리하는 SceneDelegate 클래스를 포함합니다.
//  iOS 13 이후 도입된 멀티 윈도우 지원을 위한 핵심 컴포넌트로,
//  각 씬의 상태 변화(활성화, 비활성화, 백그라운드 전환 등)를 처리합니다.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // UIWindow를 구성하고 제공된 UIWindowScene에 연결하는 메서드입니다.
        // 스토리보드를 사용하는 경우 window 프로퍼티가 자동으로 초기화되고 씬에 연결됩니다.
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // 시스템에 의해 씬이 해제될 때 호출됩니다.
        // 씬이 백그라운드로 전환되거나 세션이 종료될 때 발생합니다.
        // 다음 연결 시 재생성할 수 있는 씬 관련 리소스를 해제하세요.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 씬이 비활성 상태에서 활성 상태로 전환될 때 호출됩니다.
        // 씬이 비활성 상태일 때 일시 중지되었거나 시작되지 않은 작업을 다시 시작하세요.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // 씬이 활성 상태에서 비활성 상태로 전환될 때 호출됩니다.
        // 수신 전화와 같은 일시적인 중단이 발생할 때 호출될 수 있습니다.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // 씬이 백그라운드에서 포그라운드로 전환될 때 호출됩니다.
        // 백그라운드 진입 시 수행한 변경사항을 되돌리기 위해 이 메서드를 사용하세요.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // 씬이 포그라운드에서 백그라운드로 전환될 때 호출됩니다.
        // 데이터 저장, 공유 리소스 해제, 현재 상태 복원에 필요한 씬 정보를 저장하세요.
    }
}

