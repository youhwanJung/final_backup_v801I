//
//  SplashViewModel.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/26/25.
//

import Foundation
import Combine

class BarcodeScannerViewModel: ObservableObject {
    
    init() {
    
    }
}

extension BarcodeScannerViewModel {
    static var preview: BarcodeScannerViewModel {
        return BarcodeScannerViewModel(
           //todo UseCase
        )
    }
}
