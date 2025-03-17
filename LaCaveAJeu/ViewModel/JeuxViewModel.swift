//
//  JeuxViewModel.swift
//  LaCaveAJeu
//
//  Created by etud on 17/03/2025.
//

import SwiftUI

class JeuxViewModel: ObservableObject {
    @Published var games: [Game] = []
    private let apiservice = APIService()
    
}


