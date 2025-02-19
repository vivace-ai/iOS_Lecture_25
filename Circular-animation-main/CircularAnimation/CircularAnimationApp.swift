//
//  CircularAnimationApp.swift
//  CircularAnimation
//
//  Created by 김영희 on 2025-02-18
//
//  파일 설명:
//  CircularAnimation 앱의 메인 진입점입니다.
//  앱의 기본 구조와 초기 화면을 설정하는 역할을 담당합니다.
//
//  주요 기능:
//  - 앱의 라이프사이클 관리
//  - 루트 뷰(ContentView) 초기화 및 표시
//  - 앱의 기본 Scene 구성
//

import SwiftUI

/// 앱의 메인 진입점을 정의하는 구조체
/// @main 어트리뷰트를 통해 앱의 시작점으로 지정됨
@main
struct CircularAnimationApp: App {
    /// 앱의 기본 scene을 구성하는 body 프로퍼티
    /// WindowGroup을 사용하여 기본 창 그룹을 생성하고 ContentView를 루트 뷰로 설정
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
