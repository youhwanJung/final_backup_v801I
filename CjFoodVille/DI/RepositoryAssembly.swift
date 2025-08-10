//
//  ViewModelAssembly.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation
import Swinject

/**Assembly (의존성을 등록하는 묶음 역활)**/
class RepositoryAssembly: Assembly {
    /**Conainer : 객체 생성 규칙과 실제 인스턴스를 모두 담고있는 저장소.**/
    /**resolver는 창고 안에서 물건을 찾아서 꺼내주는 직원.**/
    /**
     1. Container를 인자로 넘겨줘서. 이제 객체 생성 규칙을 등록하는 것같네 (창고)
     2. 지금은 _ 을 쓰고있는데 이는 resolver가 필요하지 않다는 의미이다. 즉 단순 의존성 없는 객체 생성이라는 의미
     3. 근데 만약에 의존성이 필요한 객체를 생성해야할때는, _ 자리대신 resolver(창고에서 물건 꺼내주는 지원이)가 필요함.
     */
    func assemble(container: Container) {
        container.register(AuthRepository.self) { _ in
            AuthRepositoryImpl()
        }
    }
}
