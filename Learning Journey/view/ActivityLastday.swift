//
//  FireButtonView.swift
//  Learning Journey
//
//  Created by Samar A on 05/05/1447 AH.
//

import SwiftUI

struct ActivityLastday: View {
    @EnvironmentObject private var viewModel: LearningViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showEditGoal = false
    @State private var showCalendar = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .navigationBarBackButtonHidden(true)

            VStack(spacing: 10) {
                
                // MARK: - Header
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
                    .environmentObject(viewModel)
            
                VStack(spacing: 15) {
                    Image("image3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 41)
                        .padding(.bottom, 10)
                    
                    Text("Well Done!")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Goal completed! Start learning again or set a new learning goal.")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding(.horizontal, 40)
                }
                .padding(.top, 10)
                
                // MARK: - Buttons Section
                VStack(spacing: 15) { //  نفس المسافات بين الأزرار
                    NavigationLink(destination: Enbording().environmentObject(viewModel)) {
                        Text("Set new learning goal")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(Color("Color"))
                                    .foregroundStyle(.clear)
                                    .glassEffect(.clear)
                            )
                            .padding(.horizontal,50)
                            .padding(.top, 60)
                        
                    }
                    Spacer()
                    Divider()
                        .frame(height: 2)
                        .background(Color("Color1"))
                        .padding(.horizontal, 10)
                    
                    Button(action: { dismiss() }) {
                        Text("Set same learning goal and duration")
                            .foregroundColor(Color("Color"))
                    }
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color("Color1"))
                        .padding(.horizontal, 10)
                }
                .padding(.bottom, 30) 
            }
        }
    }
}

#Preview {
    ActivityLastday()
        .environmentObject(LearningViewModel())
}
