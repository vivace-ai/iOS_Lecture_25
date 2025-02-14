//
//  AppSetting.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/03.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 과일마트 앱의 사용자 설정을 관리하는 모델을 구현합니다.
 - 즐겨찾기 목록 표시 여부 설정
 - 상품 행의 높이 설정
 
 [주요 기능]
 - 앱 설정 데이터 모델 정의
 - 사용자 기본 설정값 제공
*/

// SwiftUI 프레임워크 임포트 - CGFloat 타입 사용을 위해 필요
import SwiftUI

/// 앱의 사용자 설정을 관리하는 모델 구조체
struct AppSetting {
    /// 즐겨찾기 목록 표시 여부를 결정하는 플래그
    /// true: 즐겨찾기 목록 표시, false: 숨김
    var showFavoriteList: Bool = true
    
    /// 상품 행의 높이를 지정하는 값 (단위: 포인트)
    /// 기본값: 150pt
    var productRowHeight: CGFloat = 150
}
