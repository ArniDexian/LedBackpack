//
//  ContentView.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selectedMenu: MenuItem = appModel.preselectedMenu

    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                ForEach(MenuItem.all) { item in
                    Text(item.title)
                        .fontWeight(.semibold)
                        .frame(height: 30, alignment: .leading)
                        .foregroundColor(self.selectedMenu == item ? .green : .white)
                        .onTapGesture {
                            self.selectedMenu = item
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.menuBackground)
            selectedMenu.view.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.frame(minWidth: 640, minHeight: 480)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
