//
//  ViewController.swift
//  MapKitDemoUIKit
//
//  Created by Kim Young Hee on 2025-02-18.
//

import UIKit
import MapKit  // MapKit: 지도 기능 및 위치 기반 서비스를 제공하는 프레임워크
               // MapKit: 지도 표시, 경로 안내, 관심 지점 표시 등 지도 관련 기능을 제공합니다
import CoreLocation  // CoreLocation: 기기의 지리적 위치, 고도, 방향 등을 처리하는 프레임워크
                    // CoreLocation: 사용자의 위치 정보를 획득하고 관리하는 프레임워크입니다

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!  // @IBOutlet: Interface Builder와 코드를 연결하는 속성
                                                      // 스토리보드에서 생성한 UI 요소와 코드를 연결합니다
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!  // MKMapView: 대화형 지도를 표시하는 뷰
                                           // 사용자와 상호작용이 가능한 애플 지도를 표시합니다
    
    // CLLocationManager: 위치 관련 이벤트를 앱에 전달하는 객체
    // 위치 서비스를 시작/중지하고 위치 업데이트를 받는 핵심 클래스입니다
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupProfileImage()
        setupLocationManager()
        
        // CLLocationManager.authorizationStatus(): 앱의 위치 서비스 권한 상태를 반환
        // 사용자가 앱에 위치 권한을 허용했는지 확인합니다
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()  // 위치 업데이트 시작
                                                   // 사용자의 현재 위치 추적을 시작합니다
        } else {
            setInitialMapLocation()  // 기본 위치(롯데월드타워)로 지도 초기화
                                    // 위치 권한이 없을 경우 기본 위치를 표시합니다
        }
    }

    func setupProfileImage() {
        // layer.cornerRadius: 뷰의 모서리를 둥글게 만드는 CALayer 속성
        // 프로필 이미지를 원형으로 만들기 위해 모서리를 둥글게 처리합니다
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true  // 뷰의 경계를 벗어나는 내용을 잘라냄
                                              // 이미지가 원형 밖으로 넘어가지 않도록 잘라냅니다
    }
    
    func setupLocationManager() {
        locationManager.delegate = self  // 위치 관련 이벤트를 수신할 델리게이트 설정
                                       // 위치 업데이트 이벤트를 현재 클래스에서 처리하도록 설정합니다
        // requestWhenInUseAuthorization: 앱 사용 중 위치 접근 권한 요청
        // 사용자에게 위치 서비스 사용 권한을 요청하는 알림을 표시합니다
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // CLLocationManagerDelegate 메서드: 위치가 업데이트될 때마다 호출
    // 사용자의 위치가 변경될 때마다 이 메서드가 자동으로 호출됩니다
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        // MKCoordinateRegion: 중심 좌표와 표시 영역을 정의하는 구조체
        // 지도에서 보여줄 영역의 중심점과 축척을 설정합니다
        let region = MKCoordinateRegion(
            center: userLocation.coordinate,  // coordinate: 위도와 경도를 포함하는 구조체
                                            // 사용자의 현재 위치를 중심점으로 설정합니다
            latitudinalMeters: 5000,  // 위도 방향으로의 표시 범위(미터)
                                     // 남북 방향으로 5km 범위를 표시합니다
            longitudinalMeters: 5000  // 경도 방향으로의 표시 범위(미터)
                                     // 동서 방향으로 5km 범위를 표시합니다
        )
        mapView.setRegion(region, animated: true)  // 지정된 영역으로 지도 뷰 업데이트
                                                  // 애니메이션과 함께 지도를 새로운 위치로 이동합니다
    }
    
    func setInitialMapLocation() {
        // CLLocationCoordinate2D: 위도와 경도로 구성된 위치 좌표
        // 특정 위치의 위도와 경도값을 저장하는 구조체입니다
        let initialLocation = CLLocationCoordinate2D(
            latitude: 37.5126,    // 위도: 롯데월드타워 북쪽/남쪽 위치
                                 // 북위 37.5126도에 위치한 롯데월드타워의 위도입니다
            longitude: 127.1025   // 경도: 롯데월드타워 동쪽/서쪽 위치
                                 // 동경 127.1025도에 위치한 롯데월드타워의 경도입니다
        )
        // MKCoordinateRegion: 지도에 표시할 영역 정의
        // 지도에서 보여줄 영역의 중심점과 축척을 설정합니다
        let region = MKCoordinateRegion(
            center: initialLocation,
            latitudinalMeters: 1000,    // 1km 반경의 위도 범위
                                       // 남북으로 1km 범위를 보여줍니다
            longitudinalMeters: 1000    // 1km 반경의 경도 범위
                                       // 동서로 1km 범위를 보여줍니다
        )
        mapView.setRegion(region, animated: true)  // 애니메이션과 함께 지정된 영역으로 지도 이동
                                                  // 부드러운 애니메이션과 함께 지도를 롯데월드타워 위치로 이동합니다
    }
}

