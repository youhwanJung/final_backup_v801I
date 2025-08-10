//
//  AuthView.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/26/25.
//

import SwiftUI

struct AuthView: View {
    @StateObject var vm: AuthViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    
    init(vm: AuthViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack() {
            Text("Biometric")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            Text("Server(get/post)")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 40)
            HStack(spacing: 12) {
                Button(action: {
                    Task {
                        await vm.biometricLogic()
                    }
                }) {
                    Text("Biometric")
                        .font(.system(size: 14, weight: .semibold))
                        .padding()
                        .frame(width: 120, height: 37)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                Text(": Hit this to unlock")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
            
            HStack(spacing: 12) {
                Button(action: {
                    coordinator.goToBarcodeScane()
                }) {
                    Text("Barcode")
                        .font(.system(size: 14, weight: .semibold))
                        .padding()
                        .frame(width: 120, height: 37)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                Text(": Hit this and Scan Barcode")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
            
            HStack(spacing: 12) {
                Button(action: {
                    coordinator.goToDetail()
                }) {
                    Text("detail")
                        .font(.system(size: 14, weight: .semibold))
                        .padding()
                        .frame(width: 100, height: 37)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                Text(": Your VIP pass to the detail world")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
            VStack() {
                HStack(spacing: 12) {
                    Button(action: {
                        Task {
                            await vm.getServer()
                        }
                    }) {
                        Text("Get")
                            .font(.system(size: 14, weight: .semibold))
                            .padding()
                            .frame(width: 70, height: 33)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    Button(action: {
                        Task {
                            await vm.postServer()
                        }
                    }) {
                        Text("Post")
                            .font(.system(size: 14, weight: .semibold))
                            .padding()
                            .frame(width: 70, height: 33)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12)
                ZStack(alignment: .topLeading) {
                    if vm.isLock {
                        Text("is lock = true, Sorry..")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                    }else {
                        ScrollView {
                            Text(vm.longlongText ?? "Hmm... nothing here yet. Maybe it's hiding?")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(4)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .border(Color.white, width: 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background(Color.black)
        .alert(vm.biometricResultMessage ?? "", isPresented: $vm.showBiometricLogicAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

/**
 preview
 */
#Preview{
    AuthView(vm: AuthViewModel.preview)
        .environmentObject(MockAppCoordinator())
}

