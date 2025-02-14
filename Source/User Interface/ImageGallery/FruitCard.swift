//
//  FruitCard.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 이미지 갤러리에서 사용되는 과일 카드 뷰를 구현합니다.
 - 과일 이미지를 카드 형태로 표시
 - 크기와 모서리 둥글기 조절 가능
 - 재사용 가능한 카드 컴포넌트
 
 [주요 기능]
 - 이미지 크기 조절
 - 모서리 둥글기 커스터마이징
 - 갤러리 그리드 레이아웃 지원
*/

import SwiftUI

/// 과일 이미지를 카드 형태로 표시하는 뷰 구조체
struct FruitCard: View {
    /// 표시할 이미지의 이름
    let imageName: String
    /// 카드의 크기
    let size: CGSize
    /// 모서리 둥글기 정도
    let cornerRadius: CGFloat
    
    /// 초기화 메서드
    /// - Parameters:
    ///   - imageName: 표시할 이미지 이름
    ///   - size: 카드 크기 (기본값: 240x200)
    ///   - cornerRadius: 모서리 둥글기 (기본값: 14)
    init(
        _ imageName: String,
        size: CGSize = CGSize(width: 240, height: 200),
        cornerRadius: CGFloat = 14
    ) {
        self.imageName = imageName
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    // MARK: - View Body
    
    var body: some View {
        // 이미지 크기 조정 및 모서리 처리
        ResizedImage(imageName)
            // 지정된 크기로 프레임 설정
            .frame(width: size.width, height: size.height)
            // 모서리 둥글게 처리
            .cornerRadius(cornerRadius)
    }
}


// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct FruitCard_Previews: PreviewProvider {
    static var previews: some View {
        // 샘플 데이터를 사용하여 여러 카드 미리보기
        ForEach(productSamples) {
            FruitCard($0.imageName)
                .previewLayout(.fixed(width: 260, height: 220))
        }
    }
}
