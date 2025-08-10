//
//  AuthView.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/26/25.
//

import SwiftUI

struct BarcodeScannerView: View {
    @StateObject var vm: BarcodeScannerViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    
    init(vm: BarcodeScannerViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        BarcodeScannerUIKitView()
            .ignoresSafeArea(.all)
        
    }
}

//preview
#Preview{
    BarcodeScannerView(vm: BarcodeScannerViewModel.preview)
        .environmentObject(MockAppCoordinator())
}
