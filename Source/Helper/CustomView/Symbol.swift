//
//  Symbol.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//
// 이 파일은 SF Symbols 시스템 아이콘을 간편하게 사용할 수 있는 래퍼 뷰를 제공합니다.
// SF Symbols는 Apple이 제공하는 일관된 디자인의 시스템 아이콘 세트입니다.

import SwiftUI

// SF Symbols 아이콘을 커스터마이징할 수 있는 커스텀 뷰
struct Symbol: View {
  // SF Symbols에서 사용할 아이콘의 이름
  // 예: "heart.fill", "star", "cart" 등
  let systemName: String
  
  // 아이콘의 크기 설정 (.small, .medium, .large)
  // imageScale은 아이콘의 상대적 크기를 결정
  let imageScale: Image.Scale
  
  // 아이콘의 색상 (nil일 경우 현재 컨텍스트의 foregroundColor 사용)
  let color: Color?
  
  // 편리한 사용을 위한 기본값이 설정된 초기화 메서드
  init(
    _ systemName: String,          // SF Symbols 아이콘 이름 (필수)
    scale imageScale: Image.Scale = .medium,  // 크기 (기본값: .medium)
    color: Color? = nil           // 색상 (기본값: nil)
  ) {
    self.systemName = systemName
    self.imageScale = imageScale
    self.color = color
  }
  
  // 실제 SF Symbol 아이콘을 구성하고 설정을 적용하는 뷰 본문
  var body: some View {
    Image(systemName: systemName)    // SF Symbol 아이콘 생성
      .imageScale(imageScale)        // 지정된 크기 스케일 적용
      .foregroundColor(color)        // 지정된 색상 적용 (nil이면 상위 뷰의 색상 상속)
  }
}


// MARK: - Previews

// 다양한 설정으로 Symbol을 보여주는 프리뷰
struct Symbol_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 20) {
      // 기본 설정의 하트 아이콘 (중간 크기, 기본 색상)
      Symbol("heart.fill")
      
      // 큰 크기의 하트 아이콘
      Symbol("heart.fill", scale: .large)
      
      // 큰 크기의 빨간색 하트 아이콘
      Symbol("heart.fill", scale: .large, color: .red)
      
      // 큰 크기의 빨간색 테두리만 있는 하트 아이콘
      // .font 수식어로 추가 스타일링
      Symbol("heart", scale: .large, color: .red)
        .font(Font.system(size: 25, weight: .black))
    }
  }
}
