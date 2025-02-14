//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 상품의 상세 정보를 표시하는 뷰를 구현합니다.
 - 상품의 대형 이미지 표시
 - 상품 이름, 설명, 가격 정보 표시
 - 주문 수량 선택 및 주문 기능
 - 즐겨찾기 토글 기능
 
 [주요 기능]
 - 애니메이션을 통한 이미지 로딩 효과
 - 주문 수량 선택 및 가격 계산
 - 주문 확인 알림 및 완료 팝업
 - SafeArea 및 그림자 효과 처리
*/

import SwiftUI

/// 상품의 상세 정보를 표시하는 뷰 구조체
struct ProductDetailView: View {
    /// 스토어 데이터를 관리하는 환경 객체
    @EnvironmentObject private var store: Store
    /// 표시할 상품 정보
    let product: Product
    
    /// 주문 수량을 관리하는 상태 값
    @State private var quantity: Int = 1
    /// 주문 확인 알림 표시 상태
    @State private var showingAlert: Bool = false
    /// 주문 완료 팝업 표시 상태
    @State private var showingPopup: Bool = false
    /// 뷰 표시 애니메이션을 위한 상태 값
    @State private var willAppear: Bool = false
    
    // MARK: - View Body
    
    var body: some View {
        // 수직 스택으로 이미지와 주문 영역 배치
        VStack(spacing: 0) {
            // 애니메이션 효과와 함께 이미지 표시
            if willAppear {
                productImage
            }
            orderView
        }
        // 주문 완료 팝업 표시
        .popup(isPresented: $showingPopup) { OrderCompletedMessage() }
        // 상단 SafeArea 무시
        .edgesIgnoringSafeArea(.top)
        // 주문 확인 알림 표시
        .alert(isPresented: $showingAlert) { confirmAlert }
        // 뷰가 나타날 때 애니메이션 시작
        .onAppear { self.willAppear = true }
    }
}


private extension ProductDetailView {
    // MARK: View Components
    
    /// 상품 이미지를 표시하는 뷰
    var productImage: some View {
        // 크기 조절과 투명도 애니메이션 효과 설정
        let effect = AnyTransition.scale.combined(with: .opacity)
            .animation(Animation.easeInOut(duration: 0.4).delay(0.05))
        return GeometryReader { _ in
            ResizedImage(self.product.imageName)
        }
        .transition(effect)
    }
    
    /// 주문 관련 정보를 표시하는 뷰
    var orderView: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                self.productDescription  // 상품 설명
                Spacer()
                self.priceInfo          // 가격 정보
                self.placeOrderButton   // 주문 버튼
            }
            // 여백 설정
            .padding(32)
            // 높이 설정
            .frame(height: $0.size.height + 10)
            // 배경색 설정
            .background(Color.white)
            // 모서리 둥글게 처리
            .cornerRadius(16)
            // 그림자 효과
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        }
    }

    /// 상품 설명을 표시하는 뷰
    var productDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                // 상품 이름
                Text(product.name)
                    .font(.largeTitle).fontWeight(.medium)
                    .foregroundColor(.black)
                
                Spacer()
                
                // 즐겨찾기 버튼
                FavoriteButton(product: product)
            }
            
            // 상품 설명 (두 줄로 나누어 표시)
            Text(splitText(product.description))
                .foregroundColor(.secondaryText)
                .fixedSize()
        }
    }
    
    /// 가격 정보와 수량 선택을 표시하는 뷰
    var priceInfo: some View {
        let price = quantity * product.price
        return HStack {
            // 가격 표시
            (Text("₩")
                + Text("\(price)").font(.title)
            ).fontWeight(.medium)
            Spacer()
            // 수량 선택기
            QuantitySelector(quantity: $quantity)
        }
        .foregroundColor(.black)
    }
    
    /// 주문하기 버튼 뷰
    var placeOrderButton: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            Capsule()
                .fill(Color.peach)
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                .overlay(Text("주문하기")
                    .font(.system(size: 20)).fontWeight(.medium)
                    .foregroundColor(Color.white))
                .padding(.vertical, 8)
        }
        .buttonStyle(ShrinkButtonStyle())
    }
    
    /// 주문 확인 알림
    var confirmAlert: Alert {
        Alert(
            title: Text("주문 확인"),
            message: Text("\(product.name)을(를) \(quantity)개 구매하시겠습니까?"),
            primaryButton: .default(Text("확인"), action: {
                self.placeOrder()
            }),
            secondaryButton: .cancel(Text("취소"))
        )
    }
    
    // MARK: Helper Methods
    
    /// 상품 설명 텍스트를 두 줄로 나누는 메서드
    /// - Parameter text: 원본 텍스트
    /// - Returns: 줄바꿈이 추가된 텍스트
    func splitText(_ text: String) -> String {
        guard !text.isEmpty else { return text }
        // 텍스트의 중간 지점 찾기
        let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
        // 중간 지점 근처의 공백 찾기
        let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ")
            ?? text[centerIdx...].firstIndex(of: " ")
            ?? text.index(before: text.endIndex)
        let afterSpaceIdx = text.index(after: centerSpaceIdx)
        // 텍스트 분할 및 공백 제거
        let lhsString = text[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
        let rhsString = text[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)
        // 줄바꿈으로 연결
        return String(lhsString + "\n" + rhsString)
    }
    
    // MARK: Actions
    
    /// 주문 처리 메서드
    func placeOrder() {
        // 스토어에 주문 요청
        store.placeOrder(product: product, quantity: quantity)
        // 완료 팝업 표시
        showingPopup = true
    }
}


// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let source1 = ProductDetailView(product: productSamples[0])
        let source2 = ProductDetailView(product: productSamples[1])
        return Group {
            Preview(source: source1)
            Preview(source: source2, devices: [.iPhone11Pro], displayDarkMode: false)
        }
    }
}
