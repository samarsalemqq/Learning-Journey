//
//  WeekCalendarView.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import SwiftUI

struct WeekCalendarView: View {


@EnvironmentObject var viewModel: LearningViewModel
let daysOfWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

var body: some View {
    VStack(alignment: .leading, spacing: 10) {
        
        // Header
        HStack {
            Text("October 2025")
                .foregroundColor(.white)
                .font(.headline)
            VStack{
                Image(systemName: "chevron.right")
                    .foregroundColor(.orange)
                
            }
            Spacer()
            
            HStack(spacing: 12) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.orange)
                Image(systemName: "chevron.right")
                    .foregroundColor(.orange)
            }
        }
        .padding(.horizontal)
        
        // Week Days Row
        HStack(spacing: 12) {
            ForEach(viewModel.weekDays) { day in
                VStack(spacing: 4) {
                    Text(daysOfWeek[day.date % 7])
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("\(day.date)")
                        .font(.headline)
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .fill(viewModel.circleColor(for: day))
                        )
                        .foregroundColor(viewModel.textColor(for: day))
                }
            }
        }
        
        Divider().background(Color.gray.opacity(0.4))
        
        // Learning Swift Section
        Text("Learning Swift")
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal)
        
        HStack(spacing: 16) {
            // Days Learned
            HStack {
                Image("Image1")
                    .resizable()
                    .frame(width: 23, height: 24)
                VStack(alignment: .leading) {
                    Text("\(viewModel.weekDays.filter { $0.isLearned }.count)")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                    Text("Days Learned")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color(red: 0.30, green: 0.20, blue: 0.10))
            )
            
            // Days Freezed
            HStack {
                Image("Image2")
                    .resizable()
                    .frame(width: 23, height: 24)
                VStack(alignment: .leading) {
                    Text("\(viewModel.weekDays.filter { $0.isFreezed }.count)")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                    Text("Days Freezed")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color(red: 0.12, green: 0.25, blue: 0.32))
            )
        }
        .padding(.horizontal)
    }
    .padding(.vertical)
}


}

#Preview {
WeekCalendarView()
.environmentObject(LearningViewModel())
.background(Color.black)
}
