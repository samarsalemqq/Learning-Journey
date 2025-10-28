//
//  WeekCalendarView.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import SwiftUI

struct WeekCalendarView: View {
    @EnvironmentObject var viewModel: LearningViewModel
    @State private var showDatePicker = false
    @State private var selectedDate = Date()

    let orderedDaysOfWeek = ["SUN","MON","TUE","WED","THU","FRI","SAT"]

    var body: some View {
        ZStack {
            // خلفية المربع الزجاجي للتقويم
            RoundedRectangle(cornerRadius: 25)
                .opacity(0.7) // الشفافية
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white.opacity(0.25), lineWidth: 1) // حدود بيضاء ناعمة
                )
                .padding(.horizontal, 10)
                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)

            VStack(spacing: 15) {
                // MARK: - Header
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            showDatePicker.toggle()
                        }
                    }) {
                        HStack(spacing: 6) { // 🔸 قللنا المسافة بين السهم والنص
                            Text(viewModel.monthAndYearString(for: selectedDate))
                                .foregroundColor(.white)
                                .font(.headline)
                            Image(systemName: showDatePicker ? "chevron.left" : "chevron.right")
                                .foregroundColor(.orange)
                                .font(.system(size: 13, weight: .semibold))
                        }
                    }

                    Spacer()

                    HStack(spacing: 12) {
                        Button(action: viewModel.prevWeek) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.orange)
                        }
                        Button(action: viewModel.nextWeek) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.orange)
                        }
                    }
                }
                .padding(.horizontal, 19)

               
                // MARK: - Week Days
                HStack(spacing: 10) {
                    ForEach(viewModel.weekDays.indices, id: \.self) { index in
                        let day = viewModel.weekDays[index]
                        VStack(alignment: .leading) {
                            Text(orderedDaysOfWeek[index])
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 2)
                            
                            // ✅ الألوان تجي من ViewModel
                            Text("\(Calendar.current.component(.day, from: day.date))")
                                .font(.headline)
                                .frame(width: 44, height: 44)
                                .background(
                                    Circle()
                                        .fill(viewModel.circleColor(for: day)) // ← من اللوجيك
                                )
                                .foregroundColor(viewModel.textColor(for: day)) // ← من اللوجيك
                        }
                    }
                }


                Divider()
                    .frame(height: 1) // ✅ سمك الخط
                    .background(Color.white.opacity(0.25)) // ✅ نفس لون الإطار الزجاجي
                    .padding(.horizontal, 22) // ✅ نفس الهوامش الداخلية

                // MARK: - Learning Title
                Text("Learning \(viewModel.learingGoal)")
                    .padding(.leading, -183)
                    .font(.headline)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 80)

                // MARK: - Stats Cards
                HStack(spacing: 15) {
                    // Learned
                    HStack {
                        Image("image1")
                            .resizable()
                            .frame(width: 25 , height: 25)
                            .foregroundColor(.orange)
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

                    // Freezed
                    HStack {
                        Image("Image2")
                            .foregroundColor(Color(red: 60/255, green: 221/255, blue: 254/255))
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
                .padding(.bottom, 0)
            }
            .padding(.vertical)
           
            // MARK: - Date Picker Overlay
            if showDatePicker {
                VStack {
                    VStack(spacing: 8) {
                        HStack(spacing: 6) {
                            Text(viewModel.monthAndYearString(for: selectedDate))
                                .foregroundColor(Color.white.opacity(0.9))
                                .font(.headline)

                            Button {
                                viewModel.currentDate = selectedDate
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    showDatePicker = false
                                }
                            } label: {
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 13, weight: .semibold))
                            }
                        }
                        .padding(.top, 8)

                      
                           
                        
                            .padding(.horizontal, 20)
                            .padding(.bottom, 3)

                        //  العجلة نفسها
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            displayedComponents: [.date]
                        )
                        .environment(\.colorScheme, .dark)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .background(Color.black.opacity(0.9))
                        .cornerRadius(14)
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .onChange(of: selectedDate) { newDate in
                            viewModel.currentDate = newDate
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black.opacity(0.9))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 40)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
                .zIndex(2)
                .animation(.easeInOut(duration: 0.25), value: showDatePicker)
            }
        }
    }
}

#Preview {
        CurrentDayDefault()
        .environmentObject(LearningViewModel())
        .preferredColorScheme(.dark)
   
}
