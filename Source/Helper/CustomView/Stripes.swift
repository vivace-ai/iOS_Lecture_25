//
//  Stripes.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

/// 애니메이션이 가능한 줄무늬 패턴을 그리는 커스텀 Shape
/// Shape와 Hashable 프로토콜을 준수하여 식별 가능하고 그릴 수 있는 도형
struct Stripes: Shape, Hashable {
  /// 줄무늬의 총 개수 (기본값: 30개)
  var stripes: Int = 30
  
  /// 줄무늬가 삽입되는 방향을 결정
  /// - true: 왼쪽에서 오른쪽으로 삽입
  /// - false: 오른쪽에서 왼쪽으로 삽입
  var insertion: Bool = true
  
  /// 줄무늬의 표시 비율 (0.0 ~ 1.0)
  /// - 0.0: 줄무늬가 없음
  /// - 1.0: 줄무늬가 완전히 표시됨
  var ratio: CGFloat
  
  /// 애니메이션 가능한 프로퍼티 설정
  /// ratio 값의 변화에 따라 애니메이션 적용
  var animatableData: CGFloat {
    get { ratio }
    set { ratio = newValue }
  }
  
  /// Shape 프로토콜 요구사항: 실제 줄무늬를 그리는 메서드
  /// - Parameter rect: 줄무늬를 그릴 영역의 크기
  /// - Returns: 줄무늬 패턴이 그려진 Path
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    // 각 줄무늬의 너비 계산
    let stripeWidth = rect.width / CGFloat(stripes)
    
    // 각 줄무늬에 대한 사각형 생성
    let rects = (0..<stripes).map { (index: Int) -> CGRect in
      // 줄무늬의 x 위치 계산
      let xOffset = CGFloat(index) * stripeWidth
      // insertion 값에 따라 줄무늬 시작 위치 조정
      let adjustment = insertion ? 0 : (stripeWidth * (1 - ratio))
      
      // 줄무늬 사각형 생성
      return CGRect(
        x: xOffset + adjustment,    // x 위치
        y: 0,                      // y 위치 (항상 0)
        width: stripeWidth * ratio, // 줄무늬 너비
        height: rect.height        // 전체 높이
      )
    }
    
    // 모든 줄무늬 사각형을 path에 추가
    path.addRects(rects)
    return path
  }
}


// MARK: - Previews

/// Stripes Shape의 다양한 설정을 보여주는 프리뷰
struct Stripes_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      // 삽입 모드에서의 다양한 비율
      Stripes(insertion: true, ratio: 0.2).previewDisplayName("20%")
      Stripes(insertion: true, ratio: 0.5).previewDisplayName("50%")
      Stripes(insertion: true, ratio: 0.8).previewDisplayName("80%")
      Stripes(insertion: true, ratio: 1.0).previewDisplayName("100%")
      
      // 제거 모드에서의 다양한 비율
      Stripes(insertion: false, ratio: 0.8).previewDisplayName("80%")
      Stripes(insertion: false, ratio: 0.5).previewDisplayName("50%")
      Stripes(insertion: false, ratio: 0.2).previewDisplayName("20%")
      Stripes(insertion: false, ratio: 0.0).previewDisplayName("0%")
    }
    .previewLayout(.fixed(width: 350, height: 30))
  }
}
