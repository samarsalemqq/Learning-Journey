//
//  Untitled.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import SwiftUI

struct CurrentDayDefault: View {
    @EnvironmentObject private var viewModel: LearningViewModel
    @State private var showEditGoal: Bool = false
    @State private var isLearnedToday = false
    @State private var isFreezedToday = false
    @State private var showCalendar = false
    @State private var showGoalCompletedView = false


    
    var body: some View {
        ZStack {
            
            Color.black.ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            
            VStack(spacing: 10) {
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Activity")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        
                        Button(action: { showCalendar = true }) {
                            Image(systemName: "calendar")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(
                                    Circle()
                                        .foregroundStyle(.clear)
                                        .glassEffect(.clear)
                                )
                        }
                        .fullScreenCover(isPresented: $showCalendar) {
                            
                            AllActivitiesView()
                                .environmentObject(viewModel)
                        }
                        
                        
                        Button(action: { showEditGoal = true }) {
                            Image(systemName: "pencil.and.outline")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(
                                    Circle()
                                        .foregroundStyle(.clear)
                                        .glassEffect(.clear)
                                )
                        }
                        .fullScreenCover(isPresented: $showEditGoal) {
                            LearningGoalView()
                                .environmentObject(viewModel)
                        }
                    }
                }
                
               
                .padding(.horizontal, 20)
                
                Spacer().frame(height: 8)
                WeekCalendarView()
                  
              
                
              
                VStack(spacing: 15) {
                    
                //Log as Learned
                    Button(action: {
                        if !isLearnedToday && !isFreezedToday {
                            viewModel.logAsLearned()
                            isLearnedToday = true
                            viewModel.updateSelectedDay(isLearned: true, isFreezed: false)

                            
                            withAnimation(.easeInOut(duration: 0.25)) {
                                isLearnedToday = true
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation(.none) {
                                    showGoalCompletedView = true
                                }
                            }
                        }
                    }) {
                        Text(isLearnedToday ? "Learned\nToday" :
                                isFreezedToday ? "Day\nFreezed" :
                                "Log as\nLearned")
                            .font(.system(size: 36))
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 280, height: 280)
                            .background(
                                Circle()
                                    .fill(
                                        isLearnedToday
                                        ? Color(red: 0.35, green: 0.18, blue: 0.06)
                                        : isFreezedToday
                                        ? Color(red: 0.10, green: 0.25, blue: 0.32)
                                        : Color(red: 0.6, green: 0.25, blue: 0.05)
                                    )
                                    .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                                    .foregroundStyle(.clear)
                                    .glassEffect(.clear)

                                
                            )
                    }
                    .fullScreenCover(isPresented: $showGoalCompletedView) {
                        ActivityLastday()
                            .environmentObject(viewModel)
                            .transaction { transaction in
                                transaction.disablesAnimations = false
                            }
                    }


                    // FREEZE BUTTON
                    Button(action: {
                        if viewModel.freezeCount > 0 && !isFreezedToday && !isLearnedToday {
                            viewModel.logAsFreezed()
                            isFreezedToday = true
                            viewModel.updateSelectedDay(isLearned: true, isFreezed: false)

                        }
                    }) {
                        Text("Log as Freezed")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.clear)
                            .glassEffect(.clear)
                            .background(
                                Capsule()
                                    .fill(Color(red: 0.12, green: 0.45, blue: 0.52))
                                    
                            )
                    }
                    .padding(.horizontal, 50)
                    //.padding(.top, 20)
                    .disabled(viewModel.freezeCount == 0)
                    
                    // FREEZE COUNT TEXT
                    Text("\(2 - viewModel.freezeCount) out of 2 Freezes used")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    
                }
               // .padding(.top, 40)
                .padding(.bottom, 30)
                
            }
        }
    }
    
   
   
    

    }

    


#Preview {
    CurrentDayDefault()
        .environmentObject(LearningViewModel())
}
