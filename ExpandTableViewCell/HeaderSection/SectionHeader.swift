//
//  SectionHeader.swift
//  ExpandTableViewCell
//
//  Created by Preuttipan Janpen on 1/3/2562 BE.
//  Copyright © 2562 Lphant Solutions. All rights reserved.
//

import UIKit

protocol SectionHeaderViewDelegate  {
    func toggleSection(header: SectionHeader, section:Int)
}

class SectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var labelMonth: UILabel!
    
    var delegate: SectionHeaderViewDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
        //fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer){
        let cell = gestureRecognizer.view as! SectionHeader
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(month: String, section: Int, delegate: SectionHeaderViewDelegate){
        
        labelMonth.text = month
        
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.textLabel?.textColor = UIColor.white
        // self.contentView.backgroundColor = UIColor.darkGray
    }
}


