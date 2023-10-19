//
//  PrimeNumberViewController.swift
//  Codium
//
//  Created by Gilles Zwijsen on 18/10/2023.
//

import UIKit

class PrimeNumberViewController: UIViewController {

    private let numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Check Prime", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Is It Prime?"
        self.view.backgroundColor = .white

        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(numberTextField)
        view.addSubview(checkButton)
        view.addSubview(resultLabel)
        
        // Disable autoresizing
        [numberTextField, checkButton, resultLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            numberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            checkButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.widthAnchor.constraint(equalTo: numberTextField.widthAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func checkButtonTapped() {
        // Hide the keyboard
        numberTextField.resignFirstResponder()
        
        guard let numberText = numberTextField.text, let number = Int(numberText) else {
            resultLabel.text = "Please enter a valid number."
            return
        }
        
        if isPrime(number) {
            resultLabel.text = "\(number) is a prime number."
        } else {
            resultLabel.text = "\(number) is not a prime number."
        }
    }
    
    private func isPrime(_ number: Int) -> Bool {
        if number <= 1 {
            return false
        }
        if number <= 3 {
            return true
        }
        var i = 2
        while i*i <= number {
            if number % i == 0 {
                return false
            }
            i = i + 1
        }
        return true
    }
}
