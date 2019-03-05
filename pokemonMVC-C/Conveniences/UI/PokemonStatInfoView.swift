//
//  PokemonStatInfoView.swift
//  pokemon
//
//  Created by Gabriel M on 3/4/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

class PokemonStatInfoView: UIView {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var statTitleLabel: UILabel!
    @IBOutlet weak var statValueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    private func commomInit() {
        parentView = loadViewFromNib(nibName: "PokemonStatInfoView")
        parentView.frame = bounds
        parentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        parentView.layer.cornerRadius = 10.0
        addSubview(parentView)
    }
    
    func setup(_ s: Stat) {
        statTitleLabel.text = s.stat?.prettyName
        if let base = s.base_stat {
             statValueLabel.text = String(base)
        } else {
            statValueLabel.text = "N/A"
        }
       
    }

}
