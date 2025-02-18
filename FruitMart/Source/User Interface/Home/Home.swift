//
//  Home.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 과일마트 앱의 메인 홈 화면을 구현하는 뷰입니다.
 - 즐겨찾기한 상품 목록 표시
 - 전체 상품 목록 표시
 - 상품 빠른 주문 기능
 - 상품 상세 페이지 연결
 
 [주요 기능]
 - NavigationView를 통한 화면 구성
 - 즐겨찾기 상품 가로 스크롤 뷰
 - 전체 상품 리스트 뷰
 - 팝업 형태의 빠른 주문 기능
 - 상품 상세 페이지 네비게이션
*/

import SwiftUI

// MARK: - Home View
/// 앱의 메인 홈 화면을 구성하는 뷰 구조체
struct Home: View {
  // MARK: Properties
  
  /// 앱의 상태를 관리하는 환경 객체
  @EnvironmentObject private var store: Store
  
  /// 빠른 주문을 위한 상품 상태 값
  @State private var quickOrder: Product?
  /// 즐겨찾기 이미지 표시 여부 상태
  @State private var showingFavoriteImage: Bool = true
  
  // MARK: Body
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        if showFavorite {
          favoriteProducts
        }
        darkerDivider
        productList
      }
      .navigationBarTitle("과일마트")
    }
    .popupOverContext(item: $quickOrder, style: .blur, content: popupMessage(product:))
  }
}


private extension Home {
  // MARK: View Components
  
  /// 즐겨찾기한 상품들을 가로 스크롤로 표시하는 뷰
  var favoriteProducts: some View {
    FavoriteProductScrollView(showingImage: $showingFavoriteImage)
      .padding(.top, 24)
      .padding(.bottom, 8)
  }
  
  /// 섹션 구분을 위한 구분선 뷰
  var darkerDivider: some View {
    Color.primary
      .opacity(0.3)
      .frame(maxWidth: .infinity, maxHeight: 1)
  }
  
  /// 전체 상품 목록을 표시하는 리스트 뷰
  /// - List: 상품 목록을 표시하는 기본 컨테이너
  /// - NavigationLink: 상품 상세 페이지로의 이동을 처리
  var productList: some View {
    List {
      ForEach(store.products) { product in
        // iOS 13에서 디스클로저 인디케이터를 제거하기 위한 임시 방편이
        // iOS 14에서 동작하지 않으므로 관련 코드 제거
        NavigationLink(destination: ProductDetailView(product: product)) {
          ProductRow(product: product, quickOrder: $quickOrder)
        }
      }
      .listRowBackground(Color.background)
    }
    // iOS 14.0에서는 NavigationView - VStack - List일 때 SidebarListStyle이 기본값
    // iOS 13의 기본값이었던 PlainListStyle로 수정
    .listStyle(PlainListStyle())
    .background(Color.background)
  }
  
  /// 빠른 주문 완료 시 표시되는 팝업 메시지 뷰
  /// - Parameter product: 주문한 상품 정보
  func popupMessage(product: Product) -> some View {
    let name = product.name.split(separator: " ").last!
    return VStack {
      Text(name)
        .font(.title).bold().kerning(3)
        .foregroundColor(.peach)
        .padding()
      
      OrderCompletedMessage()
    }
  }
  
  // MARK: Computed Properties
  
  /// 즐겨찾기 목록 표시 여부를 결정하는 계산 속성
  /// - Returns: 즐겨찾기한 상품이 있고, 앱 설정에서 표시가 활성화된 경우 true
  var showFavorite: Bool {
    !store.products.filter ({ $0.isFavorite }).isEmpty
      && store.appSetting.showFavoriteList
  }
}

// MARK: - Preview
/// SwiftUI 프리뷰 제공
struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Preview(source: Home())
      .environmentObject(Store())
  }
}
