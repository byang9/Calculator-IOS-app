//
//  ViewController.swift
//  Calculator
//
//  Created by Bowen Yang on 10/13/15.
//  Copyright © 2015 Stanford Videos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    var operandStack = Array<Double>()
    var middleOfTyping = false
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            middleOfTyping = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if(middleOfTyping){
            enter()
        }
        switch operation{
        case "x":performOperation({ (op1:Double, op2:Double) -> Double in return op1 * op2})
        case "+":performOperation({$0 + $1})
        case "-":performOperation {$1 - $0}
        case "\\":performOperation {$1 / $0}
        case "√":performOperationSqrt { sqrt($0)}
        default: break
        }
    }
    
    func performOperation(operation: (Double,Double) -> Double){
        if(operandStack.count >= 2){
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperationSqrt(operation: (Double) -> Double){
        if(operandStack.count >= 1){
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(middleOfTyping){
            display.text = display.text! + digit
        }else{
            display.text = digit
            middleOfTyping=true
        }
        print("Digit is: " + digit)
    }

    @IBAction func enter() {
        middleOfTyping = false;
        operandStack.append(displayValue)
        print("Operand Stack = \(operandStack)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

