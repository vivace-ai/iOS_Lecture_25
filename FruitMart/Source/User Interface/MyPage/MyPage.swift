//
//  MyPage.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/03.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 사용자의 프로필과 앱 설정을 관리하는 마이페이지 화면을 구현합니다.
 - 사용자 프로필 이미지와 닉네임 관리
 - 주문 내역 확인 기능
 - 앱 설정 (즐겨찾기 목록, 상품 이미지 높이) 관리
 
 [주요 기능]
 - 프로필 이미지 선택 및 변경
 - 닉네임 입력 및 수정
 - 주문 목록 확인
 - 앱 설정 커스터마이징
*/

// SwiftUI 프레임워크 임포트
import SwiftUI

/// 마이페이지 화면을 구성하는 메인 뷰 구조체
struct MyPage: View {
    // MARK: - Properties
    
    /// Store 객체를 환경 객체로 주입받아 앱의 상태 관리
    @EnvironmentObject var store: Store
    
    /// 기본 프로필 이미지로 시스템 심볼 사용
    @State private var pickedImage: Image = Image(systemName: "person.crop.circle")
    
    /// 이미지 피커 시트의 표시 여부를 제어하는 상태 변수
    @State private var isPickerPresented: Bool = false
    
    /// 사용자가 입력한 닉네임을 저장하는 상태 변수
    @State private var nickname: String = ""
    
    /// 상품 이미지 높이 선택을 위한 옵션 배열 (140pt, 150pt, 160pt)
    private let pickerDataSource: [CGFloat] = [140, 150, 160]
    
    // MARK: - View Body
    
    var body: some View {
        // 네비게이션 기능을 위한 컨테이너
        NavigationView {
            // 수직 방향으로 컨텐츠 스택
            VStack {
                // 프로필 이미지와 닉네임을 포함하는 상단 영역
                userInfo
                
                // iOS 14.0에서 Form의 기본 스타일이 InsetGroupedListStyle로 조정됨
                Form {
                    // 주문 관련 정보를 포함하는 섹션
                    orderInfoSection
                    // 앱 설정 관련 옵션을 포함하는 섹션
                    appSettingSection
                }
            }
            // 네비게이션 바 타이틀 설정
            .navigationBarTitle("마이 페이지")
        }
        // 이미지 선택을 위한 시트 표시
        .sheet(isPresented: $isPickerPresented) {
            // 이미지 피커 뷰 표시 및 선택된 이미지 바인딩
            ImagePickerView(pickedImage: self.$pickedImage)
        }
    }
}

// MARK: - Private Extensions
private extension MyPage {
    // MARK: View Components
    
    /// 사용자 프로필 정보를 표시하는 상단 영역 뷰
    var userInfo: some View {
        // 프로필 이미지와 닉네임을 수직으로 배치
        VStack {
            profileImage       // 프로필 이미지 컴포넌트
            nicknameTextField // 닉네임 입력 필드
        }
        // 뷰의 크기 설정
        .frame(maxWidth: .infinity, minHeight: 200)
        // 배경색 설정
        .background(Color.background)
    }
    
    /// 원형 프로필 이미지를 표시하는 뷰
    var profileImage: some View {
        pickedImage
            // 이미지 크기 조정
            .resizable().scaledToFill()
            // 원형으로 클리핑
            .clipShape(Circle())
            // 이미지 크기 고정
            .frame(width: 100, height: 100)
            // 우측 하단에 이미지 선택 버튼 오버레이
            .overlay(pickImageButton.offset(x: 8, y: 0), alignment: .bottomTrailing)
    }
    
    /// 이미지 선택 버튼 뷰
    var pickImageButton: some View {
        Button(action: {
            // 버튼 탭 시 이미지 피커 표시
            self.isPickerPresented = true
        }) {
            // 원형 버튼 디자인
            Circle()
                .fill(Color.white)
                // 그림자 효과
                .shadow(color: .primaryShadow, radius: 2, x: 2, y: 2)
                // 연필 아이콘 오버레이
                .overlay(Image("pencil").foregroundColor(.black))
                // 버튼 크기 설정
                .frame(width: 32, height: 32)
        }
    }
    
    /// 닉네임 입력을 위한 텍스트 필드
    var nicknameTextField: some View {
        TextField("닉네임", text: $nickname)
            // 폰트 설정
            .font(.system(size: 25, weight: .medium))
            // 키보드 타입 설정
            .textContentType(.nickname)
            // 중앙 정렬
            .multilineTextAlignment(.center)
            // 자동 대문자 변환 비활성화
            .autocapitalization(.none)
    }
    
    /// 주문 정보를 표시하는 섹션
    var orderInfoSection: some View {
        Section(header: Text("주문 정보").fontWeight(.medium)) {
            // 주문 목록 화면으로 이동하는 네비게이션 링크
            NavigationLink(destination: OrderListView()) {
                Text("주문 목록")
            }
            // 높이 설정
            .frame(height: 44)
        }
    }
    
    /// 앱 설정 옵션을 포함하는 섹션
    var appSettingSection: some View {
        Section(header: Text("앱 설정").fontWeight(.medium)) {
            // 즐겨찾기 목록 표시 여부 토글
            Toggle("즐겨찾는 상품 표시", isOn: $store.appSetting.showFavoriteList)
                .frame(height: 44)
            
            // 상품 이미지 높이 선택 컴포넌트
            productHeightPicker
        }
    }
    
    /// 상품 이미지 높이 선택을 위한 세그먼트 피커
    var productHeightPicker: some View {
        VStack(alignment: .leading) {
            // 피커 제목
            Text("상품 이미지 높이 조절")
            
            // 세그먼트 스타일의 피커
            Picker("", selection: $store.appSetting.productRowHeight) {
                // 높이 옵션 생성
                ForEach(pickerDataSource, id: \.self) {
                    // 각 옵션의 레이블 설정
                    Text(String(format: "%.0f", $0)).tag($0)
                }
            }
            // 세그먼트 스타일 적용
            .pickerStyle(SegmentedPickerStyle())
        }
        // 전체 높이 설정
        .frame(height: 72)
    }
}

// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct MyPage_Previews : PreviewProvider {
    static var previews: some View {
        // 프리뷰 생성
        Preview(source: MyPage())
    }
}

