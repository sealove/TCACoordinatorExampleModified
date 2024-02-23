//
//  HomeTabView.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/21/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

//메인탭 첫번째
struct HomeTabView: View {
    let store: StoreOf<HomeTabStore>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Text("Home, sweet home.")
                Button("open modal") {
                    viewStore.send(.openModal)
                }
                
                Button("open sheet") {
                    viewStore.send(.openSheet(true))
                }
            }
            .sheet(isPresented: viewStore.binding(get: \.isOpenSheet, send: { .openSheet($0) })) {
                VStack {
                    Text("Sheet popup")
                }
            }
        }
        
    }
}

#Preview {
    let store = Store(initialState: HomeTabStore.State.init(), reducer: { HomeTabStore() })
    return HomeTabView(store: store)
}

@Reducer
struct HomeTabStore {
    struct State: Equatable {
        var isOpenSheet: Bool = false
    }
    
    enum Action {
        case openModal
        case openSheet(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .openModal:
                    //nothing..
                return .none
            case .openSheet:
                    
                return .none
            }
        }
    }
}
