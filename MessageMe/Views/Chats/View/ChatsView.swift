//
//  ChatsView.swift
//  MessageMe
//
//  Created by Aman Jain on 11/10/24.
//

import SwiftUI

struct ChatsView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack{
                ForEach(0..<50) {_ in
                    ChatCardView()
                }
            }
        }
        .navigationTitle("MessageMe")
    }
}

#Preview {
    ChatsView()
        .environmentObject(LoginViewModel())
}


struct ChatCardView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            // profile pic
            Circle()
                .frame(width: 60)
            
            // name and last message
            VStack (alignment: .leading, spacing: 5){
                Text("John")
                    .fontWeight(.semibold)
                
                Text("Last Message to shown b sy t medfdfdsfr")
                    .lineLimit(1)
            }
            
            // time and msg count
            VStack(alignment: .trailing, spacing: 6){
                
                Text(String(describing: Date.now.formatted(
                    .dateTime
                        .hour(
                            // am/pm will not show
                            .twoDigits(amPM: .omitted))
                        .minute()
                )))
                .foregroundStyle(.accent)
                .font(.footnote)
                .bold()
                
                
                Text("26")
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 28, height: 28)
                    .foregroundStyle(.white)
                    .background(.accent)
                    .clipShape(Circle())
            }
            
            
            
        }
        .padding()
        
    }
}
