//
//  SettingController.swift
//  VK-app-infection
//
//  Created by Nik Kozhemyakin on 10.05.2023.
//

import UIKit

class SettingsController: UIViewController {
    
    
    // UI элементы
    let stackView = UIStackView()
    let groupSize = UITextField()
    let infectionFactor = UITextField()
    let timer = UITextField()
    let startModelButton = UIButton()
    let backSettingsView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Colours.gameB
        // Установка свойств для stackView
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление UI элементов в stackView
        stackView.addArrangedSubview(groupSize)
        stackView.addArrangedSubview(infectionFactor)
        stackView.addArrangedSubview(timer)
        stackView.addArrangedSubview(startModelButton)
        
        
        setupGroupSize()
        setupInfectionFactor()
        setupTimer()
        
        view.addSubview(stackView)
        
        
        // Ограничения для stackView
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        setupStartButton()
        
        stackView.insertSubview(backSettingsView, at: 0)
        setupBackSettingsView()
        
    }
    
    func setupGroupSize() {
        groupSize.borderStyle = .roundedRect
        groupSize.placeholder = "Group Size"
        groupSize.layer.cornerRadius = 10
        

    }
    func setupInfectionFactor() {
        infectionFactor.borderStyle = .roundedRect
        infectionFactor.placeholder = "Infection Factor"
        infectionFactor.layer.cornerRadius = 10
        
    }
    func setupTimer() {
        timer.borderStyle = .roundedRect
        timer.placeholder = "Timer"
        timer.layer.cornerRadius = 10
        
    }
    
    func setupStartButton() {
        startModelButton.setTitle("Запустить поделирование", for: .normal)
        startModelButton.setTitleColor(UIColor.Colours.healthy, for: .normal)
        startModelButton.addTarget(self, action: #selector(openNewScreen), for: .touchUpInside)
        
        startModelButton.layer.cornerRadius = 10
        
        startModelButton.backgroundColor = .green
        
        startModelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startModelButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5)

        ])
        
    }
    
    @objc func openNewScreen() {
        let newViewController = InfectionController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func setupBackSettingsView() {
        backSettingsView.backgroundColor = .gray
        
        backSettingsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backSettingsView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -15),
            backSettingsView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -15),
            backSettingsView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 15),
            backSettingsView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15)
        ])
    }
}




