//
//  FieldCollectionView.swift
//  VK-app-infection
//
//  Created by Nik Kozhemyakin on 08.05.2023.
//

import Foundation
import UIKit

protocol CollectionViewDelegate: AnyObject {
    func setHorizontalStack(_ stackView: UIStackView)
}

class fieldCollectionView: UICollectionView {
    private var horizontalStack = UIStackView()
    var N: Int = 500
    var squares: [Bool] = Array()
    var infectionFactor: Int = 5
    var squareSize: CGFloat = 1
    var n: Int = 2 // количество строк
    var m: Int = 2 // количество столбцов
    var T: Double = 5// частота обновления экрана
    
//    var timer: Timer?
    //MARK: - Init
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        let layout = UICollectionViewFlowLayout()
//        //        layout.minimumInteritemSpacing = 0
//        //        layout.minimumLineSpacing = 0
//        super.init(frame: frame, collectionViewLayout: layout)
//        setupCollectionViewAppearance()
//
//
//        self.squares = Array(repeating: false, count: N)
//
//
//    }
    
    init(squareSize: CGFloat, n: Int, m: Int, horizontalStack: UIStackView) {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.squareSize = squareSize
        self.n = n
        self.m = m
        self.horizontalStack = horizontalStack
        setupCollectionViewAppearance()
        self.squares = Array(repeating: false, count: N)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let superview = superview else {return}
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //настройка поля
    func setupCollectionViewAppearance() {
        self.backgroundColor = UIColor.Colours.gameB
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = self
        self.register(SquareCollectionViewCell.self, forCellWithReuseIdentifier: SquareCollectionViewCell.reuseIdentifier)
    }
  
   
//    func getNeighboringIndices(for index: Int) -> [Int] {
//        let row = index / m
//        let col = index % m
//        var neighbors: [Int] = []
//        for i in (max(0, row-1))...(min(n-1, row+1)) {
//            for j in (max(0, col-1))...(min(m-1, col+1)) {
//                if i == row && j == col {
//                    continue // Пропустить текущую клетку
//                }
//                let neighborIndex = i * m + j
//                if !squares[neighborIndex] {
//                    neighbors.append(neighborIndex)
//                }
//            }
//        }
//        return neighbors
//    }
//
//    @objc func spreadInfection() {
//        var newSquares = squares
//        var infectedSquares = [Int]()
//        for i in 0..<squares.count {
//            if squares[i] {
//                let uninfectedNeighbors = getNeighboringIndices(for: i)
//                if !uninfectedNeighbors.isEmpty {
//                    let infectionCount = min(infectionFactor, uninfectedNeighbors.count)
//                    //добавить подсчет зараженных и здоровых
//                    let infectedNeighbors = Array(uninfectedNeighbors.shuffled().prefix(infectionCount))
//                    infectedNeighbors.forEach {
//                        newSquares[$0] = true
//                        infectedSquares.append($0)
//                    }
//                }
//            }
//        }
//        // Check if any of the new infected squares are neighbors of each other
//        var newlyInfectedSquares = [Int]()
//        while !infectedSquares.isEmpty {
//            let infectedIndex = infectedSquares.removeFirst()
//            let newInfectedNeighbors = getNeighboringIndices(for: infectedIndex).filter { newSquares[$0] }
//            let validNewlyInfectedNeighbors = newInfectedNeighbors.filter { !newlyInfectedSquares.contains($0) }
//            newlyInfectedSquares.append(infectedIndex)
//            newlyInfectedSquares.append(contentsOf: validNewlyInfectedNeighbors)
//            infectedSquares.append(contentsOf: validNewlyInfectedNeighbors)
//        }
//        // Update the squares array with the newly infected squares
//        newlyInfectedSquares.forEach { newSquares[$0] = true }
//        squares = newSquares
//        self.reloadSections(IndexSet(integer: 0))
//    }
    func getNeighboringIndices(for index: Int) -> [Int] {
        let row = index / m
        let col = index % m
        var neighbors: [Int] = []
        
        let rowIndexes = [max(0, row-1), row, min(n-1, row+1)]
        let colIndexes = [max(0, col-1), col, min(m-1, col+1)]
        
        for i in rowIndexes {
            for j in colIndexes {
                if i == row && j == col {
                    continue // Пропустить текущую клетку
                }
                let neighborIndex = i * m + j
                if !squares[neighborIndex] {
                    neighbors.append(neighborIndex)
                }
            }
        }
        
        return neighbors
    }







    @objc func spreadInfection() {
        var newSquares = squares
        var newlyInfectedIndices = [Int]()
        
        for row in 0..<n {
            for col in 0..<m {
                let index = row * m + col
                print("Index: \(index)")
                if squares[index] {
                    let uninfectedNeighbors = getNeighboringIndices(for: index).filter { !squares[$0] }
                    
                    if !uninfectedNeighbors.isEmpty {
                        let infectedNeighbors = uninfectedNeighbors.shuffled().prefix(infectionFactor)
                        
                        for neighborIndex in infectedNeighbors {
                            newSquares[neighborIndex] = true
                            newlyInfectedIndices.append(neighborIndex)
                            
                        }
                        print("Index: \(index)")
                    }
                }
            }
        }
        
        squares = newSquares
        self.reloadSections(IndexSet(integer: 0))
        
        
        // Вывод индексов вновь зараженных клеток
        print("Newly Infected Indices: \(newlyInfectedIndices)")
    }

   
}

//MARK: - Extentions

extension fieldCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("**n: \(n) m: \(m)")
        
        return m
    }
    //настройка закругления, размена и изменения цыета ячейки
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return n
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCollectionViewCell.reuseIdentifier, for: indexPath) as! SquareCollectionViewCell
        cell.layer.cornerRadius = min(cell.bounds.width, cell.bounds.height) * 0.4
        cell.configure(infection: squares[indexPath.item])
        
        return cell
    }
    
    
    
    
    
}

//хранение ячейки
extension fieldCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = indexPath.item
        squares[indexPath.row].toggle()
        print("indexPath: \(indexPath.section*m+indexPath.row)")
        
        //    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCollectionViewCell.reuseIdentifier, for: indexPath) as! SquareCollectionViewCell
        //    cell.backgroundColor = .red

        let neighboringIndices = getNeighboringIndices(for: indexPath.section*m+indexPath.row)
        print("neighboringIndices: \(neighboringIndices)")
        var index = indexPath.section*m+indexPath.row
        
//        spreadInfection()
        collectionView.reloadItems(at: [indexPath])
        print("kdkdkdkdk")
            
            collectionView.reloadItems(at: [indexPath])
        
    }
    
    
}
//настройка размера и отступов между ячейками
extension fieldCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: squareSize, height: squareSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


//        func getNeighboringIndices(for index: Int) -> [Int] {
//            var neighboringIndices: [Int] = []
//            let row = index / m
//            let column = index % m
//
//            // проверка наличия соседей сверху, снизу, слева и справа
//            if row > 0 {
//                neighboringIndices.append((row - 1) * m + column)
//            }
//            if row < n - 1 {
//                neighboringIndices.append((row + 1) * m + column)
//            }
//            if column > 0 {
//                neighboringIndices.append(row * m + (column - 1))
//            }
//            if column < m - 1 {
//                neighboringIndices.append(row * m + (column + 1))
//            }
//
//            return neighboringIndices
//        }
//        func getNeighboringIndices(for index: Int) -> [Int] {
//                let row = index / m
//                let col = index % m
//                var neighbors: [Int] = []
//                for i in (max(0, row-1))...(min(n-1, row+1)) {
//                    for j in (max(0, col-1))...(min(m-1, col+1)) {
//                        if i == row && j == col {
//                            continue // Пропустить текущую клетку
//                        }
//                        let neighborIndex = i * m + j
//                        if !squares[neighborIndex] {
//                            neighbors.append(neighborIndex)
//                        }
//                    }
//                }
//                return neighbors
//            }
    
        
