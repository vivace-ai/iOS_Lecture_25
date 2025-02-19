//
//  SettingsViewController.swift
//  ViewControllerExamplesNoahC
//
//  Created by 김영희 on 2025-02-19
//
//  파일 설명:
//  이 파일은 앱의 설정 화면을 관리하는 ViewController입니다.
//  배경색 변경 기능을 제공하며, UISwitch를 통한 색상 전환과
//  버튼을 통한 첫 화면의 배경색 변경 기능을 구현합니다.

import Foundation
import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var bgSwitch: UISwitch!
    
    
    @IBOutlet weak var bgBlack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 뷰가 로드된 후 추가적인 설정을 진행합니다.
    }


    @IBAction func bgSwitchToggle(_ sender: UISwitch) {
        
        if sender.isOn{
            self.view.backgroundColor = UIColor.red
            
        }else{
            self.view.backgroundColor = UIColor.cyan
            
        }
        
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let firstViewController = navigationController?.viewControllers.first
        
        firstViewController.self?.view.backgroundColor = UIColor.black
        
    }
    
    
}

