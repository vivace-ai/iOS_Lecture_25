//
//  MainTabView.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 앱의 메인 탭 인터페이스를 구현하는 핵심 뷰입니다.
 - 홈, 레시피, 갤러리, 마이페이지 등 주요 기능 탭 관리
 - 탭 간 전환 및 상태 관리
 - 각 탭의 UI 구성 및 스타일링
 
 [주요 기능]
 - TabView를 사용한 메인 네비게이션 구현
 - SF Symbols을 활용한 탭 아이콘 표시
 - 상태 바 및 SafeArea 관리
 - 탭별 고유 설정 적용
*/

import SwiftUI

// MARK: - MainTabView
/// 앱의 메인 탭 인터페이스를 구성하는 뷰 구조체
struct MainTabView: View {
  // MARK: - Properties
  
  /// 탭 항목을 정의하는 열거형
  private enum Tabs {
    case home      // 홈 화면
    case recipe    // 레시피 화면
    case gallery   // 이미지 갤러리
    case myPage    // 마이페이지
  }
  
  /// 현재 선택된 탭을 추적하는 상태 변수
  @State private var selectedTab: Tabs = .home
  
  // MARK: - View
  
  /// 메인 뷰 본문
  /// - TabView: 여러 하위 뷰를 탭으로 전환할 수 있는 컨테이너 뷰
  /// - accentColor: 탭 아이템의 강조색 지정
  /// - edgesIgnoringSafeArea: 안전 영역 무시 설정
  var body: some View {
    TabView(selection: $selectedTab) {
      Group {
        home
        recipe
        imageGallery
        myPage
      }
      .accentColor(.primary)
    }
    .accentColor(.peach)
    .edgesIgnoringSafeArea(edges)
    .statusBar(hidden: selectedTab == .recipe)
  }
}

// MARK: - Private Extensions
private extension MainTabView {
  // MARK: Tab Views
  
  /// 홈 탭 뷰
  /// - tag: 탭 식별자
  /// - tabItem: 탭 바에 표시될 아이템 설정
  var home: some View {
    Home()
      .tag(Tabs.home)
      .tabItem(image: "house", text: "홈")
      // iOS 14.0에서는 이 방식이 적용되지 않습니다.
      .onAppear { UITableView.appearance().separatorStyle = .none }
  }
  
  /// 레시피 탭 뷰
  var recipe: some View {
    RecipeView()
      .tag(Tabs.recipe)
      .tabItem(image: "book", text: "레시피")
  }
  
  /// 이미지 갤러리 탭 뷰
  var imageGallery: some View {
    ImageGallery()
      .tag(Tabs.gallery)
      .tabItem(image: "photo.on.rectangle", text: "갤러리")
  }
  
  /// 마이페이지 탭 뷰
  var myPage: some View {
    MyPage()
      .tag(Tabs.myPage)
      .tabItem(image: "person", text: "마이페이지")
      // iOS 14.0에서는 이 방식이 적용되지 않습니다.
      .onAppear { UITableView.appearance().separatorStyle = .singleLine }
  }
  
  // MARK: Computed Properties
  
  /// SafeArea 무시 설정을 위한 계산 속성
  /// - iOS 버전에 따라 다른 설정 반환
  var edges: Edge.Set {
    if #available(iOS 13.4, *) {
      return .init()
    } else {
      return .top
    }
  }
}

// MARK: - View Extension
/// 탭 아이템 설정을 위한 View 확장
fileprivate extension View {
  /// 탭 아이템 구성을 위한 메서드
  /// - Parameters:
  ///   - image: SF Symbols 이미지 이름
  ///   - text: 탭 아이템 텍스트
  func tabItem(image: String, text: String) -> some View {
    self.tabItem {
      Symbol(image, scale: .large)
        .font(Font.system(size: 17, weight: .light))
      Text(text)
    }
  }
}

// MARK: - Preview
/// SwiftUI 프리뷰 제공
struct MainTabView_Previews: PreviewProvider {
  static var previews: some View {
    Preview(source: MainTabView())
      .environmentObject(Store())
  }
}
