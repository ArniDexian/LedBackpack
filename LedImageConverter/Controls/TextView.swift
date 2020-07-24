//
//  TextView.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct TextView: NSViewRepresentable {
    typealias NSViewType = NSTextView

    var configuration = { (view: NSViewType) in }

    func makeNSView(context: NSViewRepresentableContext<Self>) -> NSViewType {
        NSViewType()
    }

    func updateNSView(_ uiView: NSViewType, context: NSViewRepresentableContext<Self>) {
        configuration(uiView)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView() { view in
            view.string = "super long \nbut not really\n text"
        }
    }
}
