//
//  sdgfjhakhdf.swift
//  MessageMe
//
//  Created by Aman Jain on 19/10/24.
//

import SwiftUI

//struct TitleMenuExample: View {
//    @State private var date = Date.now
//    @State private var datePickerShown = false
//    
//    var body: some View {
//        NavigationStack {
//            Text(date, style: .date)
//                .navigationTitle(Text(date, style: .date))
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbarTitleMenu {
//                    Button("Pick another date") {
//                        datePickerShown = true
//                    }
//                }
//                .sheet(isPresented: $datePickerShown) {
//                    DatePicker(
//                        "Choose date",
//                        selection: $date,
//                        displayedComponents: .date
//                    )
//                    .datePickerStyle(.graphical)
//                    .presentationDetents([.medium])
//                    .presentationDragIndicator(.visible)
//                }
//        }
//    }
//}

struct CollapsingToolbarItems: View {
    var body: some View {
        NavigationStack {
            Text("Hello")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Primary action") {}
                    }
                    
                    ToolbarItem(
                        id: "copy",
                        placement: .secondaryAction,
                        showsByDefault: true
                    ) {
                        Button("copy") {}
                    }
                    
                    ToolbarItem(
                        id: "delete",
                        placement: .secondaryAction,
                        showsByDefault: false
                    ) {
                        Button("delete") {}
                    }
                }
                .toolbarRole(.editor)
        }
    }
}

#Preview {
    CollapsingToolbarItems()
}
