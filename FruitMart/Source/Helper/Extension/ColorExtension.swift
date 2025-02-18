//
//  ColorExtension.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

// MARK: - Custom Colors
/// Color 타입 확장을 통한 커스텀 색상 정의
extension Color {
  /// 앱의 메인 컬러로 사용되는 복숭아 색상
  /// Assets.xcassets의 "peach" 컬러셋 참조
  static let peach = Color("peach")
  
  /// 기본 그림자 색상
  /// primary 색상에 20% 투명도 적용
  static let primaryShadow = Color.primary.opacity(0.2)
  
  /// 보조 텍스트에 사용되는 회색 계열 색상
  /// HEX: #6e6e6e
  static let secondaryText = Color(hex: "#6e6e6e")
  
  /// 배경색으로 사용되는 시스템 회색
  /// UIKit의 systemGray6 색상 사용
  static let background = Color(UIColor.systemGray6)
}


// MARK: - Hex Color Initializer
extension Color {
  /// HEX 코드를 사용하여 Color를 생성하는 이니셜라이저
  /// - Parameter hex: "#" 으로 시작하는 6자리 16진수 컬러 코드
  ///   (예: "#FF0000" for 빨간색)
  init(hex: String) {
    // 문자열을 스캔하기 위한 Scanner 인스턴스 생성
    let scanner = Scanner(string: hex)
    // "#" 문자 건너뛰기
    _ = scanner.scanString("#")
    
    // RGB 값을 저장할 변수 (64비트 정수형)
    var rgb: UInt64 = 0
    // 16진수 문자열을 64비트 정수로 스캔
    scanner.scanHexInt64(&rgb)
    
    // RGB 각 채널 값 추출 및 정규화 (0-255 값을 0-1 범위로 변환)
    let r = Double((rgb >> 16) & 0xFF) / 255.0  // 빨간색 채널
    let g = Double((rgb >>  8) & 0xFF) / 255.0  // 초록색 채널
    let b = Double((rgb >>  0) & 0xFF) / 255.0  // 파란색 채널
    
    // RGB 값으로 Color 인스턴스 생성
    self.init(red: r, green: g, blue: b)
  }
}
