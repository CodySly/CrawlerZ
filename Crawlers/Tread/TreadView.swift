//
//  TreadView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/24/24.
//

import SwiftUI

struct TreadView: View {
    @StateObject var viewModel = MessageViewModel()  // Ensure ViewModel is properly defined
    
    var body: some View {
        ZStack {
            // Navigation and content setup
            NavigationView {
                VStack {
                    List(viewModel.messages) { message in
                        Text(message.content)
                            .padding()
                            .background(Image("TT").opacity(0.5))  // Optional: Makes text easier to read
                            .cornerRadius(15)
                    }
                    .background(Image("TT").aspectRatio(contentMode: .fill).ignoresSafeArea(.all))  // Ensure the list is transparent
                    .cornerRadius(50)
                    .padding()
                    
                    HStack {
                        TextField("Type your message here...", text: $viewModel.newMessageContent)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            viewModel.postMessage()
                        }) {
                            Image(systemName: "paperplane.fill")
                        }
                        .padding()
                        .disabled(viewModel.newMessageContent.isEmpty)
                        .foregroundColor(.blue)
                    }
                    .padding(2.5)
                    .background(Color.gray.opacity(0.5))  // Optional: Makes input area easier to see
                    .cornerRadius(15)
                    .padding(2.5)
                }
                .navigationBarTitle("Treads", displayMode: .inline)
                .background(Color.gray.opacity(0.5))
            }
            .navigationViewStyle(StackNavigationViewStyle())  // Ensure style doesn't interfere on iPads
        }
    }
}

#Preview {
    TreadView()
}
