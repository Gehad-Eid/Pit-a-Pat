//
//  AppViewModel.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 04/02/2024.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var profileViewModel = ProfileViewModel()
    @Published var viewModel = ViewModel()
}
