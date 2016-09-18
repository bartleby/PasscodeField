//
//  ProgressStackView.swift
//  Pods
//
//  Created by TomomuraRyota on 2016/05/30.
//
//

import UIKit

final class ProgressStackView: UIStackView {
    
    // MARK: - Properties
    
    var length: Int {
        didSet {
            self.refreshCircleView()
        }
    }
    
    var progress: Int {
        didSet {
            self.refreshProgress()
        }
    }

    
    var borderHeight: CGFloat {
        didSet {
            self.arrangedSubviews.forEach { view in
                guard let circleView = view as? CircleView else { return }
                
                circleView.borderHeight = self.borderHeight
            }
        }
    }
    
    var fillColor: UIColor {
        didSet {
            self.arrangedSubviews.forEach { view in
                guard let circleView = view as? CircleView else { return }
                
                circleView.fillColor = self.fillColor
            }
        }
    }
    
    var fillSize: CGFloat {
        didSet {
            self.arrangedSubviews.forEach { view in
                guard let circleView = view as? CircleView else { return }
                
                circleView.fillSize = self.fillSize
            }
        }
    }
    
    // MARK: - Initializers
    
    init(length: Int, progress: Int, borderHeight: CGFloat, fillSize: CGFloat, fillColor: UIColor) {
        self.length = length
        self.progress = progress
        self.borderHeight = borderHeight
        self.fillSize = fillSize
        self.fillColor = fillColor
        
        super.init(frame: CGRect.zero)
        
        self.commonInit()
        self.setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods

    fileprivate func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal;
        self.distribution = .equalSpacing
        self.alignment = .center
    }
    
    fileprivate func setupView() {
        self.refreshCircleView()
    }
    
    // MARK: - Helpers
    
    fileprivate func refreshCircleView() {
        self.arrangedSubviews.forEach { view in view.removeFromSuperview() }
        
        for _ in 0...(self.length - 1) {
            let circleView = CircleView(borderHeight: self.borderHeight, fillSize: self.fillSize, fillColor: self.fillColor)
            
            self.addArrangedSubview(circleView)
        }
        
        self.refreshProgress()
    }
    
    fileprivate func refreshProgress() {
        self.arrangedSubviews.enumerated().forEach { (index: Int, view: UIView) in
            guard let circleView = view as? CircleView else { return }
            
            circleView.fill = (self.progress > index)
        }
    }
    
}
