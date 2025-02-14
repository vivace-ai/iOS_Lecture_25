//
//  QuantitySelector.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 상품의 주문 수량을 선택하는 컨트롤을 구현합니다.
 - 수량 증가/감소 버튼을 통한 수량 조절
 - 햅틱 피드백을 통한 사용자 경험 향상
 - 수량 범위 제한 및 유효성 검사
 
 [주요 기능]
 - 플러스/마이너스 버튼을 통한 수량 조절
 - 현재 선택된 수량 표시
 - 수량 변경 시 햅틱 피드백 제공
 - 최소/최대 수량 범위 검사
*/

import SwiftUI

/// 상품의 주문 수량을 선택하는 컨트롤 뷰
struct QuantitySelector: View {
    /// 선택된 수량을 저장하는 바인딩 변수
    @Binding var quantity: Int
    /// 선택 가능한 수량 범위 (기본값: 1-20)
    var range: ClosedRange<Int> = 1...20
    
    /// 일반적인 수량 변경 시 사용되는 햅틱 피드백 생성기
    private let softFeedback = UIImpactFeedbackGenerator(style: .soft)
    /// 범위 초과 시 사용되는 강한 햅틱 피드백 생성기
    private let rigidFeedback = UIImpactFeedbackGenerator(style: .rigid)
    
    // MARK: - View Body
    
    var body: some View {
        // 수량 조절 버튼들을 가로로 배치
        HStack {
            // 감소 버튼
            Button(action: { self.changeQuantity(-1) }) {
                Symbol("minus.circle.fill", scale: .large, color: Color.gray.opacity(0.5))
                    .padding()
            }
            
            // 현재 수량 표시
            Text("\(quantity)")
                .bold()
                .font(Font.system(.title, design: .monospaced))
                .frame(minWidth: 40, maxWidth: 60)
            
            // 증가 버튼
            Button(action: { self.changeQuantity(1) }) {
                Symbol("plus.circle.fill", scale: .large, color: Color.gray.opacity(0.5))
                    .padding()
            }
        }
    }
    
    // MARK: - Actions
    
    /// 수량을 변경하고 햅틱 피드백을 제공하는 메서드
    /// - Parameter num: 변경할 수량 (+1 또는 -1)
    private func changeQuantity(_ num: Int) {
        // 변경된 수량이 허용 범위 내인지 확인
        if range ~= quantity + num {
            // 수량 변경
            quantity += num
            // 부드러운 햅틱 피드백 준비 및 실행
            softFeedback.prepare()
            softFeedback.impactOccurred(intensity: 0.8)
        } else {
            // 범위 초과 시 강한 햅틱 피드백 준비 및 실행
            rigidFeedback.prepare()
            rigidFeedback.impactOccurred()
        }
    }
}


// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct QuantitySelector_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            // 최소 수량 상태의 프리뷰
            QuantitySelector(quantity: .constant(1))
            // 중간 수량 상태의 프리뷰
            QuantitySelector(quantity: .constant(10))
            // 최대 수량 상태의 프리뷰
            QuantitySelector(quantity: .constant(20))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
