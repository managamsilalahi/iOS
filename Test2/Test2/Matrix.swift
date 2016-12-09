//
//  Matrix.swift
//  Test2
//
//  Created by Managam Silalahi on 11/7/16.
//  Copyright © 2016 Managam Silalahi. All rights reserved.
//

import Foundation

class Matrix {
    var n = 0
    private var matrix: Array<Array <Int>>
    
    init(n: Int) {
        self.n = n
        self.matrix = Matrix.create(n: n)
    }
    
    func toString() -> String {
        var str = ""
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                str += String(matrix[i][j]) + " "
            }
            str += "\n"
        }
        
        return str
    }
    
    func rotate( _ degrees: Int = 90) {
        var degrees = degrees
        if degrees % 90 != 0 {
            NSException(name: NSExceptionName(rawValue: "Disallowed"), reason: "Not able to rotate a matrix \(degrees) degrees", userInfo: nil).raise()
        }
        
        var turns = degrees / 90
        
        while turns > 0 {
            turns -= 1
            rotate90Degrees()
        }
    }
    
    func rotate90Degrees() {
        for layer in 0..<n/2 {
            var first = layer
            var last = n - 1 - layer
            
            for i in first..<last {
                var offset = i - first
                var top = matrix[first][i]
                
                // top is now left
                matrix[first][i] = matrix[last - offset][first]
                // left is now bottom
                matrix[last - offset][first] = matrix[last][last - offset]
                // bottom is now right
                matrix[last][last - offset] = matrix[i][last]
                // right is now top
                matrix[i][last] = top
            }
        }
    }
    
    private class func create(n: Int) -> Array<Array <Int>> {
        var newMatrix = Array<Array <Int>>()
        
        for i in 0..<n {
            newMatrix.append(Array(repeating: 0, count: n))
            
            for j in 0..<n {
                newMatrix[i][j] = Int(arc4random_uniform(9)) + 1
            }
        }
        
        return newMatrix
    }
}
