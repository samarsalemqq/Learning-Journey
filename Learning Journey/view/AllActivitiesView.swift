//
//  AllActivitiesView.swift
//  Learning Journey
//
//  Created by Samar A on 05/05/1447 AH.
//

import SwiftUI

struct AllActivitiesView: View {
    @EnvironmentObject private var viewModel: LearningViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showCalendar = false
    
    
    
    private var months: [String] {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: viewModel.currentDate)
        let monthSymbols = calendar.monthSymbols
        return monthSymbols.map { "\($0) \(currentYear)" }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    Spacer().frame(height: 90)
                    
                    ForEach(months, id: \.self) { month in
                        VStack(alignment: .leading, spacing: 16) {
                            Text(month)
                                .font(.title3.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            
                                MonthCalendarView()
                                .environmentObject(viewModel)
                        }
                    }
                    
                    Spacer().frame(height: 50)
                }
            }
            
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                    
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .background(
                            Circle()
                                .frame(width: 44 , height: 44)
                                .foregroundStyle(.clear)
                                .glassEffect(.clear))
                }
                
                Spacer()
                
                Text("All activities")
                    .font(.headline)
                    .foregroundColor(.white)
                
                
                Spacer()
                
            }
            .frame(height: 90)
            //.padding(.top, 10)
        }
    }
}

#Preview {
    AllActivitiesView()
        .environmentObject(LearningViewModel())
    

}
 //بس سيطلع السنوات  والشهر بدون الكالندر للايام
