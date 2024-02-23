//
//  MainTabView.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/21/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators


struct MainTabView: View {
    let store: StoreOf<MainTabStore>
    var body: some View {
        VStack {
//            TabView {
//                HomeTabView(store:
//                                store.scope(state: { $0.}, action: <#T##CaseKeyPath<MainTabStore.Action, ChildAction>#>))
//                    .tag(MainTabs.home)
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                FeedListTabView()
//                    .tag(MainTabs.feedList)
//                    .tabItem {
//                        Label("Feed", systemImage: "list.bullet")
//                    }
//                ProfileTabView()
//                    .tag(MainTabs.profile)
//                    .tabItem {
//                        Label("Profile", systemImage: "person")
//                    }
//            }
        }
    }
}

#Preview {
    let store = Store(initialState: MainTabStore.State(), reducer: { MainTabStore() })
    return MainTabView(store: store)
}

@Reducer
struct MainTabStore {
    struct State: Equatable {
//        var selectedTab: MainTabs = .home
    }
    
    enum Action {
//        case tabSelected(MainTabs)
        case alert
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .alert:
                    return .none
//            case let .tabSelected(tab):
//                state.selectedTab = tab
//                return .none
            }
        }
    }
}
