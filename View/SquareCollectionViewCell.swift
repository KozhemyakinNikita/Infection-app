//
//  InfectionView.swift
//  VK-app-infection
//
//  Created by Nik Kozhemyakin on 06.05.2023.
//

import UIKit

class SquareCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "SquareCollectionViewCell"
 
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
 
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
 
  func configure(infection: Bool) {
    if infection {
        self.backgroundColor = .red
    } else {
        self.backgroundColor = UIColor.Colours.settingsB
    }
  }
}
