//
//  TabsCoordinator.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

//탭뷰를 담당하는 코디네이터
//탭뷰의 전환만을 담당.
@Reducer
struct TabsCoordinator {
    
    enum MainTabs: Int {
        case home
        case feedList
        case profile
    }
    
    // 각 탭의 액션 및 TabView의 selection 액션
    enum Action {
        case selectTab(MainTabs)
        case home(HomeTabStore.Action)
        case feedList(FeedListTabStore.Action)
        case profile(ProfileTabStore.Action)
    }
    
    struct State: Equatable {
        static let initialState = State(
            homeState: .init(),
            feedListState: .init(feeds: []),
            profileState: .init(),
            selectedTab: .home
        )
        
        var homeState: HomeTabStore.State
        var feedListState: FeedListTabStore.State
        var profileState: ProfileTabStore.State
        
        var selectedTab: MainTabs
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.homeState, action: /Action.home) {
            HomeTabStore()
        }
        Scope(state: \.feedListState, action: /Action.feedList) {
            FeedListTabStore()
        }
        Scope(state: \.profileState, action: /Action.profile) {
            ProfileTabStore()
        }
        Reduce { state, action in
            switch action {
                case let .selectTab(tab):
                    state.selectedTab = tab
                default: break
            }
            return .none
        }
    }
}

struct TabsCoordinatorView: View {
    let store: StoreOf<TabsCoordinator>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(get: \.selectedTab, send: { .selectTab($0) })) {
                HomeTabView(
                    store: store.scope(state: \.homeState, action: \.home)
                )
                .tag(TabsCoordinator.MainTabs.home)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                FeedListTabView(
                    store: store.scope(state: \.feedListState, action: \.feedList)
                )
                .tag(TabsCoordinator.MainTabs.feedList)
                .tabItem {
                    Label("Feed", systemImage: "list.bullet")
                }
                ProfileTabView(
                    store: store.scope(state: \.profileState, action: \.profile)
                )
                .tag(TabsCoordinator.MainTabs.profile)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            }
        }
    }
}
