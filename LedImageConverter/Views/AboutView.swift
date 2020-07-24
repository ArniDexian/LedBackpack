//
//  AboutView.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading) {
            CircleImage()
                .frame(height: 300)
            Text("eBackpack Project!")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.green)
            HStack {
                Text("This is OSX app for debugging Arduino's codebase")
                    .font(.subheadline)
                Text("😎")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
