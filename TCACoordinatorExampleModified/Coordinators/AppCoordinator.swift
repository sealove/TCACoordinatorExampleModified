//
//  AppCoordinator.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/20/24.
//
// 앱 시작시 호출되는 첫 코디네이터
// 앱실행 후 런치스크린 다음의 스플래시뷰, 튜토리얼(워크스루)과 메인의 분기


import SwiftUI
import ComposableArchitecture
import TCACoordinators

// AppCoordinator를 통해 이동할 뷰 선언
// Coordinator를 사용하기 위해선 Screen, Coordinator, CoordinatorView 3가지가 필요하다.
@Reducer
struct AppScreen {
    enum State: Equatable {
        case splash(SplashStore.State)
        case tutorial(TutorialStore.State)
        case main
    }
    
    enum Action {
        case splash(SplashStore.Action)
        case tutorial(TutorialStore.Action)
        case main
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: /State.splash, action: /Action.splash) { SplashStore() }
        Scope(state: /State.tutorial, action: /Action.tutorial) { TutorialStore() }
    }
}

@Reducer
struct AppCoordinator {
    struct State: Equatable, IndexedRouterState {
        var routes: [Route<AppScreen.State>]
        static let initialState = State(
            routes: [.root(.splash(.init()), embedInNavigationView: true)] // 네비게이션 여뷰는 여기서.
        )
        
        var isCompletedTutorial: Bool = UserDefaults.standard.bool(forKey: "isTutorialComplete")
    }
    
    enum Action: IndexedRouterAction {
        case routeAction(Int, action: AppScreen.Action)
        case updateRoutes([Route<AppScreen.State>])
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
                case .routeAction(_, action: .splash(.completed)):
                    if state.isCompletedTutorial {
                        state.routes = [.root(.main)]
                    } else {
                        state.routes.presentCover(.tutorial(TutorialStore.State.init()), embedInNavigationView: true)
                    }
                case .routeAction(_, action: .tutorial(.completedTutorial)):
                    state.routes = [.root(.main)]
                    break
                default: break
            }
            return .none
        }
        .forEachRoute {
            AppScreen()
        }
    }
}

struct AppCoordinatorView: View {
    let coordinator: StoreOf<AppCoordinator>
    
    var body: some View {
        TCARouter(coordinator) { store in
            SwitchStore(store) { screen in
                switch screen {
                    case .splash:
                        CaseLet(/AppScreen.State.splash, // keyPath, CasePath. 까먹지 말자.
                                action: AppScreen.Action.splash,
                                then: SplashView.init)
                    case .tutorial:
                        CaseLet(/AppScreen.State.tutorial, 
                                 action: AppScreen.Action.tutorial,
                                 then: TutorialView.init)
                    case .main:
                        MainCoordinatorView(
                            coordinator: Store.init(initialState: .initialState, reducer: {
                                MainCoordinator()
                            })
                        )
                }
            }
            
        }
    }
}
