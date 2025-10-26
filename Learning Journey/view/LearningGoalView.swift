//
//  LearningGoal.swift
//  Learning Journey
//
//  Created by Samar A on 03/05/1447 AH.
//

import SwiftUI
import UIKit

struct LearningGoalView: View {
    @EnvironmentObject var viewModel: LearningViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var course: String = ""
    @State private var selectedPeriod: String = "Week"
    @State private var showCheckmark: Bool = false
    @State private var showPopup: Bool = false
    
    var body: some View {
        ZStack {
           Color.black.ignoresSafeArea()
            
            
            VStack(alignment: .leading, spacing: 30) {
                // MARK: - Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(8)
                            .background(
                                Circle()
                                    .frame(width: 44 , height: 44)
                                    .foregroundStyle(.clear)
                                    .glassEffect(.clear))
                    }
                    
                    Spacer()
                    
                    Text("Learning Goal")
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                    
                    if showCheckmark {
                        Button(action: {
                            withAnimation(.spring()) {
                                showPopup = true
                            }
                        }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .foregroundColor(Color("Color"))
                                        .frame(width: 40 ,height: 40)
                                )
                        }
                        .transition(.opacity)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)
                
                // MARK: - Content
                VStack(alignment: .leading, spacing: 15) {
                    Text("I want to learn ")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .regular))
                    
                    TextField("", text: $course)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.gray.opacity(0.5)),
                            alignment: .bottom
                        )
                        .onChange(of: course) { _ in
                            showCheckmark = true
                        }
                    
                    Text("I want to learn it in a ")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .regular))
                    
                    HStack {
                        ForEach(["Week", "Month", "Year"], id: \.self) { period in
                            Button(action: {
                                selectedPeriod = period
                                showCheckmark = true
                            }) {
                                Text(period)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .frame(width: 90, height: 44)
                                    .background(
                                        selectedPeriod == period ?
                                        Color("Color") :
                                        Color(.darkGray)
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .foregroundStyle(.clear)
                                    .glassEffect(.clear)
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)
                Spacer()
            }
            .onAppear {
                course = viewModel.learingGoal
                selectedPeriod = "Week"
                showCheckmark = false
            }
            
            // ✅ الآن البوب-أب خارج الـ VStack علشان يغطي الشاشة كلها
            if showPopup {
                ZStack {
                    // خلفية مغبشة + تعتيم يغطي الشاشة بالكامل
                    VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation { showPopup = false }
                        }
                    
                    // مربع البوب-أب في المنتصف
                    VStack(spacing: 16) {
                        Text("Update Learning goal")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("If you update now, your streak will start over.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        HStack(spacing: 16) {
                            Button(action:{
                                withAnimation {
                                    showPopup = false
                                }
                            }) {
                                Text("Dismiss")
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(.darkGray))
                                    .cornerRadius(30)
                                    .glassEffect(.clear)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    viewModel.learingGoal = course
                                    showPopup = false
                                    dismiss()
                                }
                            }) {
                                Text("Update")
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("Color"))
                                    .cornerRadius(30)
                                    .glassEffect(.clear)
                            }
                        }
                    }
                    .padding()
                    .frame(width: 320)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .transition(.scale)
                }
                .zIndex(999) // فوق كل شيء
                .animation(.easeInOut, value: showPopup)
            }
        }
    }
}

// MARK: - Blur Helper
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}

#Preview {
    LearningGoalView()
        .environmentObject(LearningViewModel())
}
