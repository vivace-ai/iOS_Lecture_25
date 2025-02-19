//  ViewController.swift
//  NotificationsExample
//  Create by Kim Young Hee on 25-02-18.

import UIKit

// MARK: - ViewController

/// 다양한 동작을 포함한 알림을 표시하는 버튼을 보여주는 뷰 컨트롤러입니다.
/// 여러 동작이 포함된 `UIAlertController`를 생성하고 표시하는 방법을 보여줍니다.
class ViewController: UIViewController {
    
    // MARK: - 수명주기 메서드
    
    /// 컨트롤러의 뷰가 메모리에 로드된 후 호출됩니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIButton을 프로그래밍 방식으로 생성합니다.
        // 인터페이스 빌더를 사용하여 버튼을 추가할 수도 있지만, 이 예제는 코드로 직접 구현하는 방법을 보여줍니다.
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        button.backgroundColor = .blue  // 버튼의 배경색을 파란색으로 설정합니다.
        button.setTitle("알림 표시", for: .normal)  // 버튼의 제목을 설정합니다.
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)  // 버튼에 동작을 추가합니다.
        self.view.addSubview(button)  // 버튼을 뷰 계층구조에 추가합니다.
    }
    
    // MARK: - 동작 메서드
    
    /// 버튼이 탭되었을 때 여러 동작이 포함된 알림을 표시합니다.
    @objc func showAlert() {
        // 제목과 메시지가 있는 알림 컨트롤러를 생성합니다.
        let alertController = UIAlertController(title: "선택하세요", message: "옵션을 선택하세요", preferredStyle: .alert)
        
        // "예" 동작을 클로저와 함께 정의합니다.
        let yesAction = UIAlertAction(title: "예", style: .default) { [weak self] action in
            self?.showFollowUpAlert(message: "사용자가 '예'를 선택했습니다")
        }
        alertController.addAction(yesAction)  // "예" 동작을 알림에 추가합니다.
        
        // "아니오" 동작을 클로저와 함께 정의합니다.
        let noAction = UIAlertAction(title: "아니오", style: .default) { action in
            print("사용자가 '아니오'를 선택했습니다")  // 사용자의 선택을 로그에 기록합니다.
        }
        alertController.addAction(noAction)  // "아니오" 동작을 알림에 추가합니다.
        
        // "아마도" 동작을 클로저와 함께 정의합니다.
        let maybeAction = UIAlertAction(title: "아마도", style: .default) { action in
            print("사용자가 '아마도'를 선택했습니다")  // 사용자의 선택을 로그에 기록합니다.
        }
        alertController.addAction(maybeAction)  // "아마도" 동작을 알림에 추가합니다.
        
        // iPad에서 실행 시 충돌을 방지하기 위해 팝오버 프레젠테이션을 구성합니다.
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view  // 뷰 컨트롤러의 메인 뷰를 소스 뷰로 사용합니다.
            popoverPresentationController.sourceRect = self.view.bounds  // 화면 중앙에서 표시합니다.
            popoverPresentationController.permittedArrowDirections = []  // 팝오버에 화살표를 표시하지 않습니다.
        }
        
        // 알림 컨트롤러를 애니메이션과 함께 표시합니다.
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// 사용자 지정 메시지가 포함된 후속 알림을 표시합니다.
    /// - Parameter message: 후속 알림에 표시할 메시지입니다.
    func showFollowUpAlert(message: String) {
        // 후속 메시지를 위한 새로운 알림 컨트롤러를 생성합니다.
        let followUpAlert = UIAlertController(title: "결과", message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)  // "닫기" 동작을 정의합니다.
        followUpAlert.addAction(closeAction)  // "닫기" 동작을 후속 알림에 추가합니다.
        
        // 후속 알림을 애니메이션과 함께 표시합니다.
        self.present(followUpAlert, animated: true, completion: nil)
    }
}
