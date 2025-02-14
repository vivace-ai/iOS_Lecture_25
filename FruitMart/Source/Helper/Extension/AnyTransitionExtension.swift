//
//  AnyTransitionExtension.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

// MARK: - AnyTransition Extension
/// AnyTransition에 커스텀 줄무늬 전환 효과를 추가하는 확장
extension AnyTransition {
  /// 줄무늬 패턴을 사용한 전환 효과를 생성하는 정적 메서드
  /// - Returns: 삽입과 제거에 각각 다른 줄무늬 효과가 적용된 비대칭 전환
  static func stripes() -> AnyTransition {
    /// 줄무늬 효과를 위한 ViewModifier를 생성하는 내부 함수
    /// - Parameters:
    ///   - stripes: 줄무늬의 개수 (기본값: 30)
    ///   - insertion: true면 삽입 효과, false면 제거 효과
    ///   - ratio: 줄무늬의 표시 비율 (0.0 ~ 1.0)
    /// - Returns: 줄무늬 효과가 적용된 ViewModifier
    func stripesModifier(
      stripes: Int = 30,          // 줄무늬 개수
      insertion: Bool = true,      // 삽입/제거 모드
      ratio: CGFloat              // 줄무늬 비율
    ) -> some ViewModifier {
      let shape = Stripes(stripes: stripes, insertion: insertion, ratio: ratio)
      return ShapeClipModifier(shape: shape)
    }

    // 삽입 시 사용할 전환 효과 정의
    let insertion = AnyTransition.modifier(
      active: stripesModifier(ratio: 0),    // 전환 시작 시 비율 0
      identity: stripesModifier(ratio: 1)    // 전환 완료 시 비율 1
    )
    
    // 제거 시 사용할 전환 효과 정의
    let removal = AnyTransition.modifier(
      active: stripesModifier(insertion: false, ratio: 0),    // 전환 시작 시 비율 0
      identity: stripesModifier(insertion: false, ratio: 1)    // 전환 완료 시 비율 1
    )
    
    // 삽입과 제거에 각각 다른 효과를 적용하는 비대칭 전환 반환
    return AnyTransition.asymmetric(insertion: insertion, removal: removal)
  }
}
