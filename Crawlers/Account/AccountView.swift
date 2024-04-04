//
//  accountView.swift
//  Crawlers
//
//  Created by Cody Burgess on 4/1/24.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button("HomePage") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    AccountView()
}
