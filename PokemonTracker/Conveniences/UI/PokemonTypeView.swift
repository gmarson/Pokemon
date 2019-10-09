//
//  PokemonTypeView.swift
//  pokemon
//
//  Created by Gabriel M on 3/4/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

class PokemonTypeView: UIView {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeColor: UIView!
    @IBOutlet weak var parentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    private func commomInit() {
        parentView = loadViewFromNib(nibName: "PokemonTypeView")
        parentView.frame = bounds
        parentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(parentView)
        typeColor.layer.cornerRadius = 5.0
        backgroundColor = .systemBackground
    }
    
    func setup(types: [Type]?, position: Int) {
        guard let types = types, types.count > position else {
            isHidden = true
            return
        }
        
        let t = types[position]
        isHidden = false
        typeColor.backgroundColor = UIColor.associatedColor(typeName: t.type?.prettyName)
        typeLabel.text = t.type?.prettyName
        self.layoutSubviews()
    }
}
