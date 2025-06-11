//
//  TaskListCellView.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 21/5/25.
//

import SwiftUI

struct TaskListCellView: View {
    
    var list : TaskListModel
    
    var body: some View {
            ZStack(alignment: .leading) {
                Image("taskListBg")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                VStack(alignment: .leading) {
                    Text(list.title)
                        .font(.system(size: 33))
                        .fontWeight(.semibold)
                        .foregroundStyle(.whiteLevel2)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 30)
                    
                    Spacer()
                    
                    Text(list.createdAt.formatted(.dateTime.year().month().day()))
                        .foregroundStyle(.whiteLevel2)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 30)
                }
                
                
            
            }.frame(width: 250, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


#Preview {
    let list = TaskListModel(title: "akram")
    TaskListCellView(list: list)
}
