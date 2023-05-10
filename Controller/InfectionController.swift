//
//  InfectionController.swift
//  VK-app-infection
//
//  Created by Nik Kozhemyakin on 06.05.2023.
//


import Foundation
import UIKit




class InfectionController: UIViewController {
    
    var infectionFactor: Int = 5
    var squareSize: CGFloat = 1
    var n: Int = 2 // количество строк
    var m: Int = 2 // количество столбцов
    var N: Int = 500
    let screenWidth = Int(UIScreen.main.bounds.width)
    let screenHeight = Int(UIScreen.main.bounds.height)
    
    var collectionView:fieldCollectionView!
    let groupSize = UILabel()
    let infectionGroup = UILabel()
    
    
    var timer: Timer?
    let timerLabel = UILabel()
    var tick: Int = 0 {
        didSet {
            timerLabel.text = "Time: \(tick)"
        }
    }
    private var horizontalStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tick = 0
        calculateGridSize(groupSize: N)
        collectionView = fieldCollectionView(squareSize: squareSize, n: n, m: m, horizontalStack: horizontalStack)
        view.backgroundColor = UIColor.Colours.gameB
        
        title = "Game"
        navigationController?.navigationBar.backgroundColor = UIColor.Colours.gameB
        
       
        
        setupStackView()
        setupGroupSize()
        setupInfectionGroup()
        setupTimer()
        
        setupConstraints()
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(collectionView.T), repeats: true) { timer in
            self.tick += 1
            self.collectionView.spreadInfection()
            
        }
    }
    
    @objc func button1Tapped() {
        
    }
    
    //MARK: - Constraints
    func setupConstraints() {
        view.addSubview(horizontalStack)
        view.addSubview(collectionView)
        
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalStack.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    
    
    //MARK: - Create Header
    
    private func setupGroupSize() {
        groupSize.font = .systemFont(ofSize: 16, weight: .medium)
        groupSize.numberOfLines = 0
        groupSize.textColor = .label
        groupSize.text = "GroupSize: \(collectionView.N)"
    }
    
    private func setupInfectionGroup() {
        infectionGroup.font = .systemFont(ofSize: 16, weight: .medium)
        infectionGroup.numberOfLines = 0
        infectionGroup.textColor = .label
        infectionGroup.text = "InfectionGroup: "
    }
    
    private func setupTimer() {
        timerLabel.font = .systemFont(ofSize: 16, weight: .medium)
        timerLabel.numberOfLines = 0
        timerLabel.textColor = .label
    }

//MARK: - Setup Collection View
    
    func updateCollectionView() {

        collectionView.reloadData()
    }
    
    private func setupStackView() {
        horizontalStack = UIStackView(arrangedSubviews: [groupSize, infectionGroup, timerLabel])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .equalCentering
        horizontalStack.backgroundColor = UIColor.Colours.gameB
    }
    
    func calculateGridSize(groupSize: Int) {
        var largestN = 1
        var largestM = groupSize
        
        for n in 1...groupSize {
            if groupSize % n == 0 {
                let m = groupSize / n
                if m >= n && m <= groupSize {
                    largestN = n
                    largestM = m
                }
            }
        }
        self.n = largestN
        self.m = largestM
        if self.m > 20 {
            self.m = 20
        }
        self.squareSize = CGFloat(min(screenWidth / n, screenHeight / m))
        if squareSize >= 50 {
            self.squareSize = 35
        }
            
        print("squaresize: \(self.squareSize)")
        print("squaresizeMin: \(min(screenWidth / n, screenHeight / m))")
    }

}

