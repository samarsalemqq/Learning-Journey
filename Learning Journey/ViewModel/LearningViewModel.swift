//
//  LearningViewModel.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import SwiftUI
import Combine

class LearningViewModel: ObservableObject {
    
    @Published var weekDays: [DayStatus] = [
        DayStatus(date: 20, isFreezed: true),
        DayStatus(date: 21, isLearned: true),
        DayStatus(date: 22, isLearned: true),
        DayStatus(date: 23, isLearned: true),
        DayStatus(date: 24, isLearned: true),
        DayStatus(date: 25),
        DayStatus(date: 26)
    ]
    
    @Published var selectedDay: Int = 25
    @Published var freezeCount: Int = 2
    @Published var streakCount: Int = 0
    @Published var isButtonDisabled: Bool = false
    
    // MARK: - Actions
    
    func logAsLearned() {
        guard !isButtonDisabled else { return }
        if let index = weekDays.firstIndex(where: { $0.date == selectedDay }) {
            weekDays[index].isLearned = true
            weekDays[index].isFreezed = false
            streakCount += 1
        }
        disableButtonTemporarily()
    }
    
    func logAsFreezed() {
        guard !isButtonDisabled else { return }
        guard freezeCount > 0 else {
            print("No freezes left!")
            return
        }
        if let index = weekDays.firstIndex(where: { $0.date == selectedDay }) {
            weekDays[index].isLearned = false
            weekDays[index].isFreezed = true
            freezeCount -= 1
        }
        disableButtonTemporarily()
    }
    
    // MARK: - Colors
    
    func circleColor(for day: DayStatus) -> Color {
        if day.isLearned { return Color(red: 0.30, green: 0.20, blue: 0.10) }
        if day.isFreezed { return Color(red: 0.12, green: 0.25, blue: 0.32) }
        return Color(red: 0.08, green: 0.08, blue: 0.08)
    }

    func textColor(for day: DayStatus) -> Color {
        if day.isLearned { return Color(red: 255/255, green: 146/255, blue: 48/255) }
        if day.isFreezed { return Color(red: 60/255, green: 221/255, blue: 254/255) }
        return .white
    }
    
    // MARK: - Helpers
    
    private func disableButtonTemporarily() {
        isButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 86400) { // يعيد تفعيل الزر بعد 24 ساعه
            self.isButtonDisabled = false
        }
    }
}
