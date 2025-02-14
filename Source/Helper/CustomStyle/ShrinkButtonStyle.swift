//
//  ShrinkButtonStyle.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
// 디자인시스템의 구성 요소 중 버튼에 관련된 사항

// SwiftUI 프레임워크 임포트
import SwiftUI

// ButtonStyle 프로토콜을 준수하는 커스텀 버튼 스타일 구조체 정의
struct ShrinkButtonStyle: ButtonStyle {
  // 버튼이 눌렸을 때 축소될 최소 크기 비율 (기본값 0.9)
  var minScale: CGFloat = 0.9
  // 버튼이 눌렸을 때의 최소 투명도 (기본값 0.6)
  var minOpacity: Double = 0.6
  
  // ButtonStyle 프로토콜의 필수 메서드 구현
  // configuration 파라미터를 통해 버튼의 상태(눌림 여부 등)를 전달받음
  func makeBody(configuration: Self.Configuration) -> some View {
    // 버튼의 레이블(내용)에 애니메이션 효과 적용
    configuration.label
      // 버튼이 눌리면 축소, 떼면 원래 크기로 복원
      .scaleEffect(configuration.isPressed ? minScale : 1)
      // 버튼이 눌리면 투명도 증가, 떼면 원래 투명도로 복원
      .opacity(configuration.isPressed ? minOpacity : 1)
  }
}


// MARK: - Previews
// 버튼 스타일 미리보기를 위한 PreviewProvider 구현
struct ShrinkButtonStyle_Previews: PreviewProvider {
  static var previews: some View {
    // 예시 버튼 생성
    Button(action: {}) {
      // 버튼 텍스트
      Text("Button")
        // 버튼 내부 여백 설정
        .padding()
        // 버튼 좌우 여백 추가
        .padding(.horizontal)
        // 노란색 캡슐 모양 배경 설정
        .background(Capsule().fill(Color.yellow))
    }
    // 생성한 커스텀 버튼 스타일 적용
    .buttonStyle(ShrinkButtonStyle())
  }
}
