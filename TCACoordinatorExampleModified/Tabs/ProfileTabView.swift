//
//  ProfileTabView.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/21/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

// 메인탭 세번째
struct ProfileTabView: View {
    let store: StoreOf<ProfileTabStore>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            if let profile = viewStore.profile {
                Text("Hi, I'm \(profile.name)")
            } else {
                Button("Log in") { viewStore.send(.getProfile) }
            }
        }
    }
}

#Preview {
    let store = Store.init(initialState: 
                            ProfileTabStore.State.init(profile: .init(id: 1, name: "sealove"))) {
        ProfileTabStore()
    }
    return ProfileTabView(store: store)
}

@Reducer
struct ProfileTabStore {
    struct State: Equatable {
        var profile: Profile?
    }
    
    enum Action {
        case getProfile
        case editProfile
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .getProfile:
                    state.profile = Profile(id: 1, name: "sealove")
                    return .none
                case .editProfile:
                    //TODO: make editing
                    return .none
            }
        }
    }
}

struct Profile: Equatable {
    var id: Int
    var name: String
}
