//
//  OrderListView.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/03.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 사용자의 전체 주문 내역을 목록으로 표시하는 뷰를 구현합니다.
 - 주문 목록 표시 및 관리
 - 주문 삭제 및 순서 변경 기능
 - 빈 주문 목록 상태 처리
 
 [주요 기능]
 - 주문 목록의 CRUD 기능
 - 스와이프로 주문 삭제
 - 드래그 앤 드롭으로 순서 변경
 - 빈 상태 UI 처리
*/

import SwiftUI

/// 주문 목록을 표시하고 관리하는 뷰 구조체
struct OrderListView: View {
    /// 앱의 상태를 관리하는 환경 객체
    @EnvironmentObject var store: Store
    
    // MARK: - View Body
    
    var body: some View {
        // 주문 유무에 따른 조건부 뷰 표시
        ZStack {
            // 주문이 없을 경우 빈 상태 표시
            if store.orders.isEmpty {
                emptyOrders
            } else {
                // 주문이 있을 경우 목록 표시
                orderList
            }
        }
        // 네비게이션 바 타이틀 설정
        .navigationBarTitle("주문 목록")
        // 편집 버튼 추가
        .navigationBarItems(trailing: editButton)
    }
}


private extension OrderListView {
    // MARK: View Components
    
    /// 주문 목록을 표시하는 리스트 뷰
    var orderList: some View {
        List {
            // 각 주문을 행으로 표시
            ForEach(store.orders) {
                OrderRow(order: $0)
            }
            // 스와이프로 삭제 기능 추가
            .onDelete { indexes in
                withAnimation {
                    store.deleteOrder(at: indexes)
                }
            }
            // 드래그 앤 드롭으로 순서 변경 기능 추가
            .onMove(perform: store.moveOrder(from:to:))
        }
    }
    
    /// 주문이 없을 때 표시되는 빈 상태 뷰
    var emptyOrders: some View {
        VStack(spacing: 25) {
            // 빈 상자 이미지
            Image("box")
                .renderingMode(.template)
                .foregroundColor(Color.gray.opacity(0.4))
            
            // 안내 메시지
            Text("주문 내역이 없습니다")
                .font(.headline).fontWeight(.medium)
        }
        // 전체 화면 크기로 확장
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // 배경색 설정
        .background(Color.background)
    }
    
    /// 편집 버튼 뷰
    /// - 주문이 있을 때만 표시됨
    var editButton: some View {
        !store.orders.isEmpty
            ? AnyView(EditButton())    // 주문이 있을 때 편집 버튼 표시
            : AnyView(EmptyView())     // 주문이 없을 때 빈 뷰 표시
    }
}


// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        // 프리뷰 생성
        Preview(source: OrderListView())
    }
}
