//
//  Preview.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
// Preview.swift 파일은 SwiftUI의 프리뷰 기능을 확장한 커스텀 프리뷰 헬퍼입니다. 여러 기기에서 동시에 프리뷰를 보여주고, 다크모드까지 한번에 확인할 수 있게 해주는 유틸리티 파일

import SwiftUI

// 제네릭 View 타입을 받아 여러 디바이스에서 미리보기를 생성하는 커스텀 프리뷰 구조체
struct Preview<V: View>: View {
  // 지원하는 디바이스 목록을 정의하는 열거형
  enum Device: String, CaseIterable {
    case iPhone8 = "iPhone 8"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
  }

  // 프리뷰할 뷰 컨텐츠
  let source: V
  // 프리뷰할 디바이스 배열 (기본값: iPhone11Pro, iPhone11ProMax, iPhone8)
  var devices: [Device] = [.iPhone11Pro, .iPhone11ProMax, .iPhone8]
  // 다크모드 프리뷰 표시 여부 (기본값: true)
  var displayDarkMode: Bool = true

  // MARK: Body
  
  // 여러 디바이스와 다크모드 프리뷰를 생성하는 메인 뷰
  var body: some View {
    return Group {
      // 지정된 모든 디바이스에 대해 프리뷰 생성
      ForEach(devices, id: \.self) {
        self.previewSource(device: $0)
      }
      // 다크모드 프리뷰 추가 (설정된 경우)
      if !devices.isEmpty && displayDarkMode {
        self.previewSource(device: devices[0])
          .preferredColorScheme(.dark)
      }
    }
  }

  // 특정 디바이스에 대한 프리뷰를 생성하는 헬퍼 메서드
  private func previewSource(device: Device) -> some View {
    source
      .previewDevice(PreviewDevice(rawValue: device.rawValue))
      .previewDisplayName(device.rawValue)
  }
}


// MARK: - Previews

// Preview 구조체 자체의 사용예시를 보여주는 프리뷰
struct Preview_Previews: PreviewProvider {
  static var previews: some View {
    Preview(source: Text("Hello, SwiftUI!"))
  }
}
