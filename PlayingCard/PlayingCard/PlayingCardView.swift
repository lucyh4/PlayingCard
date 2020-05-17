//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Deepankar D on 17/05/20.
//  Copyright © 2020 Neha. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    var rank: Int = 5 {
        didSet{          //When the value of rank value changed
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    var suit: String = "♥️"{
        didSet{     //When the value of suit value changed
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    var isFaceUP: Bool = true{
        didSet{             //When the value of isFaceup value changed
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    //MARK: function that take string and return NSattributed string
    
    private func centeredAttributedString(_ string : String, fontSize : CGFloat) -> NSAttributedString{
        var font = UIFont.preferredFont(forTextStyle: .body)
            .withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)  //This line has to be implemented as this makes the user change the font size of your app
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle , NSAttributedString.Key.font : font])
        
    }
    
    private var cornerString: NSAttributedString{
        return centeredAttributedString(rankString+"\n"+suit, fontSize: cornerFontSize)
        
    }
    //MARK: - Labels for upper and lower corner
    
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()
    
    private func createCornerLabel() -> UILabel{
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label : UILabel){
        label.attributedText = cornerString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceUP
    }
   
    
    //MARK: - This method calls when iOS environment Change (like user chnge the font size
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        configureCornerLabel(lowerRightCornerLabel)
        lowerRightCornerLabel.transform = CGAffineTransform.identity.translatedBy(x: lowerRightCornerLabel.frame.width, y: lowerRightCornerLabel.frame.height)
            .rotated(by: CGFloat.pi)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.width, dy: -lowerRightCornerLabel.frame.height)
        
    }
    
    //MARK: - Function to draw Card
    override func draw(_ rect: CGRect) {
        //      let path = UIBezierPath()
        //        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 120.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true   )
        //        path.lineWidth = 5.0
        //        UIColor.green.setFill()
        //        UIColor.red.setStroke()
        //        path.stroke()
        //        path.fill()
        
        
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius
        )
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
    }
    
    
}
//MARK: - extension to segregate the constants

extension PlayingCardView {
    private struct SizeRatio{
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
        
    }
    
    private var cornerRadius : CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var rankString: String{
        switch rank {
            case 1: return "A"
            case 2...10: return String(rank)
            case 11: return "J"
            case 12: return "Q"
            case 13: return "K"
            default: return "?"
        }
    }
}

//MARK: - extension to CGRect
extension CGRect {
    var leftHalf: CGRect{
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect{
        return CGRect(x: midX, y: midY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect{
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect{
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect{
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth)/2 , dy: (height - newHeight)/2)
    }
}

extension CGPoint{
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint{
        return CGPoint(x: x+dx, y: y+dy)
    }
}
