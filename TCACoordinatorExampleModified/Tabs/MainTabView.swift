//
//  MainTabView.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/21/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

enum MainTabs: Int {
    case home
    case feedList
    case profile
}

struct MainTabView: View {
    let store: StoreOf<MainTabStore>
    var body: some View {
        VStack {
            TabView {
                HomeTabView()
                    .tag(MainTabs.home)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                FeedListTabView()
                    .tag(MainTabs.feedList)
                    .tabItem {
                        Label("Feed", systemImage: "list.bullet")
                    }
                ProfileTabView()
                    .tag(MainTabs.profile)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
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
        var selectedTab: MainTabs = .home
    }
    
    enum Action {
        case tabSelected(MainTabs)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none
            }
        }
    }
}
