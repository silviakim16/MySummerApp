//
//  ShadowForCell.swift
//  SummerApp
//
//  Created by Silvia  Kim on 8/2/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation
import UIKit

class ShadowStyleView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
}
