//
//  BundleExtension.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

// MARK: - Bundle Extension for JSON Decoding
/// Bundle 클래스에 JSON 파일 디코딩 기능을 추가하는 확장
extension Bundle {
  /// JSON 파일을 지정된 타입으로 디코딩하는 메서드
  /// - Parameters:
  ///   - filename: 디코딩할 JSON 파일의 이름
  ///   - type: 디코딩할 모델 타입 (Decodable 프로토콜을 준수해야 함)
  /// - Returns: 디코딩된 모델 인스턴스
  /// - Throws: 파일이 없거나, 데이터를 읽을 수 없거나, 디코딩에 실패할 경우 fatalError 발생
  func decode<T: Decodable>(filename: String, as type: T.Type) -> T {
    // 1. JSON 파일의 URL을 가져옴
    guard let url = self.url(forResource: filename, withExtension: nil) else {
      fatalError("번들에 \(filename)이 없습니다.")
    }
    
    // 2. URL로부터 데이터를 로드
    guard let data = try? Data(contentsOf: url) else {
      fatalError("\(url)로부터 데이터를 불러올 수 없습니다.")
    }
    
    // 3. JSON 데이터를 지정된 타입으로 디코딩
    guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
      fatalError("데이터 복호화에 실패했습니다.")
    }
    
    // 4. 디코딩된 데이터 반환
    return decodedData
  }
}
