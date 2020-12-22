//
//  ProfileTabsCollectionReusableView.swift
//  MyInsta
//
//  Created by Nam on 12/17/20.
//

import UIKit
import Stevia
protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButton()
    func didTapTaggedButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
       let button = UIButton()
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "squareshape.split.3x3"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
       let button = UIButton()
        button.tintColor = .secondarySystemBackground
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        sv(gridButton, taggedButton)
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        gridButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    @objc func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButton()
    }
    
    @objc func didTapTaggedButton() {
        taggedButton.tintColor = .systemBlue
        gridButton.tintColor = .lightGray
        delegate?.didTapTaggedButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = 10
        let size = height - CGFloat(padding*2)
        let gridButtonX = (width/2 - size)/2
        layout(padding,
               |-gridButtonX-gridButton.size(size)-gridButtonX*2-taggedButton.size(size)-gridButtonX-|,
        padding)
        
    }
    
}
