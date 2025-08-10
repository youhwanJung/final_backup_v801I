//
//  ContentView.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/26/25.
//

import SwiftUI

struct SplashView: View {
    @StateObject var vm: SplashViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    let onFinished: () -> Void
    
    init(vm: SplashViewModel, onFinished: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: vm)
        self.onFinished = onFinished
    }
    
    var body: some View {
            VStack {
                Image("SplashLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 170)
                
            }
            .padding()
            .onAppear {
                vm.startSplashTimer()
            }
            .onChange(of: vm.isActive) {
                if vm.isActive {
                    onFinished()
                }
            }
    }
}

/**
 preview
 */
