//
//  PasscodeField.swift
//  Pods
//
//  Created by TomomuraRyota on 2016/05/30.
//
//

import UIKit

@IBDesignable open class PasscodeField: UIView {
    
    // MARK: - Properties
    
    @IBInspectable open var length: Int = 6 {
        didSet {
            self.progressView.length = self.length
        }
    }
    
    @IBInspectable open var progress: Int = 0 {
        didSet {
            self.progressView.progress = self.progress
        }
    }
    
    @IBInspectable open var borderHeight: CGFloat = 2.0 {
        didSet {
            self.progressView.borderHeight = self.borderHeight
        }
    }
    
    @IBInspectable open var fillColor: UIColor = UIColor.black {
        didSet {
            self.progressView.fillColor = self.fillColor
        }
    }
    
    @IBInspectable open var fillSize: CGFloat = 20 {
        didSet {
            self.progressView.fillSize = self.fillSize
        }
    }
    
    fileprivate var progressView: ProgressStackView
    
    // MARK: - Initializers
    
    required public init?(coder aDecoder: NSCoder) {
        self.progressView = ProgressStackView(
            length: self.length,
            progress: self.progress,
            borderHeight: self.borderHeight,
            fillSize: self.fillSize,
            fillColor: self.fillColor
        )
        
        super.init(coder: aDecoder)
        
        self.setupView()
    }
    
    override public init(frame: CGRect) {
        self.progressView = ProgressStackView(
            length: self.length,
            progress: self.progress,
            borderHeight: self.borderHeight,
            fillSize: self.fillSize,
            fillColor: self.fillColor
        )
        
        super.init(frame: frame)
        
        self.setupView()
    }
    
    // MARK: - LifeCycle
    
    override open func updateConstraints() {
        NSLayoutConstraint.activate([
            self.progressView.topAnchor.constraint(equalTo: self.topAnchor),
            self.progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
        
        super.updateConstraints()
    }
    
    // MARK: - Private Methods
    
    fileprivate func setupView() {
        self.addSubview(progressView)
    }

}
