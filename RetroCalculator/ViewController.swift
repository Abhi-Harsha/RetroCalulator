//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Abhishek H P on 3/7/16.
//  Copyright © 2016 Abhishek H P. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case add = "+"
        case subtract = "-"
        case divide = "/"
        case multiply = "*"
        case empty = "empty"
    }
    
    @IBOutlet weak var label: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var currentNumber = ""
    var leftNumber = ""
    var rightNumber = ""
    var curroperation : Operation = Operation.empty
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        label.text = ""
        
    }

    @IBAction func onButtonPressed(btn: UIButton){
        playSound()
        
        currentNumber += "\(btn.tag)"
        label.text = currentNumber
    }
    
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }

    @IBAction func onAddPressed(sender: UIButton){
        playSound()
        processOperation(Operation.add)
        
    }
    
    @IBAction func onSubtractPressed(sender: UIButton){
        playSound()
        processOperation(Operation.subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton){
        playSound()
        processOperation(Operation.multiply)
    }
    
    @IBAction func onDividePressed(sender: UIButton){
        playSound()
        processOperation(Operation.divide)
    }
    
    @IBAction func onEqualPressed(sender: UIButton){
        playSound()
        processOperation(curroperation)
    }
    
    @IBAction func onClearPressed(sender: UIButton){
        playSound()
        label.text = ""
        currentNumber = ""
        leftNumber = ""
        rightNumber = ""
        curroperation = Operation.empty
    }
    
    func processOperation(op: Operation){
        
        if curroperation != Operation.empty {
        
            
            if currentNumber != "" {
                rightNumber = currentNumber
                currentNumber = ""
        
                if curroperation == Operation.add {
                    result = "\(Double(leftNumber)! + Double(rightNumber)!)"
                } else if curroperation == Operation.subtract {
                    result = "\(Double(leftNumber)! - Double(rightNumber)!)"
                } else if curroperation == Operation.multiply {
                    result = "\(Double(leftNumber)! * Double(rightNumber)!)"
                } else if curroperation == Operation.divide {
                    result = "\(Double(leftNumber)! / Double(rightNumber)!)"
                }
            }
            
            label.text = result
            leftNumber = result
            currentNumber = ""
            curroperation = op
            
        } else {
            leftNumber = currentNumber
            currentNumber = ""
            curroperation = op
        }
    }

}

