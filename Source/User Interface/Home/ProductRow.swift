//
//  ProductRow.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 상품 목록의 각 행(row)을 표시하는 뷰를 구현합니다.
 - 상품의 이미지, 이름, 설명, 가격을 포함한 행 레이아웃 구성
 - 상품별 즐겨찾기 기능과 장바구니 담기 기능 제공
 - 3D Touch/Force Touch를 통한 컨텍스트 메뉴 지원
 - 행 표시 시 페이드인 애니메이션 효과 적용
*/

import SwiftUI

// MARK: - ProductRow View
/// 상품 목록의 각 행을 구성하는 메인 뷰 구조체
struct ProductRow: View {
    // MARK: - Properties
    
    /// Store 객체를 환경 객체로 주입받아 상품 관련 동작 처리
    @EnvironmentObject var store: Store
    /// 현재 행에서 표시할 상품 정보를 담은 상수
    let product: Product
    /// 빠른 주문 기능을 위한 상품 상태를 부모 뷰와 공유하는 바인딩
    @Binding var quickOrder: Product?
    
    /// 행이 나타날 때 페이드인 효과를 위한 상태 값
    @State private var willAppear: Bool = false
    
    // MARK: - View Body
    
    var body: some View {
        // 상품 이미지와 설명을 가로로 배치
        HStack {
            productImage        // 좌측 상품 이미지
            productDescription  // 우측 상품 설명
        }
        // 앱 설정에서 지정된 행 높이 적용
        .frame(height: store.appSetting.productRowHeight)
        // 현재 테마의 반전 색상을 배경으로 사용
        .background(Color.primary.colorInvert())
        // 행의 모서리를 둥글게 처리
        .cornerRadius(6)
        // 그림자 효과 추가
        .shadow(color: .primaryShadow, radius: 1, x: 2, y: 2)
        // 행 간격 조정
        .padding(.vertical, 8)
        // 페이드인 애니메이션을 위한 투명도 설정
        .opacity(willAppear ? 1 : 0)
        // 부드러운 페이드인 효과를 위한 애니메이션 설정
        .animation(.easeInOut(duration: 0.4))
        // 뷰가 나타날 때 페이드인 시작
        .onAppear { self.willAppear = true }
        // 3D Touch/Force Touch 메뉴 추가
        .contextMenu { contextMenu }
    }
}

// MARK: - Private Extensions
private extension ProductRow {
    // MARK: View Components
    
    /// 상품 이미지를 표시하는 뷰 컴포넌트
    var productImage: some View {
        // 이미지 크기 조정 및 표시
        ResizedImage(product.imageName)
            .frame(width: 140)
            .clipped()
    }
    
    /// 상품 정보를 표시하는 우측 영역 뷰 컴포넌트
    var productDescription: some View {
        // 상품 정보를 세로로 배치
        VStack(alignment: .leading) {
            // 상품 이름
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            
            // 상품 설명
            Text(product.description)
                .font(.footnote)
                .foregroundColor(.secondaryText)
            
            Spacer()
            
            // 가격, 즐겨찾기, 장바구니 영역
            footerView
        }
        // 여백 설정
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }
    
    /// 행 하단의 가격과 버튼들을 포함하는 뷰 컴포넌트
    var footerView: some View {
        // 요소들을 가로로 배치
        HStack(spacing: 0) {
            // 가격 표시 (원화 기호 + 금액)
            Text("₩").font(.footnote)
                + Text("\(product.price)").font(.headline)
            
            Spacer()
            
            // 즐겨찾기 토글 버튼
            FavoriteButton(product: product)
            
            // 장바구니 담기 버튼
            Symbol("cart", color: .peach)
                .frame(width: 32, height: 32)
                .onTapGesture { self.orderProduct() }
        }
    }
    
    /// 3D Touch/Force Touch로 표시되는 컨텍스트 메뉴 뷰
    var contextMenu: some View {
        VStack {
            // 즐겨찾기 토글 버튼
            Button(action: { self.toggleFavorite() }) {
                Text("Toggle Favorite")
                Symbol(self.product.isFavorite ? "heart.fill" : "heart")
            }
            // 장바구니 담기 버튼
            Button(action: { self.orderProduct() }) {
                Text("Order Product")
                Symbol("cart")
            }
        }
    }
    
    // MARK: - Actions
    
    /// 상품을 장바구니에 추가하는 메서드
    /// - 빠른 주문 상태를 업데이트하고 스토어에 주문을 요청
    func orderProduct() {
        quickOrder = product
        store.placeOrder(product: product, quantity: 1)
    }
    
    /// 상품의 즐겨찾기 상태를 토글하는 메서드
    func toggleFavorite() {
        store.toggleFavorite(of: product)
    }
}

// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 샘플 데이터로 여러 행 미리보기
            ForEach(productSamples) {
                ProductRow(product: $0, quickOrder: .constant(nil))
            }
            // 다크 모드 미리보기
            ProductRow(product: productSamples[0], quickOrder: .constant(nil))
                .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
