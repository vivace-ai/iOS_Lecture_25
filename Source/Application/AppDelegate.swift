//
//  AppDelegate.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//  주석 -  김영희 (이스트소프트 프론티어 iOS)

/*
 [파일 역할]
 이 파일은 앱의 생명주기(Life Cycle)를 관리하는 핵심 클래스를 포함합니다.
 - 앱의 실행, 백그라운드 전환, 종료 등 상태 변화 처리
 - 앱 수준의 이벤트 관리 (푸시 알림, URL 스킴 처리 등)
 - Scene 기반 UI 설정 (iOS 13 이상)
 - 시스템 이벤트에 대한 응답 처리
 
 [주요 프로토콜]
 UIApplicationDelegate
 - 앱의 공유 동작을 관리하고 시스템과의 상호작용을 처리하는 프로토콜
 - 참고: https://developer.apple.com/documentation/uikit/uiapplicationdelegate
*/

import UIKit

// @UIApplicationMain: 앱의 진입점(Entry Point)을 지정하는 특성
// UIResponder: 이벤트 응답 및 처리를 위한 인터페이스
// UIApplicationDelegate: 앱 수준의 이벤트 처리를 위한 프로토콜
@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    /*
     [클래스 구현 가능한 주요 메서드]
     
     1. application(_:didFinishLaunchingWithOptions:)
        - 앱 실행 시 최초 호출
        - 앱의 초기 설정 수행
        - 데이터 구조 초기화
        - 필수 서비스 시작
     
     2. applicationWillTerminate(_:)
        - 앱 종료 시 호출
        - 사용자 데이터 저장
        - 리소스 정리
     
     3. application(_:configurationForConnecting:options:)
        - 새로운 Scene 세션 생성 시 호출
        - Scene 구성 정보 제공
     
     4. application(_:didDiscardSceneSessions:)
        - Scene 세션 삭제 시 호출
        - 관련 리소스 정리
     
     5. application(_:didRegisterForRemoteNotificationsWithDeviceToken:)
        - 푸시 알림 등록 성공 시 호출
        - 디바이스 토큰 처리
     
     [주요 속성]
     - window: iOS 12 이하에서 사용되는 메인 윈도우
     - applicationState: 현재 앱의 실행 상태
     - backgroundTimeRemaining: 백그라운드 실행 가능 시간
    */
}
