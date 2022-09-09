//
//  SectionHeaderView.swift
//  DestinationGuide
//
//  Created by Alexandre DENIS on 09/09/2022.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    @IBOutlet private var titleLabel: UILabel!
    
    func setup(titleLabel: String) {
        self.titleLabel.text = titleLabel
    }
    
}
