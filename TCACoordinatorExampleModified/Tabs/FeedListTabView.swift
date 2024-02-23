//
//  FeedListTabView.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/21/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

// 메인탭 두번째
struct FeedListTabView: View {
    let store: StoreOf<FeedListTabStore>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List(viewStore.feeds, id: \.id) { feed in
                Text(feed.title)
            }
            .onAppear {
                viewStore.send(.getFeeds)
            }
        }
    }
}

#Preview {
    let store = Store.init(initialState: FeedListTabStore.State(feeds: [])) {
        FeedListTabStore()
    }
    return FeedListTabView(store: store)
}

@Reducer
struct FeedListTabStore {
    struct State: Equatable {
        var feeds: [Feed]
    }
    
    enum Action {
        case getFeeds
        case addFeed
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .getFeeds:
                    state.feeds = [
                        Feed(id: 1, title: "feed1"),
                        Feed(id: 2, title: "feed2"),
                        Feed(id: 3, title: "feed3")
                    ]
                    return .none
                case .addFeed:
                    return .none
            }
        }
    }
}

struct Feed: Equatable {
    var id: Int
    var title: String
}
