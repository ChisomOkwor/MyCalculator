//
//  ViewController.swift
//  MyCalculator
//
//  Created by Chisom Okwor on 3/14/20.
//  Copyright © 2020 Chisom Okwor. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet var holder: UIView!

    var firstNumber = 0
    var resultNumber = 0
    var currentOperations: Operation?

    
    // Used enum to define a common type for the arithmetic operations
    enum Operation {
        case add, subtract, multiply, divide
    }

    // Sets up the Result label
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 100)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupNumberPad()
    }

    //Creates the number Pad
    private func setupNumberPad() {
        //width of button is 1/4 width of view controller
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        //Define zero button and use CGRECT holds the holds the dimension of the frame in the X, Y variable
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        zeroButton.tag = 1
        holder.addSubview(zeroButton)
        
        //Made the button Actionable
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)

        //button 1 to 3
        for x in 0..<3 {
            // Sets dimension for button
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            button1.setTitle("\(x+1)", for: .normal)
            holder.addSubview(button1)
            button1.tag = x+2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        // button 4 to 6
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.setTitle("\(x+4)", for: .normal)
            holder.addSubview(button2)
            button2.tag = x+5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }

        
        //button 7 to 9
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            button3.setTitle("\(x+7)", for: .normal)
            holder.addSubview(button3)
            button3.tag = x+8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }

        // Sets AC button
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-(buttonSize*5), width: view.frame.size.width - buttonSize, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .gray
        clearButton.setTitle("AC", for: .normal)
        holder.addSubview(clearButton)


        let operations = ["=","+", "-", "x", "/"]

        // Sets Operations by looping through a list
        // Defines 5 operatoion buttons
        for x in 0..<5 {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-(buttonSize * CGFloat(x+1)), width: buttonSize, height: buttonSize))
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = .orange
            button4.setTitle(operations[x], for: .normal)
            holder.addSubview(button4)
            button4.tag = x+1
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }

        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
        holder.addSubview(resultLabel)

        // Actions
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    }

    // clear result view, and sets it to ZERO
    @objc func clearResult() {
        resultLabel.text = "0"
        currentOperations = nil
        firstNumber = 0
    }

    // ACTIONS THAT TRIGGER EVENTS on the result view
    @objc func zeroTapped() {

        if resultLabel.text != "0" {
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }

    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1

        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }

    // Assign first and second number after operation is pressed
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag

        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }

        if tag == 1 {
            if let operation = currentOperations {
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                }
                
                // Lets you inspect a Value and Matches it with a number of cases
                
                switch operation {
                case .add:

                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break

                case .subtract:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"

                    break

                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"

                    break

                case .divide:
                    use if secondNumber == 0{
                        resultLabel.text = "NAN"
                    }
                    else {
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                    }
                }
            }
        }
            
        // Conditionals to find out which operation has been selected
        else if tag == 2 {
            currentOperations = .add
        }
        else if tag == 3 {
            currentOperations = .subtract
        }
        else if tag == 4 {
            currentOperations = .multiply
        }
        else if tag == 5 {
            currentOperations = .divide
        }

    }

}

