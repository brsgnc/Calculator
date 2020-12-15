//
//  ViewController.swift
//  Calculator
//
//  Created by Barış Genç on 16.10.2020.
//  Copyright © 2020 BG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperation: Operation?
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont(name: "Arial", size: 50)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        setupNumberPad()
    }

    private func setupNumberPad() {
        
        let buttonSize: CGFloat = view.frame.size.width / 4
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(zeroButton)
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        for x in 0..<3 {
            let Button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-buttonSize*2, width: buttonSize, height: buttonSize))
            
            Button1.setTitleColor(.black, for: .normal)
            Button1.backgroundColor = .white
            Button1.setTitle("\(x+1)", for: .normal)
            Button1.tag = x+2
            Button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(Button1)
            
        }
        for x in 0..<3 {
            let Button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-buttonSize*3, width: buttonSize, height: buttonSize))
            
            Button2.setTitleColor(.black, for: .normal)
            Button2.backgroundColor = .white
            Button2.setTitle("\(x+4)", for: .normal)
            Button2.tag = x+5
            Button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(Button2)
            
        }
        for x in 0..<3 {
            let Button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-buttonSize*4, width: buttonSize, height: buttonSize))
        
            Button3.setTitleColor(.black, for: .normal)
            Button3.backgroundColor = .white
            Button3.setTitle("\(x+7)", for: .normal)
            Button3.tag = x+8
            Button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(Button3)
        }
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize*5, width: view.frame.size.width-buttonSize, height: buttonSize))
        
            clearButton.setTitleColor(.black, for: .normal)
            clearButton.backgroundColor = .white
            clearButton.setTitle("Clear", for: .normal)
            holder.addSubview(clearButton)
        
        let operations = ["=", "+", "-", "x", "/"]
        for x in 0..<5 {
            let Button4 = UIButton(frame: CGRect(x: buttonSize*3, y: holder.frame.size.height-buttonSize*CGFloat(x+1), width: buttonSize, height: buttonSize))
            
            Button4.setTitleColor(.white, for: .normal)
            Button4.backgroundColor = .systemOrange
            Button4.setTitle(operations[x], for: .normal)
            holder.addSubview(Button4)
            Button4.tag = x+1
            Button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }
        
        resultLabel.frame = CGRect(x: 0, y: clearButton.frame.origin.y - 100.0, width: view.frame.size.width, height: 100)
        holder.addSubview(resultLabel)
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    }
    @objc func clearResult() {
        resultLabel.text = "0"
        currentOperation = nil
        firstNumber = 0 
    }
    
    @objc func zeroTapped() {
        if let text = resultLabel.text {
            resultLabel.text = "\(text)\(0)"
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
    
    @objc func operationPressed(_ sender: UIButton) {
         
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        if tag == 1 {
            if let operation = currentOperation {
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                    
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
                        let result = firstNumber / secondNumber
                        resultLabel.text = "\(result)"
                        break
                    }
                }
            }
        }
        else if tag == 2 {
            currentOperation = .add
        }
        else if tag == 3 {
            currentOperation = .subtract
        }
        else if tag == 4 {
            currentOperation = .multiply
        }
        else if tag == 5 {
            currentOperation = .divide
        }
    }
}

