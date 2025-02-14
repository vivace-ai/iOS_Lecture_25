//
//  Store.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 과일마트 앱의 전체 상태와 데이터를 관리하는 중앙 저장소를 구현합니다.
 - 앱 설정, 상품 목록, 주문 내역 관리
 - 데이터의 영구 저장 및 로드
 - 상태 변경에 따른 UI 업데이트 처리
 
 [주요 기능]
 - 앱 상태 관리 및 데이터 CRUD
 - JSON 파일 기반 데이터 저장/로드
 - 주문 처리 및 관리
 - 즐겨찾기 기능 처리
 
 [데이터 흐름]
 1. 앱 시작 시 JSON 파일에서 상품 데이터 로드
 2. 사용자 조작에 따른 상태 업데이트
 3. 주문 데이터 변경 시 자동 저장
*/

import Foundation

/// 앱의 전체 상태를 관리하는 옵저버블 클래스
/// ObservableObject를 채택하여 상태 변화를 SwiftUI 뷰에 자동으로 알림
final class Store: ObservableObject {
    /// 앱 설정 상태를 관리하는 게시된 프로퍼티
    /// @Published를 사용하여 값 변경 시 자동으로 뷰 업데이트
    @Published var appSetting: AppSetting
    
    /// 전체 상품 목록을 관리하는 게시된 프로퍼티
    /// ProductData.json 파일에서 초기 데이터 로드
    @Published var products: [Product]
    
    /// 주문 목록을 관리하고 자동 저장하는 게시된 프로퍼티
    /// didSet을 사용하여 값이 변경될 때마다 JSON 파일로 자동 저장
    @Published var orders: [Order] = [] {
        didSet { saveData(at: ordersFilePath, data: orders) }
    }
    
    // MARK: - Initialization
    
    /// Store 초기화 및 데이터 로드
    /// - Parameters:
    ///   - filename: 상품 데이터 파일 이름
    ///   - appSetting: 앱 설정 초기값
    init(
        filename: String = "ProductData.json",
        appSetting: AppSetting = AppSetting()
    ) {
        // 번들에서 상품 데이터 파일을 디코딩하여 로드
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
        self.appSetting = appSetting
        
        // 저장된 주문 데이터 로드
        self.orders = loadData(at: ordersFilePath, type: [Order].self)
    }
}

// MARK: - Actions

extension Store {
    /// 상품의 즐겨찾기 상태를 토글하는 메서드
    /// - Parameter product: 토글할 상품
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        products[index].isFavorite.toggle()
    }
    
    /// 새로운 주문을 생성하는 메서드
    /// - Parameters:
    ///   - product: 주문할 상품
    ///   - quantity: 주문 수량
    func placeOrder(product: Product, quantity: Int) {
        let nextID = Order.orderSequence.next()!
        let order = Order(id: nextID, product: product, quantity: quantity)
        orders.append(order)
        Order.lastOrderID = nextID
    }
    
    /// 주문을 삭제하는 메서드
    /// - Parameter indexes: 삭제할 주문의 인덱스 집합
    func deleteOrder(at indexes: IndexSet) {
        guard let index = indexes.first else { return }
        orders.remove(at: index)
    }
    
    /// 주문의 순서를 변경하는 메서드
    /// - Parameters:
    ///   - indexes: 이동할 주문의 인덱스 집합
    ///   - destination: 이동 목적지 인덱스
    func moveOrder(from indexes: IndexSet, to destination: Int) {
        orders.move(fromOffsets: indexes, toOffset: destination)
    }
}

// MARK: - File Handling

private extension Store {
    /// 주문 데이터 파일의 저장 경로를 계산하는 계산 프로퍼티
    var ordersFilePath: URL {
        let manager = FileManager.default
        // 앱 지원 디렉토리 경로 획득
        let appSupportDir = manager.urls(for: .applicationSupportDirectory,
                                       in: .userDomainMask).first!
        let bundleID = Bundle.main.bundleIdentifier ?? "FruitMart"
        
        // 앱 전용 디렉토리 경로 생성
        let appDir = appSupportDir
            .appendingPathComponent(bundleID, isDirectory: true)
        
        // 디렉토리가 없으면 생성
        if !manager.fileExists(atPath: appDir.path) {
            try? manager.createDirectory(at: appDir,
                                      withIntermediateDirectories: true)
        }
        
        // 주문 데이터 파일 전체 경로 반환
        return appDir
            .appendingPathComponent("Orders")
            .appendingPathExtension("json")
    }
    
    /// 데이터를 JSON 형식으로 저장하는 제네릭 메서드
    /// - Parameters:
    ///   - path: 저장할 파일 경로
    ///   - data: 저장할 데이터
    func saveData<T>(at path: URL, data: T) where T: Encodable {
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: path)
        } catch {
            print(error)
        }
    }
    
    /// JSON 파일에서 데이터를 로드하는 제네릭 메서드
    /// - Parameters:
    ///   - path: 로드할 파일 경로
    ///   - type: 디코딩할 데이터 타입
    /// - Returns: 디코딩된 데이터 배열 또는 빈 배열
    func loadData<T>(at path: URL, type: [T].Type) -> [T] where T: Decodable {
        do {
            let data = try Data(contentsOf: path)
            let decodedData = try JSONDecoder().decode(type, from: data)
            return decodedData
        } catch {
            return []
        }
    }
}
