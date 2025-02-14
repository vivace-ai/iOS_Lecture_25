//
//  OrderRow.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/03.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 주문 목록에서 각 주문 항목을 표시하는 행(row) 뷰를 구현합니다.
 - 주문한 상품의 이미지, 이름, 가격, 수량 표시
 - 주문 정보를 일관된 레이아웃으로 표현
 - 리스트 형태의 주문 내역에서 사용
 
 [주요 기능]
 - 주문 정보 레이아웃 구성
 - 원형 상품 이미지 표시
 - 주문 상세 정보 포맷팅
*/

import SwiftUI

/// 주문 목록의 각 행을 표시하는 뷰 구조체
struct OrderRow: View {
    /// 표시할 주문 정보를 담은 Order 객체
    let order: Order
    
    // MARK: - View Body
    
    var body: some View {
        // 주문 정보를 가로로 배치
        HStack {
            // 상품 이미지 표시
            ResizedImage(order.product.imageName)
                // 이미지 크기 설정
                .frame(width: 60, height: 60)
                // 원형으로 이미지 클리핑
                .clipShape(Circle())
                // 여백 추가
                .padding()
            
            // 주문 상세 정보를 수직으로 배치
            VStack(alignment: .leading, spacing: 10) {
                // 상품 이름
                Text(order.product.name)
                    .font(.headline).fontWeight(.medium)
                
                // 가격과 수량 정보
                Text("₩\(order.price)  |  \(order.quantity)개")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        // 전체 행의 높이 설정
        .frame(height: 100)
    }
}


// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        // 샘플 데이터를 사용하여 주문 목록 프리뷰
        List(productSamples.indices) { index in
            // 각 상품에 대한 주문 행 생성
            OrderRow(order:
                Order(id: index,                           // 주문 ID
                     product: productSamples[index],       // 주문한 상품
                     quantity: (1...9).randomElement()!))  // 랜덤 수량
        }
    }
}
