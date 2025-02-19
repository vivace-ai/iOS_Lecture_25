//
//  CollectionViewController.swift
//  TableViewCollectionViewDemo
//
//  Created by 김영희 25-02-18.
//

import Foundation
import UIKit

// 이 컨트롤러는 그리드 형식으로 아이템 컬렉션을 표시하는 역할을 담당합니다.
// SF 심볼 아이콘들을 컬렉션 뷰에 표시하며, 각 셀은 핑크색 아이콘을 보여줍니다.
class CollectionViewController: UIViewController, UICollectionViewDataSource{
  
    // 컬렉션 뷰 셀에 표시할 SF 심볼 배열
    let items = ["star.fill", "moon.fill", "flag.fill","bell.fill"]
    
    // 뷰가 로드될 때 호출되며, 컬렉션 뷰의 데이터 소스를 설정합니다
    override func viewDidLoad() {
        super.viewDidLoad()
        // 설정 코드 위치
        collectionView.dataSource = self // 컬렉션 뷰의 데이터 소스를 self로 설정
    }
    
    // 스토리보드에서 연결된 UICollectionView 아웃렛
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 섹션 내 아이템 개수를 반환 (배열의 개수 기준)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // 컬렉션 뷰의 각 셀을 SF 심볼 이미지로 구성하고 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        // 셀 내부의 이미지 뷰를 가져와서 SF 심볼 이미지 설정
        if let imageView = cell.contentView.subviews.first as? UIImageView {
            // 현재 인덱스에 해당하는 SF 심볼 이미지 설정
            imageView.image = UIImage(systemName: items[indexPath.row])
            // 이미지 뷰 프레임 설정
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            // 심볼 색상을 시스템 핑크로 설정
            imageView.tintColor = .systemPink
        }
        
        return cell
    }
}
