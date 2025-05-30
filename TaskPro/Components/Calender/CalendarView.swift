//
//  CalendarView.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 26/5/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentMonth = Date.now
    @State private var selectedDate = Date.now
    @State private var days: [Date] = []
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var onDateSelected: (Date) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(currentMonth.formatted(.dateTime.year().month()))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.primary)
                Spacer()
                Button {
                    currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth)!
                    updateDays()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
                Button {
                    currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth)!
                    updateDays()
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
            }
            

            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(days, id: \.self) { day in
                    Button {
                        if day >= Date.now.startOfMonth && day.monthInt == currentMonth.monthInt {
                            selectedDate = day
                            onDateSelected(selectedDate)
                        }
                    } label: {
                        Text(day.formatted(.dateTime.day()))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(foregroundStyle(for: day))
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                        day.formattedDate == selectedDate.formattedDate
                                            ? .blue
                                            : .clear
                                    )
                            )
                    }
                    .disabled(day < Date.now.startOfMonth /*|| day.monthInt != currentMonth.monthInt*/)
                }
            }
            
//            DatePicker(
//                "",
//                selection: $selectedHour,
//                displayedComponents: [.hourAndMinute]
//            )
//            .onChange(of: selectedHour) {
//                onDateSelected(selectedDate, selectedHour)
//            }
//            .datePickerStyle(.compact)
//            .datePickerStyle(GraphicalDatePickerStyle())
//            .colorMultiply(.white)
//            .environment(\.colorScheme, .dark)
        }
        .padding()
        .onAppear {
            updateDays()
            onDateSelected(selectedDate)
        }
    }
    
    private func updateDays() {
        days = currentMonth.calendarDisplayDays
    }
    
    private func foregroundStyle(for day: Date) -> Color {
        let isDifferentMonth = day.monthInt != currentMonth.monthInt
        let isSelectedDate = day.formattedDate == selectedDate.formattedDate
        let isPastDate = day < Date.now.startOfDay
        
        if isDifferentMonth {
            return isSelectedDate ? .white : .primary.opacity(0.3)
//        } else if isPastDate {
//            return .white.opacity(0.3)
        } else {
            return isSelectedDate ? .white : .primary
        }
    }
}
