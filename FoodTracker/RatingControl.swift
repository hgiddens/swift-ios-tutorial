//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Hugh Giddens on 18/09/2016.
//
//

import UIKit

class RatingControl: UIView {
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()

    let buttonSize = 44
    let spacing = 5
    let starCount = 5
    
    override var intrinsicContentSize: CGSize {
        get {
            let width = (buttonSize * starCount) + (spacing * (starCount - 1))
            return CGSize(width: width, height: buttonSize)
        }
    }
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
            button.setImage(#imageLiteral(resourceName: "emptyStar"), for: .normal)
            button.setImage(#imageLiteral(resourceName: "filledStar"), for: .selected)
            button.setImage(#imageLiteral(resourceName: "filledStar"), for: [.highlighted, .selected])
            button.adjustsImageWhenHighlighted = false
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    // MARK: Button action
    
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.index(of: button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
