//
//  AuthView.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/26/25.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerUIKitView: UIViewControllerRepresentable {
    
    //delete 객체 생성.
    class BarcodeScanCoordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerUIKitView
        
        init(parent: BarcodeScannerUIKitView) {
            self.parent = parent
        }
        func metadataOutput(_ output: AVCaptureMetadataOutput, //이 함수는 MetaData각 인식되었을때 호출하게 된다.
                            didOutput metadataObjects: [AVMetadataObject],
                            from connection: AVCaptureConnection) {
            if let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject, //첫번째로 감지된 메타데이터를 꺼내서
            
            //todo 여기서 실재 로직 실행.
            let code = metadataObj.stringValue {
                print("인식된 코드: \(code)")
                print("바코드 타입: \(metadataObj.type.rawValue)")
                print("인식 영역 좌표: \(metadataObj.bounds)")
                print("모서리 좌표들: \(metadataObj.corners)")
                
            }
        }
    }
    
    func makeCoordinator() -> BarcodeScanCoordinator {
        BarcodeScanCoordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIViewController() //UiKit를 SwiftUi에서 사용할 수 있게 해주는 친구 생성
        let session = AVCaptureSession() //IOS의 하드웨어의 입출력을 관리하는 친구 생성
        
        guard let videoDevice = AVCaptureDevice.default(for: .video), //카메라 객체 가져오기
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice) //스트림형태로 영상 데이터를 가져올수 있도록 만듬
        else {
            return controller //오류 나면 리턴
        }
        session.addInput(videoInput) //Session에 등록
        
        let metadataOutput = AVCaptureMetadataOutput() //Meta데이터를 전달 받을 수 있도록 해주는 친구 생성
        session.addOutput(metadataOutput) //Session에 등록
        
        metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
        //메타데이터가 인식됐을때, 호출되는 함수(Coordinator 객체 생성 하고 등록) 지정 및, 해당 부분에서 실행될 스레드 설정
        metadataOutput.metadataObjectTypes = [.code93] //인식할 바코드 유형 추가.
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session) //Video화면을 나오게 해줄 레이어 설정, 설정한 세션을 전달.
        previewLayer.frame = UIScreen.main.bounds //카메라 영상 레이어의 크기와 위치 설정
        previewLayer.videoGravity = .resizeAspectFill //레이어안에 프레임이 어떻게 크기가 조절되는지 설정
        controller.view.layer.addSublayer(previewLayer) //controller에 해당 레이어를 추가하여 화면이 보이게 한다.
        
        //백그라운드에서 영상 스트리밍 시작.
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }
        
        return controller //화면 리턴
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

