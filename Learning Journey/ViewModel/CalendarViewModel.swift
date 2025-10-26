//
//  CalendarViewModel.swift
//  Learning Journey
//
//  Created by Samar A on 03/05/1447 AH.
//

//import SwiftUI
//import Combine
//
//  class CalendarViewModel: ObservableObject{
//    @Published var currentDate:Date = Date()
//    @Published var showMonthYearPicke  : Bool = false
//    
//    
//    private let calender = Calendar.current
//    
//    
//    
//    var monthName : String{
//        let Formatter = DateFormatter()
//        Formatter.dateFormat="MMMM"
//        return Formatter.string(from: currentDate)
//        
//    }
//    
//    var year : Int{
//        calender.component(.year, from: currentDate)
//    }
//    
//    var currentWeekDays :[Data]{
//        let startOfWeek = calendar.dateInterval(of: .weekOfMonth, for: currentDate)?.start ?? Date()
//             return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
//         }
//    func nextWeek(){
//        if let previous = calendar.date(byAdding: .weekOfMonth, value: -1, to: currentDate) {
//                    currentDate = previous
//                }
//            }
//           
//            func changeMonth(to month: Int, year: Int) {
//                var components = calendar.dateComponents([.year, .month, .day], from: currentDate)
//                components.year = year
//                components.month = month
//                if let newDate = calendar.date(from: components) {
//                    currentDate = newDate
//                }
//            }
//            
//            func shortDayName(for date: Date) -> String {
//                let formatter = DateFormatter()
//                formatter.dateFormat = "EEE"
//                return formatter.string(from: date).uppercased()
//            }
//            
//            func dayNumber(for date: Date) -> String {
//                "\(calendar.component(.day, from: date))"
//            }
//            
//            func isToday(_ date: Date) -> Bool {
//                calendar.isDateInToday(date)
//            }
//        }
//}
//
