//
//  ImagePickerView.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/03.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 사용자가 프로필 이미지를 선택할 수 있는 이미지 피커 인터페이스를 구현합니다.
 - UIKit의 UIImagePickerController를 SwiftUI에서 사용하기 위한 래퍼
 - 사진 라이브러리 접근 및 이미지 선택 기능
 - 선택된 이미지 편집 기능
 
 [주요 기능]
 - 시스템 이미지 피커 표시
 - 이미지 선택 및 편집
 - 선택된 이미지 데이터 처리
*/

// SwiftUI와 UIKit 프레임워크 임포트
import SwiftUI
import UIKit

/// UIImagePickerController를 SwiftUI에서 사용하기 위한 래퍼 구조체
struct ImagePickerView: UIViewControllerRepresentable {
    /// 선택된 이미지를 저장할 바인딩 변수
    @Binding var pickedImage: Image
    
    /// UIImagePickerController 인스턴스 생성 및 설정
    /// - Parameter context: 컨텍스트 정보를 포함하는 Context 객체
    /// - Returns: 구성된 UIImagePickerController 인스턴스
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // 이미지 피커 컨트롤러 인스턴스 생성
        let imagePickerController = UIImagePickerController()
        // 델리게이트 설정
        imagePickerController.delegate = context.coordinator
        // 이미지 편집 허용
        imagePickerController.allowsEditing = true
        return imagePickerController
    }
    
    /// 뷰 컨트롤러 업데이트 (변경 사항 없음)
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    /// Coordinator 클래스 정의 - 델리게이트 패턴 구현을 위한 클래스
    final class Coordinator: NSObject {
        /// ImagePickerView에 대한 참조
        let parent: ImagePickerView
        
        /// 초기화 메서드
        /// - Parameter imagePickerView: 부모 ImagePickerView 인스턴스
        init(_ imagePickerView: ImagePickerView) {
            self.parent = imagePickerView
        }
    }
    
    /// Coordinator 인스턴스 생성
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


// MARK: - Delegate Methods

/// UIImagePickerController 델리게이트 메서드 구현
extension ImagePickerView.Coordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /// 이미지 선택 완료 시 호출되는 메서드
    /// - Parameters:
    ///   - picker: 이미지 피커 컨트롤러 인스턴스
    ///   - info: 선택된 이미지 정보를 포함하는 딕셔너리
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        // 원본 이미지 가져오기
        let originalImage = info[.originalImage] as! UIImage
        // 편집된 이미지가 있다면 가져오기
        let editedImage = info[.editedImage] as? UIImage
        // 편집된 이미지가 있으면 사용하고, 없으면 원본 이미지 사용
        let selectedImage = editedImage ?? originalImage
        // 선택된 이미지를 SwiftUI Image로 변환하여 저장
        parent.pickedImage = Image(uiImage: selectedImage)
        // 이미지 피커 닫기
        picker.dismiss(animated: true)
    }
}
