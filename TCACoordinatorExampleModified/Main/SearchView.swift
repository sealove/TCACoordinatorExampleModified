//
//  SearchView.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/21/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

//네비게이션 좌측 상단 tabItem의 뷰
struct SearchView: View {
    let store: StoreOf<SearchStore>
    
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
    let store = Store(initialState: SearchStore.State(), reducer: { SearchStore() })
    return SearchView(store: store)
}

@Reducer
struct SearchStore {
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
