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
        parentView = loadViewFromNib()
        parentView.frame = bounds
        parentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(parentView)
        typeColor.layer.cornerRadius = 5.0
    }
    
    func setup(types: [Type]?, position: Int) {
        guard let types = types, types.count > position else {
            isHidden = true
            return
        }
        
        let t = types[position]
        isHidden = false
        typeColor.backgroundColor = associatedColor(typeName: t.type?.prettyName)
        typeLabel.text = t.type?.prettyName
        self.layoutSubviews()
    }
    
    private func associatedColor(typeName: String?) -> UIColor? {
        guard let name = typeName?.lowercased() else { return UIColor.white }
        let color = UIColor(named: name)
        return color
    }
    
    private func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PokemonTypeView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
}
