//
//  LearningViewModel.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import SwiftUI
import Combine
import Foundation

class LearningViewModel: ObservableObject {
    
    // MARK: -  General Published Properties (مشتركة بين كل الصفحات)
    @Published var learingGoal: String = "Swift"
    @Published var learningDuration: String = "Week"
    @Published var showUpdateAlert: Bool = false
    @Published var isGoalCompleted: Bool = false
    @Published var totalDays: Int = 0
    
    // MARK: -  Calendar States (تُستخدم في WeekCalendarView / AllActivitiesView)
    @Published var currentDate: Date = Date()
    @Published var selectedMonth: Int
    @Published var selectedYear: Int
    @Published var weekDays: [DayStatus] = []
    @Published var selectedDay: Int
    
    // MARK: -  Learning Progress Logic (تُستخدم في CurrentDayDefault و ActivityLastday)
    @Published var freezeCount: Int = 2
    @Published var streakCount: Int = 0
    @Published var isButtonDisabled: Bool = false
    @Published var showGoalCompletedView: Bool = false

    
    // MARK: - Private Helpers
    private var cancellables = Set<AnyCancellable>()
    private let calendar = Calendar.current
    
    
    // MARK: -  Init (تشغيل تلقائي عند فتح التطبيق أو الصفحة الأولى)
    init() {
        let now = Date()
        selectedMonth = calendar.component(.month, from: now)
        selectedYear = calendar.component(.year, from: now)
        selectedDay = calendar.component(.day, from: now)
        updateWeekDays()
        scheduleButtonResetAtMidnight()
    }
    
    
    // MARK: -  Week Calendar Logic (WeekCalendarView)
    func updateWeekDays() {
        let calendar = Calendar(identifier: .gregorian)
        let current = currentDate
        
        let weekday = calendar.component(.weekday, from: current)
        let daysToSubtract = (weekday + 6) % 7
        guard let startOfWeek = calendar.date(byAdding: .day, value: -daysToSubtract, to: current) else { return }

        weekDays = (0..<7).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek) {
                return DayStatus(date: date, isLearned: false, isFreezed: false)
            }
            return nil
        }

        selectedDay = calendar.component(.day, from: current)
        selectedMonth = calendar.component(.month, from: current)
        selectedYear = calendar.component(.year, from: current)
    }

    
    // MARK: -  Week Navigation (WeekCalendarView)
    func nextWeek() {
        if let newDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate) {
            currentDate = newDate
            updateWeekDays()
        }
    }
    
    func prevWeek() {
        if let newDate = calendar.date(byAdding: .weekOfYear, value: -1, to: currentDate) {
            currentDate = newDate
            updateWeekDays()
        }
    }
    
    
    // MARK: -  Day Actions (CurrentDayDefault)
    func logAsLearned() {
        guard !isButtonDisabled else { return }
        if let index = weekDays.firstIndex(where: {
            Calendar.current.component(.day, from: $0.date) == selectedDay
        }) {
            weekDays[index].isLearned = true
            weekDays[index].isFreezed = false
            streakCount += 1
        }
        disableButtonTemporarily()
        checkIfGoalCompleted()
        objectWillChange.send()
    }
    
    func logAsFreezed() {
        guard !isButtonDisabled else { return }
        guard freezeCount > 0 else { return }
        if let index = weekDays.firstIndex(where: {
            Calendar.current.component(.day, from: $0.date) == selectedDay
        }) {
            weekDays[index].isFreezed = true
            weekDays[index].isLearned = false
            freezeCount -= 1
        }
        disableButtonTemporarily()
        checkIfGoalCompleted()
        objectWillChange.send()
    }
    
    
    // MARK: - Goal Completion Logic (ActivityLastday)
    func checkIfGoalCompleted() {
        let learnedCount = weekDays.filter { $0.isLearned }.count
        let freezedCount = weekDays.filter { $0.isFreezed }.count
        let totalAllowed = learningDuration == "Week" ? 7 : (learningDuration == "Month" ? 30 : 365)
        
        if learnedCount + freezedCount >= totalAllowed {
            isGoalCompleted = true
            totalDays = learnedCount
            showGoalCompletedView = true
        }
    }

    func resetGoal() {
        weekDays = weekDays.map { DayStatus(date: $0.date) }
        freezeCount = 2
        streakCount = 0
        isGoalCompleted = false
    }
    
    
    // MARK: -  Colors (تُستخدم في WeekCalendarView)
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
    
    
    // MARK: - ⏰Button State Handling (CurrentDayDefault)
    private func scheduleButtonResetAtMidnight() {
        let now = Date()
        if let nextMidnight = calendar.nextDate(
            after: now,
            matching: DateComponents(hour: 0, minute: 0, second: 0),
            matchingPolicy: .nextTimePreservingSmallerComponents
        ) {
            let timeUntilMidnight = nextMidnight.timeIntervalSince(now)
            DispatchQueue.main.asyncAfter(deadline: .now() + timeUntilMidnight) {
                self.isButtonDisabled = false
                self.scheduleButtonResetAtMidnight()
            }
        }
    }
    
    private func disableButtonTemporarily() {
        isButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 86400) {
            self.isButtonDisabled = false
        }
    }
    
    
    // MARK: - Duration & Freeze Setup (Enbording)
    func configureFreezesForDuration() {
        switch learningDuration {
        case "Week": freezeCount = 2
        case "Month": freezeCount = 8
        case "Year": freezeCount = 96
        default: freezeCount = 2
        }
    }
    
    
    // MARK: -  Helper Functions (WeekCalendarView)
    func dateForDay(_ day: DayStatus) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = selectedYear
        components.month = selectedMonth
        components.day = Calendar.current.component(.day, from: day.date)
        return calendar.date(from: components) ?? Date()
    }
    
    func monthAndYearString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    func updateFromDate(_ date: Date) {
        let calendar = Calendar.current
        selectedMonth = calendar.component(.month, from: date)
        selectedYear = calendar.component(.year, from: date)
        currentDate = date
        updateWeekDays()
    }
    
    
    // MARK: -  Day Update Utility (تُستخدم في CurrentDayDefault عند تحديث الحالة)
    func updateDayStatus(selectedDay: Int, isLearned: Bool, isFreezed: Bool) {
        if let index = weekDays.firstIndex(where: {
            Calendar.current.component(.day, from: $0.date) == selectedDay
        }) {
            weekDays[index].isLearned = isLearned
            weekDays[index].isFreezed = isFreezed
        }
    }
    
    func updateSelectedDay(isLearned: Bool, isFreezed: Bool) {
        if let index = weekDays.firstIndex(where: {
            Calendar.current.isDate($0.date, inSameDayAs: currentDate)
        }) {
            weekDays[index].isLearned = isLearned
            weekDays[index].isFreezed = isFreezed
        }
    }
}
