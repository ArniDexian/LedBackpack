//
//  FontEditorGrid.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct FontEditorGrid: View {
    @Binding var matrix: Bitmap

    var rows: Int {
        return matrix.rows
    }

    var columns: Int {
        return matrix.columns
    }

    var body: some View {
        GeometryReader { geometry in
            GridStack(rows: self.rows, columns: self.columns) { row, column in
                Rectangle()
                    .fill(self.matrix[row, column] ? Color.fontGridFilled : Color.fontGridEmpty)
                    .onTapGesture {
                        self.matrix[row, column] = !self.matrix[row, column]
                }
            }
            .aspectRatio(CGFloat(self.columns) / max(CGFloat(self.rows), 1), contentMode: .fit)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ (value) in
                        let rectSize = CGSize(width: geometry.size.width / CGFloat(self.columns),
                                              height: geometry.size.height / CGFloat(self.rows))
                        let (c, r) = (Int(value.location.x / rectSize.width),
                                      Int(value.location.y / rectSize.height))
                        if c >= 0, c < self.columns, r >= 0, r < self.rows {
                            self.matrix[r, c] = true
                        }
                    })
            )
        }
    }
}
