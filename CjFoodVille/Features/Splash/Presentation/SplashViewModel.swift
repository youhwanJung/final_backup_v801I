//
//  SplashViewModel.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/26/25.
//

import Foundation
import Combine

/**
 ObservableObject : ViewModel 역활을 도와주는 친구,
 어노테이션이 걸린 친구가 변경되면 SwiftUi View를 자동으로 다시 그려준다.
 */
class SplashViewModel: ObservableObject {
    @Published var isActive: Bool = false
    
    func startSplashTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isActive = true
        }
    }
}
