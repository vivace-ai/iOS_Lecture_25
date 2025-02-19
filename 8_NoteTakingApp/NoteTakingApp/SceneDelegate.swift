//
//  SceneDelegate.swift
//  NoteTakingApp
//
//  목적: iOS 앱의 UI 라이프사이클 관리
//  주요 기능:
//  - 앱의 scene 생명주기 관리
//  - 백그라운드/포그라운드 전환 처리
//  - 앱 상태 변화에 따른 데이터 저장
//  - 메모리 관리 및 리소스 해제
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // scene이 앱에 연결될 때 호출됨
        // UIWindow를 생성하고 설정하는데 사용
        // 스토리보드 사용 시 window 속성이 자동으로 초기화되고 scene에 연결됨
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // scene이 시스템에 의해 해제될 때 호출됨
        // scene이 백그라운드로 전환되거나 세션이 삭제될 때 발생
        // scene과 관련된 리소스를 해제하고, 다음 연결 시 재생성할 수 있음
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // scene이 비활성 상태에서 활성 상태로 전환될 때 호출됨
        // 일시 중지되었거나 아직 시작되지 않은 작업을 다시 시작하는데 사용
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // scene이 활성 상태에서 비활성 상태로 전환될 때 호출됨
        // 전화나 메시지 같은 일시적인 중단이 발생할 때 실행됨
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // scene이 백그라운드에서 포그라운드로 전환될 때 호출됨
        // 백그라운드 진입 시 수행한 변경사항을 되돌리는데 사용
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // scene이 포그라운드에서 백그라운드로 전환될 때 호출됨
        // 데이터 저장, 공유 리소스 해제, scene 상태 정보 저장에 사용
        
        // 앱이 백그라운드로 전환될 때 관리되는 객체 컨텍스트의 변경사항 저장
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

