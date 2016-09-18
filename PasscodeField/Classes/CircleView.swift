//
//  CircleView.swift
//  Pods
//
//  Created by TomomuraRyota on 2016/05/30.
//
//

import UIKit

final class CircleView: UIView {
    
    // MARK: - Properties
    
    var borderHeight: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var fillColor: UIColor {
        didSet {
            self.refreshFillColor()
        }
    }
    
    var fillSize: CGFloat {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    var fill: Bool = false {
        didSet {
            self.refreshFillView()
        }
    }
    
    fileprivate let fillView = UIView(frame: CGRect.zero)
    
    // MARK: - Initializers
    
    init(borderHeight: CGFloat, fillSize: CGFloat, fillColor: UIColor) {
        self.borderHeight = borderHeight
        self.fillSize = fillSize
        self.fillColor = fillColor
        
        super.init(frame: CGRect.zero)
        
        self.commonInit()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func draw(_ rect: CGRect) {
        if !self.fill {
            let line = UIBezierPath()
            
            let x = self.fillView.frame.origin.x
            let y  = self.bounds.height / 2
            let width = self.fillView.bounds.width
            
            line.move(to: CGPoint(x: x, y: y));
            line.addLine(to: CGPoint(x: x + width, y: y));
            line.lineWidth = self.borderHeight
            
            self.fillColor.setStroke()
            line.stroke()
        }
    }
    
    override var intrinsicContentSize : CGSize {
        return CGSize(width: self.fillSize, height: self.fillSize)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            self.fillView.topAnchor.constraint(equalTo: self.topAnchor),
            self.fillView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.fillView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.fillView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.fillView.layer.cornerRadius = self.fillSize / 2
    }
    
    // MARK: - Private Methods
    
    fileprivate func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        
        self.fillView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupView() {
        self.addSubview(self.fillView)
        
        self.refreshFillView()
        self.refreshFillColor()
    }
    
    // MARK: - Helpers
    
    fileprivate func refreshFillColor() {
        self.fillView.backgroundColor = self.fillColor
        self.setNeedsDisplay()
    }
    
    fileprivate func refreshFillView() {
        self.fillView.isHidden = !self.fill
    }
    
}
