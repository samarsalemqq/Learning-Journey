//
//  Learning_JourneyApp.swift
//  Learning Journey
//
//  Created by Samar A on 24/04/1447 AH.
//

import SwiftUI

@main
struct Learning_JourneyApp: App {
    @StateObject private var viewModel = LearningViewModel()
    
    var body: some Scene{
        WindowGroup {
            NavigationStack {
               Enbording()
               
                    .environmentObject(viewModel)
                
            }
        }
    }
}

    
