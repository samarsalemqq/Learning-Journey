//
//  Untitled.swift
//  Learning Journey
//
//  Created by Samar A on 01/05/1447 AH.
//

import SwiftUI
 
struct CurrentDayDefault:View {
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            
            
            VStack(spacing: 20){
                Text("Activity")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
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
//
                            
                    }
                    Button(action: {}) {
                        Image(systemName: "pencil.and.outline")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .foregroundStyle(.clear)
                                    .glassEffect(.clear)
//                                    )
//                                    //.shadow(color: .white.opacity(0.1), radius: 5, x: 2, y: 2)
                            )
                            
                    }
                    
                   
                    
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
                .padding(.top, -60)
                .padding(.horizontal)
                
               WeekClalenderView()
                //LearningStatsView()
                Spacer()
                //LogButtons()
            }
            .padding(.top,40)
        }
    }
}
struct  WeekClalenderView: View {
    let days = ["SUN", "MON", "TUE","WED","THE","FRI", "SAT"]
    let detas = [20 ,21, 22, 23, 24, 25, 26  ]
    let selectedDay = 25
    
    let learnedDays: [Int] = [21,22,23,24]
    let freezedDays: [Int] = [20]
    var body: some View {
        VStack(alignment:.leading , spacing: 10){
            
            HStack(spacing: 10) {
                Text("October 2025")
                    .foregroundColor(.white)
                    .bold()
                
                
                Spacer()
                
                HStack(spacing: 12){
                    Image(systemName: "chevron.left")
                        .foregroundColor(.orange)
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.orange)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 12) {
                ForEach(Array(zip(days,detas)), id: \.0) { (day, date) in
                    VStack {
                        Text(day)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        
                        Text("\(date)")
                            .font(.headline)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(
                                        date == selectedDay ? Color.orange : circleColor(for: date)
                                    )
                            )
                            .foregroundColor(
                                date == selectedDay ? .white : textColor(for: date)
                            )
                    }
                }
                
            }
            Divider().background(Color.gray.opacity(0.4))
            
            Text("Learning Swift")
                .font(.headline)
                .foregroundColor(.white)
            HStack(spacing: 20){
                HStack{
                    Image("Image1")
                        .resizable()
                        .frame(width: 23 , height: 24)
                    VStack(alignment:.leading){
                        Text("3")
                            .font(.title2).bold()
                            .foregroundColor(.white)
                        Text("Day Learned")
                            .foregroundColor(.white)
                    }
                }
                
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color(red:0.30 , green: 0.20, blue:0.10))
                    
                )
                //.frame(minWidth: )
                
                HStack{
                    Image("Image2")
                    VStack(alignment: .leading){
                        Text("1")
                            .font(.title2).bold()
                            .foregroundColor(.white)
                        Text("Day Freezed")
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
            
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .fill(Color(red:0.08 , green:0.08 ,blue:0.08))
                .shadow(color: .white.opacity(0.1), radius: 5, x: 2, y: 2)
                .foregroundStyle(.clear)
               // .glassEffect(.clear)
        )
        
            
            

                
            
        
        
        Spacer()
        //padding(.horizontal)
            .padding(.top,400)
        
        
        //.background(Color.black.ignoresSafeArea())
        
    }
    
    func circleColor(for date : Int) -> Color {
        if learnedDays.contains(date){
            return   Color(red:0.30 , green: 0.20, blue:0.10)
            
        } else if  freezedDays.contains(date) {
            return Color(red: 0.12, green: 0.25, blue: 0.32)
        } else{
            return  Color(red:0.08 , green:0.08 ,blue:0.08)
        }
    }
    
    func textColor(for date: Int) -> Color {
        if freezedDays.contains(date) {
            return Color(red: 60/255, green: 221/255, blue: 254/255)
        } else if learnedDays.contains(date) {
            return Color(red: 255/255, green: 146/255, blue: 48/255)
        } else {
            return .white
        }
    }
}

    
    #Preview {
        CurrentDayDefault()
    }


