//
//  Enbording.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import SwiftUI

struct Enbording : View{
    @State private var course :String = ""
    @State private var selectedPeriod: String = "Week"
    var body : some View{
        
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 40){
                ZStack{
                    Circle()
                        . fill(.ultraThinMaterial)
                        .frame(width: 109 ,height: 109)
                        .shadow(color: .black.opacity(0.4), radius: 8, x:0 ,y:4)
                        .shadow(color: .black.opacity(0.3), radius: 2, x:0 ,y:1)
                    
                    
                    
                    //.shadow(radius: 8, x: 0 ,y: 4)
                    Image("Image1")
                        .resizable()
                        .frame(width: 50 ,height: 50)
                }
                //.padding(.top,60)
                .foregroundStyle(.clear)
                .glassEffect(.clear)
            
                
                
                //
                VStack(alignment: .leading ,spacing: 6){
                    Text("Hello Learner")
                        .font(.system(size: 34,weight: .bold))
                        .foregroundColor(.white)
                    Text("This app help you learn everyday!")
                        .font(.system(size: 17,weight: .regular))
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                }
                
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal,30)
                
                
                VStack(alignment: .leading, spacing: 10){
                    Text("I want to learn it in a")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    TextField("Swift",text: $course)
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.gray.opacity(0.5)),
                            alignment: .bottom
                        )
                }
                .padding(.horizontal,30)
                
                HStack {
                    ForEach(["Week", "Month", "Year"], id: \.self) { period in
                        Button(action: {
                            selectedPeriod = period
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
                
                //
                
                 Spacer()
                
                // زر Start learning
                
                Button(action: {
                 print("Start learning tapped for \(course) in \(selectedPeriod)")
                          }) {
                            Text("Start learning")
                 .font(.headline)
                                  .foregroundColor(.white)
                                  .frame(maxWidth: .infinity)
                                 .padding()
                                 .background(Color("Color"))
                                   .cornerRadius(25)
                                   .foregroundStyle(.clear)
                                   .glassEffect(.clear)
                                  
                         }
                
                // .frame(maxWidth: .infinity,alignment: .leading)
                  .padding(.horizontal,80)
                  .padding(.bottom )
                
            }
        }
        
    }
}
#Preview {
   Enbording()
        }
