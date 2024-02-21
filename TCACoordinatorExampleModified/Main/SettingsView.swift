//
//  SettingsView.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/21/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

// 네비게이션 우측 상단 tabItem 설정뷰
struct SettingsView: View {
    let store: StoreOf<SettingsStore>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("let's go search...")
            Button {
                viewStore.send(.close)
            } label: {
                Text("Close")
            }
        }
    }
}

#Preview {
    let store = Store(initialState: SettingsStore.State(), reducer: { SettingsStore() })
    return SettingsView(store: store)
}

@Reducer
struct SettingsStore {
    struct State: Equatable {
        
    }
    
    enum Action {
        case close
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
                case .close: return .none
            }
        }
    }
}
