//
//  CjFoodVilleApp.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/26/25.
//

import SwiftUI
import Swinject

@main
struct CjFoodVilleApp: App {
    @State private var didFinishSplash = false
    @StateObject var appCoordinator: AppCoordinator //앱 전체 흐름(네비게이션)을 관리하는 관리자 역활이다. 화면이 어디로 이동할지, 어떤 viewModel이 필요한지 판단하는 클래스이다.
    /**
     @StateObject : 상태를 가지고있는 객체를 만들고, 그 상태가 변경되면, 화면도 바뀌게 해줘 라는 뜻. (보통 ViewModel에서 사용) 역활은 같아
     1. 여기서의 StateObject의 역활은, 앱의 생명주기 동안 계속 들고 있어야하고,
     2. 딱 한번만 생성해서 재활용해야돼 그래서 사용했대
     */
    /**
     @State: View안에서 상태를 저장하고 싶을 때 사용한다. 이 상태가 변경되면 자동으로 화면을 다시 그려주는 역활을 한다.
     */
    
    /**의존성 주입 설정 클래스들을 등록**/
    let assembler = Assembler([
        RepositoryAssembly(),
        UseCaseAssembly(),
        ViewModelAssembly(),
        CoordinatorAssembly()
    ])
    
    //@State private var path = NavigationPath() //SwiftUi의 NavigationStack을 위한, 히스토리 저장소 객체이다.
    init() {
        /**
         이친구는 assembler에서 의존성주입이 설정된 코디네이터를 가져오고있고
         */
        let coordinator = assembler.resolver.resolve(AppCoordinator.self)! //의존성 주입해놓은 코디네이터를 꺼내서
        /**
         이친구는 가져온 코디네이터를 내가 선언한 StateObject 어노테이션이 붙은 코디네이터에 적용시켜준다.
         1. _appCoordinator 앞에 _의 의미 : @StateObject로 선언한 변수는, 자동으로 _appCoordinator라는 변수를 만든다. 즉 내가 앞에 @StateObject로 선언한 appCoordinator와 동일한친구다.
         2. StateObject라는 구조체에 wrappedValue 속성에 객체를 넣어서 등록시킬 수 있나봐
         */
        _appCoordinator = StateObject(wrappedValue: coordinator) //@StateObject로 등록
    }
    
    /**
     body: 화면에 보여줄 UI 구조 (내용)
     Scene: 앱의 한 화면 단위
     some Scene: 구체적인 Scene 타입 하나 반환
     WindowGroup: 앱에서 기본으로 보여주는 윈도우 그룹.
     */
    var body: some Scene {
        WindowGroup {
            Group {
                /**
                 didFinishSplash 변수가 true인지 false인지에 따라, Splash화면을 보여줄지, StackNavi의 첫 화면을 보여줄지 선택하게 된다.
                 1. 그럼 didFinishSplash 변수는 어떻게 바꿀까
                 2. SplashView에 해당 didFinishSplash 변수를 바꾸는 로직을 인자로 넘겨준다. (클로저 형식이래)
                 3. 그러면 SplashView에서 그 함수를 받을 수 있는 걸 만든다음 그 함수를 받는다.
                 4. 내가 원하는 행위를 한 후 인자로 받은 함수를 실행한다.
                 5. CjFoodVilleApp에 있는 변수가 바뀐다 해당 변수는 @State변수기 때문에 화면을 다시 그린다.
                 6. didFinsihSplash가 true이기 때문에 Nav의 첫화면인, AuthView를 보여주게 된다.
                 */
                if didFinishSplash {
                    /**
                     NavigationStack이라는 객체를 만든다.
                     여기서 문법을 이해해야하는데, 여기선 그냥 느껴야돼
                     1. 일단 예제 하나 줄게
                     Text("Hello")
                     .forgroundColor(.blue)
                     .font(.title)
                     .padding()
                     이놈을 보면 어떤생각이 들어? 그냥 평방한 위젯이고, 그 아래에 이제 속성이 부여된거라고 생각하겠지
                     근데 틀렸다 이말이야 이건 메소드 체이싱
                     즉. object.method1().method2().method3() 맨앞에서 반환된 값을 바로 이어서 다음 메서드에 넘기는 방식이야.
                     
                     다시
                     appCoordinator.start()
                     .navigationDestination(for: String.self) { screen in
                     appCoordinator.destination(for: screen)
                     }
                     을 확인해보자.
                     1. appCoordinator는 그냥 View를 반환하고 있어, 마치 Text("Hello") View처럼
                     2. 그 뒤에는 그 해당 View에 이어 붙여지는 함수같은거라고 생각하면돼
                     3. 여기서부턴 느껴야되는데 뒤에 붙은 .navigationDestination 함수는 path가 바뀔때 실행되고
                     
                     */
                    NavigationStack(path: $appCoordinator.path) {
                        appCoordinator.start()
                            .navigationDestination(for: Screen.self) { screen in
                                appCoordinator.destination(for: screen)
                            }
                    }
                    .environmentObject(appCoordinator)
                    /**
                     1. 해당 appCoordinator를 앱 전역에서 공유하기 위함.
                     2. @EnvironmentObject를 사용하여, 앱 전역에 주입받을수 있다.
                     */
                }else{
                    SplashView(vm: SplashViewModel()) {
                        withAnimation {
                            didFinishSplash = true
                        }
                    }
                }
            }
        }
    }
}

