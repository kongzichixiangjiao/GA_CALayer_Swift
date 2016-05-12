//
//  ViewController.swift
//  GA_CALayer_Swift
//
//  Created by houjianan on 16/5/11.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    let image = UIImage(named: "imageName.jpg")
    let myLayer: CALayer = CALayer()
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let maskLayer: CAShapeLayer = CAShapeLayer()
    let rect = CGRectMake(100, 100, 100, 100)
    let duration: Double = 1
    
    let layerV: CAShapeLayer = CAShapeLayer()
    
    @IBAction func startAction1(sender: UIButton) {
        
        let v = self.view.viewWithTag(100)
//        addAnimation(1, toValue: 0.3, keyPath: "transform.scale.x") { (a) -> () in
//            self.layerV.addAnimation(a, forKey: "x")
//        }
        let x = v!.frame.size.width / 2 - 13  //差的13像素不知道为什么
        let y: CGFloat = 0
        let w: CGFloat = 30
        let h = v!.frame.size.height
        let morphedFrame = CGRectMake(x, y, w, h)
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = duration
        morphAnimation.toValue = UIBezierPath(ovalInRect: morphedFrame).CGPath
        morphAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        layerV.addAnimation(morphAnimation, forKey: nil)
        
    }
    
    @IBAction func startAction(sender: AnyObject) {
        
        let morph1 = addAnimation(NSValue(CGRect: rect), toValue: NSValue(CGRect: view.bounds), keyPath: "bounds") { (a) -> () in
            self.myLayer.bounds = self.view.bounds
        }
        
        let morph2 = addAnimation(NSValue(CGPoint: CGPointMake(150, 150)), toValue: NSValue(CGPoint: CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2)), keyPath: "position") { (a) -> () in
            self.myLayer.position = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
            //            self.myLayer.addAnimation(a, forKey: "animat")
        }
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = duration
        groupAnimation.animations = [morph1, morph2]
        myLayer.addAnimation(groupAnimation, forKey: nil)
        
        let squarePath = UIBezierPath(ovalInRect: view.bounds).CGPath
        addAnimation(shapeLayer.path!, toValue: squarePath, keyPath: "path") { (a) -> () in
            self.shapeLayer.addAnimation(a, forKey: nil)
            self.maskLayer.addAnimation(a, forKey: nil)
            self.shapeLayer.path = squarePath
            self.maskLayer.path = squarePath
        }
        
        self.performSelector("restore", withObject: self, afterDelay: duration)
    }
    
    func restore() {
        myLayer.frame = rect
        shapeLayer.path = UIBezierPath(ovalInRect: rect).CGPath
        maskLayer.path = UIBezierPath(ovalInRect: myLayer.bounds).CGPath
    }
    
    func addAnimation<T: AnyObject>(fromValue: T, toValue: T, keyPath: String, handler: (a: CABasicAnimation) -> ()) -> CABasicAnimation  {
        let morph1 = CABasicAnimation(keyPath: keyPath)
        morph1.duration = self.duration
        morph1.fromValue = fromValue
        morph1.toValue = toValue
        handler(a: morph1)
        return morph1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let r = CGRectMake(20, 200, 140, 140)
        let backV = UIView(frame: r)
        self.view.addSubview(backV)
        backV.backgroundColor = UIColor.redColor()
        
        let v = UIView(frame: r)
        self.view.addSubview(v)
        v.backgroundColor = UIColor.orangeColor()
        v.tag = 100
        v.layer.contents = image!.CGImage
        
        layerV.path = UIBezierPath(ovalInRect: v.layer.bounds).CGPath
        layerV.position = CGPoint(x: 0, y: 0)
        v.layer.mask = layerV
        
        let lineV = UIView(frame: CGRectMake(90, 190, 1, 200))
        view.addSubview(lineV)
        lineV.backgroundColor = UIColor.redColor()
        
        
        
        view.layer.addSublayer(myLayer)
        myLayer.frame = rect
        myLayer.contents = image!.CGImage
        
        shapeLayer.path = UIBezierPath(ovalInRect: rect).CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        view.layer.addSublayer(shapeLayer)
        
        maskLayer.path = UIBezierPath(ovalInRect: myLayer.bounds).CGPath
        maskLayer.position = CGPoint(x: 0, y: 0)
        myLayer.mask = maskLayer
    }
    
}

extension CGRect {
    func toNSValue() -> NSValue {
        return NSValue(CGRect: self)
    }
}

