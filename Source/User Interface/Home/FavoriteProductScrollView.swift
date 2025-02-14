//
//  FavoriteProductScrollView.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 즐겨찾기한 상품들을 가로 스크롤 형태로 표시하는 뷰를 구현합니다.
 - 즐겨찾기 상품들의 원형 이미지 표시
 - 가로 스크롤을 통한 즐겨찾기 상품 탐색
 - 상품 이미지 표시/숨김 토글 기능
 - 스크롤 위치에 따른 동적 크기 조절 효과
 
 [주요 기능]
 - 수평 스크롤 뷰를 통한 즐겨찾기 상품 목록 표시
 - 애니메이션을 통한 부드러운 UI 전환
 - 스크롤 위치 기반 동적 크기 조절
 - 상품 상세 페이지로의 네비게이션
*/

import SwiftUI

/// 즐겨찾기한 상품들을 가로 스크롤로 표시하는 뷰
struct FavoriteProductScrollView: View {
    /// 스토어 데이터를 관리하는 환경 객체
    @EnvironmentObject private var store: Store
    /// 이미지 표시 여부를 제어하는 바인딩 변수
    @Binding var showingImage: Bool
    
    // MARK: - View Body
    
    var body: some View {
        // 전체 컨테이너를 수직으로 구성
        VStack(alignment: .leading) {
            title       // 상단 제목 영역
            
            // 이미지 표시 상태에 따른 조건부 렌더링
            if showingImage {
                products    // 상품 목록 영역
            }
        }
        // 여백 설정
        .padding()
        // 슬라이드 방식의 전환 효과
        .transition(.slide)
    }
}

// MARK: - Private Extensions
private extension FavoriteProductScrollView {
    // MARK: View Components
    
    /// 즐겨찾기 섹션의 제목 영역을 구성하는 뷰
    var title: some View {
        // 제목과 토글 버튼을 가로로 배치
        HStack(alignment: .top, spacing: 5) {
            // 섹션 제목
            Text("즐겨찾는 상품")
                .font(.headline).fontWeight(.medium)
            
            // 토글 화살표 아이콘
            Symbol("arrowtriangle.up.square")
                .padding(4)
                // 표시 상태에 따라 아이콘 회전
                .rotationEffect(Angle(radians: showingImage ? .pi : 0))
            
            Spacer()
        }
        .padding(.bottom, 8)
        // 탭 제스처로 이미지 표시 토글
        .onTapGesture {
            withAnimation { self.showingImage.toggle() }
        }
    }
    
    /// 즐겨찾기한 상품들을 가로 스크롤로 표시하는 뷰
    var products: some View {
        // 즐겨찾기된 상품들만 필터링
        let favoriteProducts = store.products.filter { $0.isFavorite }
        return ScrollView(.horizontal, showsIndicators: false) {
            // 상품들을 가로로 배치
            HStack(spacing: 0) {
                // 각 상품에 대한 반복 처리
                ForEach(favoriteProducts) { product in
                    // 상품 상세 페이지로의 네비게이션 링크
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        self.eachProduct(product)
                    }
                }
            }
        }
        // 스프링 효과가 있는 애니메이션 적용
        .animation(.spring(dampingFraction: 0.78))
    }
    
    /// 개별 상품을 표시하는 뷰를 생성하는 메서드
    /// - Parameter product: 표시할 상품 정보
    func eachProduct(_ product: Product) -> some View {
        // 뷰의 기하학적 정보를 얻기 위한 GeometryReader 사용
        GeometryReader { g in
            VStack {
                // 상품 이미지를 원형으로 표시
                ResizedImage(product.imageName, renderingMode: .original)
                    .clipShape(Circle())
                    .frame(width: 90, height: 90)
                    // 스크롤 위치에 따른 크기 조절 효과
                    .scaleEffect(self.scaledValue(from: g))
            }
            // iOS 버전 차이를 고려한 위치 조정
            .position(x: g.size.width / 2, y: g.size.height / 2)
        }
        .frame(width: 105, height: 105)
    }
    
    // MARK: Helper Methods
    
    /// 스크롤 위치에 따른 크기 조절 값을 계산하는 메서드
    /// - Parameter geometry: 뷰의 기하학적 정보
    /// - Returns: 계산된 크기 배율
    func scaledValue(from geometry: GeometryProxy) -> CGFloat {
        let xOffset = geometry.frame(in: .global).minX - 16
        let minSize: CGFloat = 0.9    // 최소 크기
        let maxSize: CGFloat = 1.1    // 최대 크기
        let delta: CGFloat = maxSize - minSize    // 크기 범위
        // 스크롤 위치에 따른 크기 계산
        let size = minSize + delta * (1 - xOffset / UIScreen.main.bounds.width)
        // 최소/최대 범위 내로 제한
        return max(min(size, maxSize), minSize)
    }
}

// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct FavoriteProductScrollView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 이미지 표시 상태의 프리뷰
            FavoriteProductScrollView(showingImage: .constant(true))
            // 이미지 숨김 상태의 프리뷰
            FavoriteProductScrollView(showingImage: .constant(false))
        }
        .environmentObject(Store())
    }
}
