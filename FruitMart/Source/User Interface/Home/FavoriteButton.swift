//
//  FavoriteButton.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 상품의 즐겨찾기 상태를 토글하는 버튼 뷰를 구현합니다.
 - 상품의 즐겨찾기 상태에 따른 하트 아이콘 표시
 - 탭 제스처를 통한 즐겨찾기 상태 토글
 - 애니메이션을 통한 상태 변경 효과
 
 [주요 기능]
 - SF Symbols을 활용한 하트 아이콘 표시
 - 상품의 즐겨찾기 상태 관리
 - 애니메이션을 통한 상태 전환
*/

import SwiftUI

/// 상품의 즐겨찾기 상태를 토글하는 버튼 뷰
struct FavoriteButton: View {
    /// 스토어 데이터를 관리하는 환경 객체
    @EnvironmentObject private var store: Store
    /// 버튼과 연결된 상품 정보
    let product: Product
    
    /// 즐겨찾기 상태에 따른 아이콘 이름을 반환하는 계산 속성
    /// - Returns: 채워진 하트 또는 빈 하트 SF Symbol 이름
    private var imageName: String {
        // 즐겨찾기 상태에 따라 다른 아이콘 표시
        product.isFavorite ? "heart.fill" : "heart"
    }
    
    // MARK: - View Body
    
    var body: some View {
        // SF Symbols 아이콘을 사용한 버튼
        Symbol(imageName, scale: .large, color: .peach)
            // 버튼 크기 설정
            .frame(width: 32, height: 32)
            // 탭 제스처 처리
            .onTapGesture {
                // 애니메이션과 함께 즐겨찾기 상태 토글
                withAnimation {
                    self.store.toggleFavorite(of: self.product)
                }
            }
    }
}


// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 일반 상태의 버튼 프리뷰
            FavoriteButton(product: productSamples[0])
            // 즐겨찾기된 상태의 버튼 프리뷰
            FavoriteButton(product: productSamples[2])
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
