//
//  MainCoordinator.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

// 앱의 메인이자, 네비게이션을 담당하는 코디네이터
// 상단 네비게이션 및 탭바를 가리며 전체를 덮는 식의 navigation이동 담당.
// TCA coordinotor example에는 탭뷰의 탭별 네비게이션 이동으로만 나와있고, 한국의 앱들은 이런 뷰 이동을 많이 차용하고 있어서
// 이런 방식으로 coordinator패턴을 구성함. 

@Reducer
struct MainScreen {
    enum State: Equatable {
        case tabs(TabsCoordinator.State)
//        case search
//        case settings
    }
    
    enum Action {
        case tab(TabsCoordinator.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: /MainScreen.State.tabs, action: /MainScreen.Action.tab, child: { TabsCoordinator() })
    }
}

@Reducer
struct MainCoordinator {
    struct State: Equatable, IndexedRouterState {
        var routes: [Route<MainScreen.State>]
        
        static let initialState = State(
            routes: [.root(.tabs(.initialState), embedInNavigationView: true)]
        )
    }
    
    enum Action: IndexedRouterAction {
        case routeAction(Int, action: MainScreen.Action)
        case updateRoutes([Route<MainScreen.State>])
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
//                case .routeAction(_, .search(.main)):
//                    state.routes.presnetSheet(.search(.init()))
                default: break
            }
            return .none
        }
        .forEachRoute {
            MainScreen()
        }
    }
}

struct MainCoordinatorView: View {
    let coordinator: StoreOf<MainCoordinator>
    
    var body: some View {
        TCARouter(coordinator) { store in
            SwitchStore(store) { screen in
                switch screen {
                    case .tabs:
                        CaseLet(/MainScreen.State.tabs,
                                 action: MainScreen.Action.tab,
                                 then: TabsCoordinatorView.init)
//                    case .search:
//                    case .settings:
                }
                
            }
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button {
//                        store.send(.search(.main))
//                    } label: {
//                        Image(.btncalendar)
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        store.send(.settings(.main))
//                    } label: {
//                        Image(.btnSetting)
//                    }
//                }
//            }
        }
    }
}
