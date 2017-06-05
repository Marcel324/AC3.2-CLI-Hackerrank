//
//  main.swift
//  CLI-Hackerrank
//
//  Created by Jason Gresh on 4/20/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

var funk: [String:()->Void] = [:]

func solveMeFirst() {
    // read integers line by line
    let a = Int(readLine()!)!
    let b = Int(readLine()!)!
    
    // Hint: Type print(a + b) below
    print(a+b)
}
funk["solve"] = solveMeFirst

// https://www.hackerrank.com/challenges/simple-array-sum
//
// Input

/*
6
1 2 3 4 10 11
*/

// Output
// 31

func simpleArraySum() {
    let _ = Int(readLine()!)!
    var sum = 0
    // read array and map the elements to integer
    if let input = readLine() {
        let arr = input.components(separatedBy: " ").map {
            Int($0)!
        }
        sum = arr.reduce(0) { (r, n) -> Int in
            return r + n
        }
    }

    print(sum)
}
funk["simpleArraySum"] = simpleArraySum

func hourglass() {
    func findMaxSum(arr: [[Int]], filter: [[Int]]) -> Int {
        var maxSum = Int.min
        for i in 0...(arr.count - filter.count) {
            for j in 0...(arr[i].count - filter[0].count) {
                var sum = 0
                for k in 0..<filter.count {
                    for l in 0..<filter[k].count {
                        sum += arr[i+k][j+l] * filter[k][l]
                    }
                }
                if sum > maxSum {
                    maxSum = sum
                }
            }
        }
        return maxSum
    }
    
    var matrix: [[Int]] = []
    for _ in 0..<6 {
        let arr = readLine()!.components(separatedBy: " ").map{ Int($0)! }
        matrix.append(arr)
    }
    
    let filter = [[1, 1, 1],
                  [0, 1, 0],
                  [1, 1, 1]]
    
    print(findMaxSum(arr: matrix, filter: filter))
}
funk["hourglass"] = hourglass

func maximumElement() {
    let n = Int(readLine()!)!
    var max = Int.min
    // read array and map the elements to integer
    var stack: [Int] = []
    
    for _ in 0..<n {
        //print(stack)
        if let input = readLine() {
            let arr = input.components(separatedBy: " ").map {
                Int($0)!
            }
            
            if arr[0] == 1 {
                if arr[1] > max {
                    max = arr[1]
                }
                stack.append(arr[1])
            }
            
            if arr[0] == 2 && !arr.isEmpty {
                if stack.last! == max {
                    let _ = stack.popLast()!
                    max = stack.max()!
                } else {
                    let _ = stack.popLast()!
                }
            }
            
            if arr[0] == 3 {
                print(max)
            }
        }
    }
}
funk["maximumElement"] = maximumElement

func equalStacks() {
    let n = readLine()!
    
    var stackOne:(stack: [Int], height: Int) = (readLine()!.components(separatedBy: " ").map{ Int($0)! }.reversed(), 0)
    var stackTwo:(stack: [Int], height: Int) = (readLine()!.components(separatedBy: " ").map{ Int($0)! }.reversed(), 0)
    var stackThree:(stack: [Int], height: Int) = (readLine()!.components(separatedBy: " ").map{ Int($0)! }.reversed(), 0)
    
    stackOne.height = stackOne.stack.reduce(0, +)
    stackTwo.height = stackTwo.stack.reduce(0, +)
    stackThree.height = stackThree.stack.reduce(0, +)
    
    while !(stackOne.height == stackTwo.height && stackTwo.height == stackThree.height) {
        if stackOne.height >= stackTwo.height && stackOne.height >= stackThree.height {
            stackOne.height -= stackOne.stack.popLast()!
            continue
        }
        
        if stackTwo.height >= stackOne.height && stackTwo.height >= stackThree.height {
            stackTwo.height -= stackTwo.stack.popLast()!
            continue
        }
        
        if stackThree.height >= stackOne.height && stackThree.height >= stackTwo.height {
            stackThree.height -= stackThree.stack.popLast()!
            continue
        }
    }
    
    print(stackOne.height)
}
funk["equalStacks"] = equalStacks

func camelCase() {
    let input = readLine()!
    
    var wordsInString = 1
    
    for character in input.characters {
        if "\(character)" == "\(character)".uppercased() {
            wordsInString += 1
        }
    }
    
    print(wordsInString)
}
funk["camelCase"] = camelCase

while true {
    print("Enter a function, choices are: ", terminator: "")
    for k in funk.keys {
        print(k, terminator: " ")
    }
    print()
    if let functionName = readLine() {
        if let function = funk[functionName] {
            print("Enter inputs")
            function()
        }
        if functionName == "exit" {
            break
        }
    }
    else {
        print("That's not a valid function")
    }
}
