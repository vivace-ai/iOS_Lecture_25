//
//  ViewController.swift
//  TableViewCollectionViewDemo
//
//  Created by Kim Young Hee 25-02-18.
//
//  이 뷰 컨트롤러는 할 일 목록을 테이블 뷰로 표시하는 화면을 관리합니다.
//  사용자에게 할 일 항목들을 리스트 형태로 보여주며, UITableViewDataSource 프로토콜을 
//  구현하여 데이터를 표시합니다.

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
 
    // 할 일 목록 항목들을 저장하는 배열
    let toDoItems = ["Buy Groceries", "Go to the Gym", "Play with the cat", "Read a book", "Practice Coding"]
    
    // 스토리보드에서 연결된 테이블뷰 아웃렛
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 뷰가 로드된 후 추가 설정
        tableView.dataSource = self
    }

    // 섹션 내 행의 개수를 반환 (toDoItems 배열의 개수 기준)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    // 각 행에 표시될 셀을 구성하고 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = toDoItems[indexPath.row]
        return cell
    }
}

