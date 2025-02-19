//
//  AppDelegate.swift
//  NoteTakingApp
//
//  목적: 앱의 전체 생명주기 관리 및 CoreData 설정
//  주요 기능:
//  - 앱 실행 시 초기 설정
//  - CoreData 스택 초기화 및 관리
//  - 데이터 저장소 설정
//  - 앱 상태 변화에 따른 데이터 관리
//  - 시스템 이벤트 처리
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 앱 실행 후 초기 설정을 위한 진입점
        return true
    }

    // MARK: UISceneSession 생명주기

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // 새로운 scene 세션이 생성될 때 호출됨
        // 새로운 scene을 생성하기 위한 구성을 선택하는데 사용
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // 사용자가 scene 세션을 삭제할 때 호출됨
        // 앱이 실행되지 않는 동안 세션이 삭제된 경우, application:didFinishLaunchingWithOptions 직후에 호출됨
        // 삭제된 scene과 관련된 리소스를 해제하는데 사용
    }

    // MARK: - CoreData 스택

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         앱의 영구 저장소 컨테이너
         이 구현은 컨테이너를 생성하고 앱의 저장소를 로드하여 반환함
         저장소 생성이 실패할 수 있는 정당한 오류 조건이 있으므로 이 속성은 옵셔널임
        */
        let container = NSPersistentContainer(name: "NoteTakingApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // 오류를 적절히 처리하기 위해 이 구현을 수정해야 함
                // fatalError()는 앱을 강제 종료하고 로그를 생성함
                // 실제 배포 앱에서는 사용하지 말 것
                 
                /*
                 일반적인 오류 원인:
                 * 상위 디렉토리가 존재하지 않거나, 생성할 수 없거나, 쓰기가 허용되지 않음
                 * 기기가 잠겨있거나 권한 문제로 영구 저장소에 접근할 수 없음
                 * 기기의 저장 공간이 부족함
                 * 저장소를 현재 모델 버전으로 마이그레이션할 수 없음
                 실제 문제를 확인하려면 오류 메시지를 확인하세요
                 */
                fatalError("해결되지 않은 오류 발생 \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - CoreData 저장 지원

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // 오류를 적절히 처리하기 위해 이 구현을 수정해야 함
                // fatalError()는 앱을 강제 종료하고 로그를 생성함
                // 실제 배포 앱에서는 사용하지 말 것
                let nserror = error as NSError
                fatalError("해결되지 않은 오류 발생 \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

