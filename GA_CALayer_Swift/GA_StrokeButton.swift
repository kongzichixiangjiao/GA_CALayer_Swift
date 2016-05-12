//
//  GA_StrokeButton.swift
//  GA_CALayer_Swift
//
//  Created by houjianan on 16/5/11.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class GA_StrokeButton: UIButton {
    
    @IBInspectable weak var image: UIImage?
    
    @IBInspectable var name: String? {
        didSet {
            self.setTitle(name, forState: .Normal)
        }
    }
    
    let myLayer: CALayer = CALayer()
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let maskLayer: CAShapeLayer = CAShapeLayer()
    let duration: Double = 2
    
    override func didMoveToWindow() {
        self.layer.addSublayer(myLayer)
        myLayer.frame = self.bounds
        myLayer.contents = image?.CGImage
        
        shapeLayer.path = UIBezierPath(ovalInRect: self.bounds).CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        self.layer.addSublayer(shapeLayer)
        
        maskLayer.path = shapeLayer.path
        maskLayer.position = CGPoint(x: 0, y: 0)
        
        myLayer.mask = maskLayer
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        startAction()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.performSelector("restore", withObject: self, afterDelay: 0.1)
    }
    
    func startAction() {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8)
        }
    }
    
    func restore() {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.transform = CGAffineTransformScale(self.transform, 1.25, 1.25)
        }
    }
    
    func addAnimation<T: AnyObject>(fromValue: T, toValue: T, keyPath: String, handler: (a: CABasicAnimation) -> ()) -> CABasicAnimation  {
        let morph1 = CABasicAnimation(keyPath: keyPath)
        morph1.duration = self.duration
        morph1.removedOnCompletion = true
        morph1.fromValue = fromValue
        morph1.toValue = toValue
        handler(a: morph1)
        return morph1
    }
    
}
