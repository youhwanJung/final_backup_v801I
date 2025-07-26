//
//  ContentView.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/26/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            AuthView()
        }
        else {
            VStack { /**수직으로 뷰를 쌓을 수 있게 해준다.**/
                Image("SplashLogo") /**이미지를 불러온다.**/
                    .resizable() /**이미지 크기를 바꿀수있음을 설정한다.**/
                    .scaledToFit()/**이미지가 프레임내에 비율을 유지할수있도록한다.**/
                    .frame(width: 170, height: 170)
                
            }
            .padding()
            .onAppear {
            }
        }
    }
}

#Preview {
    SplashView()
}
