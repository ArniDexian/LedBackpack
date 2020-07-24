//
//  Matrix.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation

struct Matrix<Element> {
    private var data: [[Element]]

    var rows: Int {
        return data.count
    }

    var columns: Int {
        return data.first?.count ?? 0
    }

    subscript (i: Int, j: Int) -> Element {
        get {
            return data[i][j]
        }
        set {
            data[i][j] = newValue
        }
    }

    init(data: [[Element]]) throws {
        guard data.count > 0, data.first?.count ?? 0 > 0 else {
            throw CoreError.failure("Failed to create Matrix with some dimension equal to 0")
        }
        self.data = data
    }

    init(rows: Int, columns: Int, repeating: Element) {
        data = (0..<rows).map { row in
            Array(repeating: repeating, count: columns)
        }
    }

    init(rows: Int, columns: Int, data: [Element]) throws {
        guard rows * columns == data.count else {
            throw CoreError.failure("Failed to create Matrix as columns and rows doesn't matxh data's size")
        }
        self.data = (0..<rows).map { row in
            Array(data[row * columns..<(row * columns + columns)])
        }
    }
}

extension Matrix: Sequence {
    struct Iterator: IteratorProtocol {
        typealias IElement = (row: Int, column: Int, data: Element)
        private let matrix: Matrix<Element>
        private var i: Int = 0
        private var j: Int = -1
        private let columns: Int
        private let rows: Int

        init(_ matrix: Matrix<Element>) {
            self.matrix = matrix
            self.columns = matrix.columns
            self.rows = matrix.rows
        }

        mutating func next() -> IElement? {
            j += 1
            if j >= columns {
                i += 1
                j = 0
            }

            if i >= rows {
                return nil
            }

            return (i, j, matrix[i, j])
        }
    }

    __consuming func makeIterator() -> Iterator {
        Iterator(self)
    }
}

extension Matrix {
    subscript (safe i: Int, j: Int) -> Element? {
        get {
            guard i >= 0, i < rows, j >= 0, j < columns else { return nil}
            return self[i, j]
        }
        set {
            guard let newValue = newValue, i >= 0, i < rows, j >= 0, j < columns else { return }
            self[i, j] = newValue
        }
    }

    mutating func resize(to size: PointSize, defaultValue: Element) {
        var newMatrix = Matrix(rows: size.rows, columns: size.columns, repeating: defaultValue)

        forEach { (arg) in
            newMatrix[safe: arg.row, arg.column] = arg.data
        }

        data = newMatrix.data
    }
}
