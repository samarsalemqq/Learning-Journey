//
//  MonthYearPicker.swift
//  Learning Journey
//
//  Created by Samar A on 03/05/1447 AH.
//

import SwiftUI

struct MonthYearPicker: View {
    @EnvironmentObject var viewModel: LearningViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedDate: Date
    var onDone: (Int, Int) -> Void // year, month
    
    @State private var selectedMonthIndex: Int
    @State private var selectedYear: Int
    
    private var months: [String] {
        let fmt = DateFormatter()
        return fmt.monthSymbols
    }
    
    private var years: [Int] {
        // نطاق سنوات معقول (مثلاً من 2000 إلى 2035)
        Array(2000...2035)
    }
    
    init(selectedDate: Binding<Date>, onDone: @escaping (Int, Int) -> Void) {
        self._selectedDate = selectedDate
        let comps = Calendar.current.dateComponents([.year, .month], from: selectedDate.wrappedValue)
        _selectedMonthIndex = State(initialValue: (comps.month ?? 1) - 1)
        _selectedYear = State(initialValue: comps.year ?? Calendar.current.component(.year, from: Date()))
        self.onDone = onDone
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Picker(selection: $selectedMonthIndex, label: Text("Month")) {
                        ForEach(0..<months.count, id: \.self) { idx in
                            Text(months[idx]).tag(idx)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: .infinity)
                    
                    Picker(selection: $selectedYear, label: Text("Year")) {
                        ForEach(years, id: \.self) { y in
                            Text("\(y)").tag(y)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: .infinity)
                }
                .padding()
                Spacer()
            }
            .navigationBarTitle("Select Month & Year", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Done") {
                let month = selectedMonthIndex + 1
                onDone(selectedYear, month)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
