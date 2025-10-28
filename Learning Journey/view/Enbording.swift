//
//  Enbording.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import SwiftUI

struct Enbording: View {
    
    @EnvironmentObject var viewModel: LearningViewModel
    @State private var course: String = ""
    @State private var selectedPeriod: String = ""
    @State private var navigateToMain = false
    
    let periods = ["Week", "Month", "Year"]
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(alignment:.leading,spacing: 40) {
                    
                    
                    
                    ZStack {
                        Circle()
                            .frame(width: 109, height: 109)
                            .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 4)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                            .foregroundStyle(.clear)
                            .glassEffect(.clear)
                        
                        Image("image1")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    
                    .frame(maxWidth: .infinity)
                    .padding(.top,60)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Hello Learner")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                        Text("This app helps you learn everyday!")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    //.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("I want to learn")
                            .foregroundColor(.white)
                            .font(.system(size: 22,weight:.regular))
                        
                        TextField("Swift", text: $course)
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.gray.opacity(0.5)),
                                alignment: .bottom
                            )
                        
                    }
                    
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("I want to learn it in a ")
                            .font(.system(size: 22,weight:.regular))
                            .foregroundColor(.gray)
                            .padding(.horizontal,20)
                        
                        HStack(spacing: 5) {
                            
                            ForEach(periods, id: \.self) { period in
                                Button(action: {
                                    selectedPeriod = period
                                }) {
                                    Text(period)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .frame(width: 97, height: 48)
                                        .background(
                                            selectedPeriod == period ?
                                            Color("Color") :
                                                Color("")
                                        )
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                        .foregroundStyle(.clear)
                                        .glassEffect(.clear)
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                        .padding(.leading, 20)
                    }
                    Spacer()
                    
                    Button(action: {
                        viewModel.learingGoal = course
                        viewModel.learningDuration = selectedPeriod
                        viewModel.configureFreezesForDuration()
                        
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = windowScene.windows.first {
                            window.rootViewController = UIHostingController(
                                rootView: CurrentDayDefault()
                                    .environmentObject(viewModel)
                                    .navigationBarBackButtonHidden(true) // 🔹 يخفي السهم
                            )
                            window.makeKeyAndVisible()
                        }
                    }) {
                        
                            Text("Start Learning")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    (course.isEmpty || selectedPeriod.isEmpty)
                                    ? Color.gray.opacity(0.4)
                                    : Color("Color")
                                )
                                .cornerRadius(25)
                                .foregroundStyle(.clear)
                                .glassEffect(.clear)
                        }
                        .disabled(course.isEmpty || selectedPeriod.isEmpty)
                        .padding(.horizontal, 80)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity)
                        
                        
                        
                    }
                }
                
            }
        }
    }

    

#Preview {
    Enbording()
        .environmentObject(LearningViewModel())
}
