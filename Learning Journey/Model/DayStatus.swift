//
//  DayStatus.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import Foundation

struct DayStatus: Identifiable {
    let id = UUID()
    let date : Int
    var isLearned: Bool = false
    var isFreezed : Bool = false
}
