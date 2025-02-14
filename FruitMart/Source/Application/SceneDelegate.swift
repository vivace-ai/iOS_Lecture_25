//
//  SceneDelegate.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

// MARK: - SceneDelegate
/// 앱의 UI 씬(화면)을 관리하고 설정하는 delegate 클래스
/// iOS 13 이상에서 멀티 윈도우 지원을 위해 사용됨
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  /// 앱의 메인 윈도우를 저장하는 프로퍼티
  var window: UIWindow?
  
  
  /// 새로운 씬이 생성될 때 호출되는 메서드
  /// - Parameters:
  ///   - scene: 연결될 씬
  ///   - session: 씬 세션 정보
  ///   - connectionOptions: 씬 연결 옵션
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    // 앱의 전체적인 외관 설정
    configureAppearance()
    
    // 메인 탭 뷰를 루트 뷰로 설정하고 Store 객체를 환경 객체로 주입
    let rootView = MainTabView()
      .environmentObject(Store())
    
    // 윈도우 씬을 설정하고 루트 뷰 컨트롤러 지정
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: rootView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
  /// 앱의 네비게이션 바, 테이블 뷰, 슬라이더 등의 UI 요소 외관을 설정하는 메서드
  private func configureAppearance() {
    // 네비게이션 바 큰 제목의 색상을 peach 색상으로 설정
    UINavigationBar.appearance().largeTitleTextAttributes = [
      .foregroundColor: UIColor(named: "peach")!
    ]
    // 네비게이션 바 일반 제목의 색상을 peach 색상으로 설정
    UINavigationBar.appearance().titleTextAttributes = [
      .foregroundColor: UIColor(named: "peach")!
    ]
    // 테이블 뷰의 배경색을 투명하게 설정
    UITableView.appearance().backgroundColor = .clear
    // 슬라이더의 썸(동그라미) 색상을 peach 색상으로 설정
    UISlider.appearance().thumbTintColor = UIColor(named: "peach")
  }
}
