//
//  ViewController.swift
//  Example
//
//  Created by Evgene Podkorytov on 15.02.17.
//  Copyright © 2017 OverC. All rights reserved.
//

import UIKit
import OCStepView

class ViewController: UIViewController {

    fileprivate var items = [OCStepViewItem]()
    
    fileprivate var stepper = OCStepView()
    fileprivate let stepControl = UIStepper()
    
    fileprivate let btnNext : UIButton = {
        let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.blue, for: .normal)
            button.setTitle("Next>", for: .normal)
        return button
    }()
    fileprivate let btnPrev : UIButton = {
        let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.blue, for: .normal)
            button.setTitle("<Prev", for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [OCStepViewItem(title: "FILLED", isEnabled: true),
                     OCStepViewItem(title: "CURRENT", isEnabled: true),
                     OCStepViewItem(title: "AVAILABLE", isEnabled: true),
                     OCStepViewItem(title: "UNAVAILABLE", isEnabled: false)]
        
        
        stepper.items = items
 
        view.addSubview(stepper)
        
        stepper.heightAnchor.constraint(equalToConstant: 52.0).isActive = true
        stepper.topAnchor.constraint(equalTo: view.topAnchor, constant: 25.0).isActive = true
        stepper.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        stepper.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0.0).isActive = true
        
        stepper.currentIndex = 0
        
        //
        stepControl.translatesAutoresizingMaskIntoConstraints = false
        let maximumValue = items.count - 1
        stepControl.maximumValue = Double(maximumValue)
        view.addSubview(stepControl)
        stepControl.addTarget(self, action: #selector(stepControlChangeValue(_:)) , for: .touchUpInside)
        stepControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stepControl.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: 50.0).isActive = true
        
        //
        view.addSubview(btnNext)
        btnNext.addTarget(self, action: #selector(nextStep) , for: .touchUpInside)
        btnNext.widthAnchor.constraint(equalToConstant: 80.0)
        btnNext.heightAnchor.constraint(equalToConstant: 40.0)
        btnNext.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50.0).isActive = true
        btnNext.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: 90.0).isActive = true
        
        view.addSubview(btnPrev)
        btnPrev.addTarget(self, action: #selector(prevStep) , for: .touchUpInside)
        btnPrev.widthAnchor.constraint(equalToConstant: 80.0)
        btnPrev.heightAnchor.constraint(equalToConstant: 40.0)
        btnPrev.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50.0).isActive = true
        btnPrev.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: 90.0).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func stepControlChangeValue(_ sender : UIStepper) {
        let idx = Int(sender.value)
        stepper.currentIndex = idx
    }
    
    func nextStep() {
        stepper.nextStep()
    }
    func prevStep() {
        stepper.prevStep()
    }
}

