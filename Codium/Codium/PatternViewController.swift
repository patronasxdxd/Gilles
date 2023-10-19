//
//  PatternViewController.swift
//  Codium
//
//  Created by Gilles Zwijsen on 18/10/2023.
//

import UIKit

class PatternViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Pattern Generator"
        

        displayButton.addTarget(self, action: #selector(displayPattern), for: .touchUpInside)
        setupPatternPicker()
        setupUI()
        
        // Set the default pattern
        let defaultPattern = "3.4"
        if let defaultRow = patternOptions.firstIndex(of: defaultPattern) {
            patternPicker.selectRow(defaultRow, inComponent: 0, animated: false)
            patternTextField.text = defaultPattern
        }

        // Set default size
        let defaultSize = "20"
        sizeTextField.text = defaultSize
        displayPattern()
    }
    
    private let patternPicker = UIPickerView()
     private let patternOptions = ["3.1", "3.2", "3.3", "3.4", "3.5", "3.6"]

    private func setupPatternPicker() {
           patternPicker.delegate = self
           patternPicker.dataSource = self

           patternTextField.inputView = patternPicker

           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
           toolBar.setItems([doneButton], animated: false)
           toolBar.isUserInteractionEnabled = true
           patternTextField.inputAccessoryView = toolBar
       }
       
       @objc private func dismissPicker() {
           view.endEditing(true)
       }


       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return patternOptions.count
       }

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return patternOptions[row]
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           patternTextField.text = patternOptions[row]
       }
    
    
    private let patternTextField: UITextField = {
         let textField = UITextField()
         textField.placeholder = "Enter pattern number (e.g., 3.1)"
         textField.borderStyle = .roundedRect
         return textField
     }()
    
    private let sizeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter size"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let displayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Display Pattern", for: .normal)
        button.backgroundColor = .systemBlue

        button.layer.cornerRadius = 10
        

        
        return button
    }()
    
    private let resultTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 15)
        
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.black.cgColor
        
        textView.layer.cornerRadius = 10
        
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 6, height: 3)
        textView.layer.shadowOpacity = 0.7
        textView.layer.shadowRadius = 4.0
        
        textView.layer.masksToBounds = false

        return textView
    }()

    
   
    
    private func setupUI() {
        view.addSubview(patternTextField)
        view.addSubview(sizeTextField)
        view.addSubview(displayButton)
        view.addSubview(resultTextView)
        
        [patternTextField, sizeTextField, displayButton, resultTextView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            patternTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            patternTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            patternTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            patternTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            sizeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sizeTextField.topAnchor.constraint(equalTo: patternTextField.bottomAnchor, constant: 20),
            sizeTextField.leadingAnchor.constraint(equalTo: patternTextField.leadingAnchor),
            sizeTextField.trailingAnchor.constraint(equalTo: patternTextField.trailingAnchor),
            
            displayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayButton.topAnchor.constraint(equalTo: sizeTextField.bottomAnchor, constant: 20),
            displayButton.leadingAnchor.constraint(equalTo: patternTextField.leadingAnchor),
            displayButton.trailingAnchor.constraint(equalTo: patternTextField.trailingAnchor),
            displayButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultTextView.topAnchor.constraint(equalTo: displayButton.bottomAnchor, constant: 20),
            resultTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resultTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func displayPattern() {
            guard
                let selectedPattern = patternTextField.text,
                !selectedPattern.isEmpty,
                let sizeText = sizeTextField.text,
                let size = Int(sizeText)
            else {
                resultTextView.text = "Invalid input. Please enter a pattern and a valid number."
                return
            }

            let generator = PatternGenerator()
        let patternString = generator.generatePattern(selectedPattern: selectedPattern, n: size)
            resultTextView.text = patternString
        }

}
