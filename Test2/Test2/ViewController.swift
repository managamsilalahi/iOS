//
//  ViewController.swift
//  Test2
//
//  Created by Managam Silalahi on 11/7/16.
//  Copyright © 2016 Managam Silalahi. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var before: UILabel!
    @IBOutlet weak var after: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        before.text = readFile()
        after.text = ""
        
        print(rotateMatrix())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readFile() -> String {
        var fileContent = ""
        
        if let aStreamReader = StreamReader(path: "/Users/managam/Developer/Learning/iOS/Test2/Test2/data.txt") {
            defer {
                aStreamReader.close()
            }
            while let line = aStreamReader.nextLine() {
                fileContent += line + "\n"
            }
        }
        
        return fileContent
    }
    
    
    func readFileToCreateMatrix() -> [String] {
        var fileContent = [String]()
        
        if let aStreamReader = StreamReader(path: "/Users/managam/Developer/Learning/iOS/Test2/Test2/data.txt") {
            defer {
                aStreamReader.close()
            }
            while let line = aStreamReader.nextLine() {
                fileContent.append(line)
            }
        }
        
        return fileContent
    }
    
    func createMatrix() -> Array<Array <Int>> {
        let arrayOfStrings = readFileToCreateMatrix()
        
        var matrixArray = Array<Array <Int>>()
        for i in 0..<arrayOfStrings.count {
            let eachLine = Array(arrayOfStrings[i].components(separatedBy: " ")).map { Int($0)!}
            matrixArray.append(eachLine)
        }
        
        return matrixArray
    }
    
    func rotateMatrix() -> Array<Array <Int>> {
        let matrixArray = createMatrix()
        print("Matrix array \(matrixArray)")
        
        let numberOfRotate = matrixArray[0][2]
        print("Number of rotate \(numberOfRotate)")
        
        var matrix = Array<Array <Int>>()
        for i in 1..<matrixArray.count {
            matrix.append(matrixArray[i])
        }
        print("Matrix \(matrix)")
        
        let newMatrix = matrix.rotate(shift: numberOfRotate)
        print("New Matrix \(newMatrix)")
            
        return newMatrix
    }

}

extension Array {
    func rotate(shift:Int) -> Array {
        var array = Array()
        if (self.count > 0) {
            array = self
            if (shift > 0) {
                for _ in 1...shift {
                    array.append(array.remove(at: 0))
                }
            }
            else if (shift < 0) {
                for _ in 1...abs(shift) {
                    array.insert(array.remove(at: array.count-1),at:0)
                }
            }
        }
        return array
    }
}

