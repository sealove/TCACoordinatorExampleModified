//
//  MainCoordinator.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/20/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators

// 앱의 메인이자, 네비게이션을 담당하는 코디네이터
// 상단 네비게이션 및 탭바를 가리며 전체를 덮는 식의 navigation이동 담당.
// TCA coordinotor example에는 탭뷰의 탭별 네비게이션 이동으로만 나와있고, 한국의 앱들은 이런 뷰 이동을 많이 차용하고 있어서
// 이런 방식으로 coordinator패턴을 구성함. 
