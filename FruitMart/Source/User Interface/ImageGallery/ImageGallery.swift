//
//  ImageGallery.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 과일 이미지들을 카드 형태의 갤러리로 표시하는 뷰를 구현합니다.
 - 카드 스택 형태의 이미지 갤러리 표시
 - 드래그 제스처를 통한 카드 조작
 - 카드 간격, 크기, 각도 조절 기능
 
 [주요 기능]
 - 스택 형태의 카드 레이아웃
 - 드래그 제스처 인터랙션
 - 카드 애니메이션 효과
 - 갤러리 커스터마이징 컨트롤
*/

import SwiftUI

/// 이미지 갤러리를 구성하는 메인 뷰 구조체
struct ImageGallery: View {
    /// 전체 상품 이미지 목록을 저장하는 정적 배열
    static private let galleryImages: [String] = Store().products.map { $0.imageName }
    /// 현재 표시 중인 이미지 배열
    @State private var productImages: [String] = galleryImages
    /// 카드 간의 간격
    @State private var spacing: CGFloat = 20
    /// 카드 크기 조절 비율
    @State private var scale: CGFloat = 0.020
    /// 카드 회전 각도
    @State private var angle: CGFloat = 5
    /// 드래그 제스처의 현재 위치
    @GestureState private var translation: CGSize = .zero
    
    // MARK: - View Body
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                backgroundCards    // 뒷면 카드들
                frontCard         // 앞면 카드
            }
            Spacer()
            controller           // 컨트롤 패널
        }
        .edgesIgnoringSafeArea(.top)
    }
}


private extension ImageGallery {
    // MARK: View Components
    
    /// 최상단에 표시되는 카드 뷰
    var frontCard: some View {
        // 드래그 제스처 정의
        let dragGesture = DragGesture()
            .updating($translation) { (value, state, _) in
                state = value.translation
            }
        return FruitCard(productImages[0])
            .offset(translation)
            .shadow(color: .primaryShadow, radius: 4, x: 2, y: 2)
            // 길게 누르면 카드 순서 변경
            .onLongPressGesture(perform: {
                self.productImages.append(self.productImages.removeFirst())
            })
            .simultaneousGesture(dragGesture)
    }
    
    /// 뒤에 쌓여있는 카드들
    var backgroundCards: some View {
        ForEach(productImages.dropFirst().reversed(), id: \.self) {
            self.backgroundCard(image: $0)
        }
    }
    
    /// 개별 배경 카드 생성
    func backgroundCard(image: String) -> some View {
        let index = productImages.firstIndex(of: image)!
        let response = computeResponse(index: index)
        let animation = Animation.spring(response: response, dampingFraction: 0.68)
        return FruitCard(image)
            .shadow(color: .primaryShadow, radius: 2, x: 2, y: 2)
            .offset(computePosition(index: index))
            .scaleEffect(computeScale(index: index))
            .rotation3DEffect(computeAngle(index: index), axis: (0,0,1))
            .transition(AnyTransition.scale.animation(animation))
            .animation(animation)
    }
    
    /// 갤러리 컨트롤 패널
    var controller: some View {
        let titles = ["간격", "크기", "각도"]
        let values = [$spacing, $scale, $angle]
        let ranges: [ClosedRange<CGFloat>] = [1.0...40.0, 0...0.05, -90.0...90.0]
        
        return VStack {
            ForEach(titles.indices) { i in
                HStack {
                    Text(titles[i])
                        .font(.system(size: 17))
                        .frame(width: 80)
                    Slider(value: values[i], in: ranges[i])
                        .accentColor(Color.gray.opacity(0.25))
                }
            }
        }
        .padding()
    }
    
    // MARK: Helper Methods
    
    /// 카드의 위치 계산
    /// - Parameter index: 카드의 인덱스
    /// - Returns: 계산된 위치 값
    func computePosition(index: Int) -> CGSize {
        let x = translation.width
        let y = translation.height - CGFloat(index) * spacing
        return CGSize(width: x, height: y)
    }
    
    /// 카드의 크기 계산
    /// - Parameter index: 카드의 인덱스
    /// - Returns: 계산된 크기 비율
    func computeScale(index: Int) -> CGFloat {
        let cardScale = 1.0 - CGFloat(index) * (0.05 - scale)
        return max(cardScale, 0.1)
    }
    
    /// 카드의 회전 각도 계산
    /// - Parameter index: 카드의 인덱스
    /// - Returns: 계산된 회전 각도
    func computeAngle(index: Int) -> Angle {
        let degrees = Double(index) * Double(angle)
        return Angle(degrees: degrees)
    }
    
    /// 애니메이션 응답 시간 계산
    /// - Parameter index: 카드의 인덱스
    /// - Returns: 계산된 응답 시간
    func computeResponse(index: Int) -> Double {
        max(Double(index) * 0.04, 0.2)
    }
}


// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct ImageGallery_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: ImageGallery())
    }
}
