//
//  ResizedImage.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//
// 이 파일은 이미지 리사이징을 쉽게 처리할 수 있는 래퍼(wrapper) 뷰를 제공합니다.
// 반복적인 이미지 리사이징 코드를 줄이고 재사용성을 높이는 것이 목적입니다.

import SwiftUI

// 이미지를 원하는 크기와 모드로 리사이징할 수 있는 커스텀 뷰
// 주요 기능: 이미지 리사이징, 콘텐츠 모드 설정, 렌더링 모드 설정
struct ResizedImage: View {
  // 표시할 이미지의 에셋 이름 (Assets.xcassets에 있는 이미지 이름)
  let imageName: String
  // 이미지의 콘텐츠 모드 (.fill: 화면을 꽉 채움, .fit: 이미지 비율 유지)
  let contentMode: ContentMode
  // 이미지의 렌더링 모드 (.original: 원본 색상 유지, .template: 틴트 색상 적용)
  let renderingMode: Image.TemplateRenderingMode?
  
  // 편리한 사용을 위한 기본값이 설정된 초기화 메서드
  // imageName: 필수값, contentMode: 기본값 .fill, renderingMode: 기본값 nil
  init(
    _ imageName: String,
    contentMode: ContentMode = .fill,
    renderingMode: Image.TemplateRenderingMode? = nil
  ) {
    self.imageName = imageName
    self.contentMode = contentMode
    self.renderingMode = renderingMode
  }
  
  // 실제 이미지를 구성하고 설정을 적용하는 뷰 본문
  var body: some View {
    Image(imageName)
      .renderingMode(renderingMode)    // 지정된 렌더링 모드 적용 (nil이면 시스템 기본값 사용)
      .resizable()                     // 이미지 크기 조절 가능하도록 설정
      .aspectRatio(contentMode: contentMode)  // 지정된 contentMode로 이미지 비율 조정
  }
}


// MARK: - Previews

// 다양한 사용 예시를 보여주는 프리뷰
struct ResizedImage_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      // 기본 설정으로 이미지 표시 (fill 모드)
      ResizedImage("apple")
      // fit 모드로 이미지 표시 (이미지 비율 유지)
      ResizedImage("apple", contentMode: .fit)
      
      // 버튼 내부에서 기본 설정으로 이미지 사용 (시스템 틴트 색상 적용)
      Button(action: {}) {
        ResizedImage("apple")
      }
      // 버튼 내부에서 원본 색상을 유지하는 이미지 사용
      Button(action: {}) {
        ResizedImage("apple", renderingMode: .original)
      }
    }
  }
}
