//
//  Bitmap.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation

typealias Bitmap = Matrix<Bool>

extension Matrix where Element == Bool {
    typealias Word = UnsignedInteger & FixedWidthInteger

    struct WordIterator<Element: Word>: IteratorProtocol {
        typealias IElement = Element

        private var bitmapIterator: Bitmap.Iterator

        init(_ bitmapIterator: Bitmap.Iterator) {
            self.bitmapIterator = bitmapIterator
        }

        mutating func next() -> IElement? {
            var iBit: Element = 0
            var word: Element = 0
            let wordWide = Element(Element.bitWidth)

            while let (_, _, bit) = bitmapIterator.next() {
                word = word ^ (Element(bit ? 1 : 0) << (wordWide - iBit - 1))
                iBit += 1
                if iBit == wordWide {
                    return word
                }
            }

            return iBit == 0 ? nil : word
        }
    }

    struct WordSequence<Element: Word>: Sequence {
        var iterator: WordIterator<Element>

        __consuming func makeIterator() -> WordIterator<Element> {
            iterator
        }
    }

    func byteSequence() -> WordSequence<UInt8> {
        return WordSequence(iterator: WordIterator<UInt8>(makeIterator()))
    }
}
