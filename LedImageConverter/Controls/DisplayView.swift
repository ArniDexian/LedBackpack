//
//  DisplayView.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 04/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

final class DisplayController: Display, ObservableObject {
    var matrix: Matrix<NSColor>

    init(matrix: Matrix<NSColor>) {
        self.matrix = matrix
    }

    init(rows: Int, columns: Int) {
        self.matrix = Matrix(rows: rows, columns: columns, repeating: .black)
    }

    func set(color: NSColor, row: Int, column: Int) {
        matrix[row, column] = color
    }

    func flush() {
        objectWillChange.send()
    }

    func clear() {
        matrix.forEach { (r, c, _) in
            self.matrix[r, c] = .black
        }
        objectWillChange.send()
    }
}

struct DisplayView: View {
    @ObservedObject var controller: DisplayController

    var body: some View {
        GridStack(rows: controller.matrix.rows, columns: controller.matrix.columns) { row, column in
            Rectangle()
                .fill(Color(self.controller.matrix[self.controller.matrix.rows - 1 - row, column]))
        }
        .aspectRatio(CGFloat(controller.matrix.rows) / CGFloat(controller.matrix.columns),
                     contentMode: .fit)
    }

    init(controller: DisplayController) {
        self.controller = controller
    }

    init(matrix: Matrix<NSColor>) {
        self.init(controller: DisplayController(matrix: matrix))
    }

    init(rows: Int, columns: Int) {
        self.init(controller: DisplayController(rows: rows, columns: columns))
    }
}
