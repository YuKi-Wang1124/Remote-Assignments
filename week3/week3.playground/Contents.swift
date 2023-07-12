import Foundation

/*:
Batch #21 / iOS Class
Remote Learning Assignment - Week 3
1. Please declare a closure whose input type is Int, output type is Bool. The functionality of this closure is to verify if the input is odd or not. If it’s odd, please return true, otherwise return false.
*/

let oddChecker: (Int) -> Bool = { (number) in
    return number % 2 == 1
}

print(oddChecker(5))
print(oddChecker(6))
