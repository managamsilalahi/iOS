//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Managam Silalahi on 9/9/16.
//  Copyright © 2016 Managam Silalahi. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String, Double> = [
        "π" : M_PI,
        "e" : M_E,
        "√" : sqrt,
        "cos" : cos
    ]
    
    enum Operation {
        case Constant
        case UnaryOperation
        case BinaryOperation
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let constant = operations[symbol] {
            accumulator = constant
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}