//
//  Untitled.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import SwiftUI


struct CurrentDayDefault:View {
    @EnvironmentObject private var viewModel: LearningViewModel
    @State private var showEditGoal: Bool = false
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            
            
            VStack(spacing: 20){
                Text("Activity")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,40)
                
                
                
                HStack(spacing:10){
                    Button(action:{}){
                        Image(systemName: "calendar")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .frame(width: 44 , height: 44)
                            .background(
                                Circle()
                                    .foregroundStyle(.clear)
                                    .glassEffect(.clear))
                        
                    }
                    Button(action: {showEditGoal = true}) {
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
                    .sheet(isPresented: $showEditGoal){
                        LearningGoalView()
                            .environmentObject(viewModel)
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
                .padding(.top, -60)
                .padding(.horizontal,30)
                
                
                WeekCalendarView()
              
                   
                //LearningStatsView()
                Spacer()
                //LogButtons()
                VStack(spacing: 25){
                    Button(action:{viewModel.logAsLearned() }){
                        Text("Log as\nLearned")
                            //.font(.title)
                            .font(.system(size: 36))
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 280 , height: 280)
                        
                            .background(
                              Circle()
                              .fill(Color(red: 0.6, green: 0.25, blue: 0.05))                  .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                            .foregroundStyle(.clear)
                             .glassEffect(.clear)
                                                       )
                    }
                                            Button(action: { viewModel.logAsFreezed() }) {
                                            Text("Log as Freezed")
                                                .bold()
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity)
                                                .padding()
                                                .background(
                                                     Capsule()
                                                        .fill(Color(red: 0.12, green: 0.45, blue: 0.52))
                                                        .foregroundStyle(.clear)
                                                        .glassEffect(.clear)
                                                )
                                        }
                                        .padding(.horizontal, 50)
                                        
                                        .disabled(viewModel.freezeCount == 0)
                                                            .padding(.horizontal, 50)
                                                            
                                                            Text("\(viewModel.freezeCount) out of 2 Freezes used")
                                                                .font(.footnote)
                                                                .foregroundColor(.gray)
                                    }
                                    .padding(.bottom, 40)
                                }
                                .padding(.top, 40)
                            }
                        }
                    }

                
       
    #Preview {
        CurrentDayDefault()
            .environmentObject(LearningViewModel())
        
    }
