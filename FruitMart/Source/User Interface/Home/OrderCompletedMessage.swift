//
//  OrderCompletedMessage.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 상품 주문이 완료되었을 때 표시되는 메시지 뷰를 구현합니다.
 - 주문 완료 메시지 표시
 - 팝업 형태로 표시되는 알림
 - 타이포그래피 스타일링
 
 [주요 기능]
 - 간단한 완료 메시지 표시
 - 글자 간격과 크기 조정
 - 팝업 형태의 메시지 출력
*/

import SwiftUI

/// 주문 완료 메시지를 표시하는 뷰 구조체
struct OrderCompletedMessage: View {
    // MARK: - View Body
    
    var body: some View {
        // 주문 완료 메시지 텍스트
        Text("주문 완료!")
            // 시스템 폰트 크기 설정
            .font(.system(size: 24))
            // 볼드체 적용
            .bold()
            // 글자 간격 설정
            .kerning(2)
    }
}


// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct OrderCompletedMessage_Previews: PreviewProvider {
    static var previews: some View {
        // 현재 테마의 반전 색상을 배경으로 사용
        Color.primary.colorInvert()
            // 팝업 형태로 메시지 표시
            .popup(isPresented: .constant(true)) { OrderCompletedMessage() }
            // 수직 방향의 SafeArea 무시
            .edgesIgnoringSafeArea(.vertical)
    }
}
