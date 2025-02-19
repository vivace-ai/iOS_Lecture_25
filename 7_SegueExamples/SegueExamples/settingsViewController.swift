//
//  SettingsViewController.swift
//  SegueExamples
//
//  Created by Kim Young Hee
//
//  목적: 앱의 설정 화면을 관리하는 뷰 컨트롤러
//  주요 기능:
//  - 현재 화면의 배경색을 스위치로 전환 (녹색/청록색)
//  - 첫 번째 화면의 배경색을 검정색으로 변경
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {

    // 배경색 변경 스위치를 위한 아웃렛
    @IBOutlet weak var bgSwitch: UISwitch!
    
    // 첫 번째 뷰 컨트롤러의 배경색을 변경하기 위한 버튼 아웃렛
    @IBOutlet weak var blackBackground: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 뷰가 로드된 후 추가 설정을 할 수 있습니다
    }

    // 배경색 스위치가 토글될 때 실행되는 액션 메서드
    @IBAction func bgSwitchChange(_ sender: UISwitch) {
        // 스위치 상태에 따라 배경색 변경
        if sender.isOn {
            // 스위치가 켜져있으면 배경색을 녹색으로 설정
            self.view.backgroundColor = UIColor.green
        } else {
            // 스위치가 꺼져있으면 배경색을 청록색으로 설정
            self.view.backgroundColor = UIColor.cyan
        }
    }

    // 첫 번째 뷰 컨트롤러의 배경색을 변경하는 버튼이 눌렸을 때 실행되는 액션 메서드
    @IBAction func changeFirstVCBG(_ sender: UIButton) {
        // 네비게이션 스택에서 첫 번째 뷰 컨트롤러에 접근
        let firstViewController = navigationController?.viewControllers.first
        
        // 첫 번째 뷰 컨트롤러의 배경색을 검정색으로 변경
        firstViewController?.view.backgroundColor = UIColor.black
    }
}
