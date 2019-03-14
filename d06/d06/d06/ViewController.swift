//
//  ViewController.swift
//  d06
//
//  Created by Inti FRANC-REGIS on 3/14/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dynamicAnimator: UIDynamicAnimator!
    var listShapes : [Shape] = []
    var selectShape : Shape!
    let gravityBehavior = UIGravityBehavior()
    let collision = UICollisionBehavior()
    let behaviour = UIDynamicItemBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGesture(_:)))
        view.addGestureRecognizer(gTap)
        let gPan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGesture(_:)))
        view.addGestureRecognizer(gPan)
        let gPinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinchGesture(_:)))
        view.addGestureRecognizer(gPinch)
        let gRotation = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotationGesture(_:)))
        view.addGestureRecognizer(gRotation)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        gravityBehavior.magnitude = 1
        dynamicAnimator.addBehavior(gravityBehavior)
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)
        behaviour.elasticity = 0.3
        dynamicAnimator.addBehavior(behaviour)
    }

    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let newShape = Shape()
            newShape.translatesAutoresizingMaskIntoConstraints = true
            newShape.center = sender.location(in: self.view)
            self.view.addSubview(newShape)
            UIView.animate(withDuration: 0.3) {
                newShape.bounds.size = CGSize(width: 100, height: 100)
            }
            gravityBehavior.addItem(newShape)
            collision.addItem(newShape)
            behaviour.addItem(newShape)
            listShapes.append(newShape)
            print(sender.location(in: self.view))
        default:
            print("tap")
        }
    }
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for shape in listShapes{
                if ((shape.layer.presentation()?.frame.contains(tapLocation))! ){
                    selectShape = shape
                    gravityBehavior.removeItem(selectShape)
                    behaviour.removeItem(selectShape!)
                    collision.removeItem(selectShape!)
                    self.view.bringSubview(toFront: selectShape!)
                }
            }
        case .changed:
            if selectShape != nil {
                selectShape!.center = sender.location(in: self.view)
                dynamicAnimator.updateItem(usingCurrentState: selectShape!)
            }
        default:
            if selectShape != nil {
                gravityBehavior.addItem(selectShape)
                behaviour.addItem(selectShape!)
                collision.addItem(selectShape!)
                selectShape = nil
            }
        }
    }
    @objc func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        var lastdist : CGFloat = 1
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for shape in listShapes{
                if ((shape.layer.presentation()?.frame.contains(tapLocation))! ){
                    selectShape = shape
                    gravityBehavior.removeItem(selectShape)
                    behaviour.removeItem(selectShape!)
                    lastdist = sender.scale
                    self.view.bringSubview(toFront: selectShape!)
                }
            }
        case .changed:
            if selectShape != nil {
                collision.removeItem(selectShape!)
                selectShape!.bounds.size = CGSize(width: 100*(sender.scale/lastdist), height: 100*(sender.scale/lastdist))
                dynamicAnimator.updateItem(usingCurrentState: selectShape!)
                collision.addItem(selectShape!)
                
            }
        default:
            if selectShape != nil {
                gravityBehavior.addItem(selectShape)
                behaviour.addItem(selectShape!)
                selectShape = nil
            }
        }
    }
    @objc func rotationGesture(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for shape in listShapes{
                if ((shape.layer.presentation()?.frame.contains(tapLocation))! ){
                    selectShape = shape
                    gravityBehavior.removeItem(selectShape)
                    behaviour.removeItem(selectShape!)
                    collision.removeItem(selectShape!)
                    self.view.bringSubview(toFront: selectShape!)
                }
            }
        case .changed:
            if selectShape != nil {
                selectShape!.transform = selectShape!.transform.rotated(by: sender.rotation)
                dynamicAnimator.updateItem(usingCurrentState: selectShape!)
                sender.rotation = 0
            }
        default:
            if selectShape != nil {
                gravityBehavior.addItem(selectShape)
                behaviour.addItem(selectShape!)
                collision.addItem(selectShape!)
                selectShape = nil
            }
        }
    }
}

