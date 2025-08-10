//
//  Coordinator.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation
import SwiftUI
import Swinject

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func start() -> some View {
        guard let authVM = resolver.resolve(AuthViewModel.self) else {
            fatalError("AuthViewModel 의존성 주입 실패")
        }
        return AnyView(AuthView(vm: authVM))
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    // Auth 화면으로
    func goAuth() {
        path.append(Screen.auth)
    }
    
    // Detail 화면으로
    func goToDetail() {
        path.append(Screen.detail)
    }
    
    // BarcodScanner 화면으로
    func goToBarcodeScane() {
        path.append(Screen.barcodeScanner)
    }
    
    func destination(for screen: Screen) -> some View {
        switch screen {
        case .auth:
            guard let authVM = resolver.resolve(AuthViewModel.self) else {
                fatalError("AuthViewModel 의존성 주입 실패")
            }
            return AnyView(AuthView(vm: authVM))
        case .detail:
            return AnyView(DetailView())
        case .barcodeScanner:
            guard let barcodeScannerVM = resolver.resolve(BarcodeScannerViewModel.self) else {
                fatalError("BarcodeScannerViewModel 의존성 주입 실패")
            }
            return AnyView(BarcodeScannerView(vm: <#T##BarcodeScannerViewModel#>))
        }
    }
}
