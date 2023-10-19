//
//  LeapYearViewController.swift
//  Codium
//
//  Created by Gilles Zwijsen on 18/10/2023.
//

import UIKit

class LeapYearViewController: UIViewController {


    private let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter year"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Check", for: .normal)
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
        
        self.title = "Is Leap Year"
        self.view.backgroundColor = .white

        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)

        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(yearTextField)
        view.addSubview(checkButton)
        view.addSubview(resultLabel)
        
        [yearTextField, checkButton, resultLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            yearTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yearTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            yearTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            yearTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            checkButton.topAnchor.constraint(equalTo: yearTextField.bottomAnchor, constant: 20),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.widthAnchor.constraint(equalTo: yearTextField.widthAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func checkButtonTapped() {
        // Hide keyboard
        yearTextField.resignFirstResponder()
        
        guard let yearText = yearTextField.text, let year = Int(yearText) else {
            resultLabel.text = "Please enter a valid year."
            return
        }
        
        if isLeapYear(year) {
            resultLabel.text = "\(year) is a leap year."
        } else {
            resultLabel.text = "\(year) is not a leap year."
        }
    }
    
    private func isLeapYear(_ year: Int) -> Bool {
        return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
    }
}
