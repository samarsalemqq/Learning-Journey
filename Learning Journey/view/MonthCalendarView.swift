//
//  MonthCalendarView.swift
//  Learning Journey
//
//  Created by Samar A on 05/05/1447 AH.
//

import SwiftUI

struct MonthCalendarView: View {
    @EnvironmentObject private var viewModel: LearningViewModel
    private let daysOfWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    private var monthDays: [Int] {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: viewModel.selectedYear, month: viewModel.selectedMonth)
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return Array(range)
    }
    
    private var firstWeekdayOfMonth: Int {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(year: viewModel.selectedYear, month: viewModel.selectedMonth, day: 1)
        let date = calendar.date(from: dateComponents)!
        return calendar.component(.weekday, from: date)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(0..<(firstWeekdayOfMonth - 1), id: \.self) { _ in
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 36, height: 36)
                }
                
                // الأيام الفعلية
                ForEach(monthDays, id: \.self) { day in
                    let calendar = Calendar.current
                    
                    if let fullDate = calendar.date(from: DateComponents(
                        year: viewModel.selectedYear,
                        month: viewModel.selectedMonth,
                        day: day
                    )) {
                        let dayStatus = viewModel.weekDays.first {
                            calendar.isDate($0.date, inSameDayAs: fullDate)
                        }

                        let isLearningMonth = calendar.component(.month, from: viewModel.currentDate) == viewModel.selectedMonth
                        let color = isLearningMonth ? viewModel.circleColor(for: dayStatus ?? DayStatus(date: fullDate)) : Color(red: 0.08, green: 0.08, blue: 0.08)
                        let textColor = isLearningMonth ? viewModel.textColor(for: dayStatus ?? DayStatus(date: fullDate)) : .white.opacity(0.4)
                        
                        Circle()
                            .fill(color)
                            .frame(width: 36, height: 36)
                            .overlay(
                                Text("\(day)")
                                    .foregroundColor(textColor)
                                    .font(.system(size: 14, weight: .semibold))
                            )
                    }
                }

                    }
                }
            }
        }
    
