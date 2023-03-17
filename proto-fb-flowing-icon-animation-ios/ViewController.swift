//
//  ViewController.swift
//  proto-fb-flowing-icon-animation-ios
//
//  Created by Santosh Krishnamurthy on 3/17/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let curvedView = CurvedView(frame: view.frame)
//        curvedView.backgroundColor = .yellow
//        view.addSubview(curvedView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }

    @objc func handleTap(gesture: UITapGestureRecognizer) -> Void {
        let location = gesture.location(in: view)
        print("tap detected at \(location)")
        
        (0...10).forEach { (_) in
            generateanimatedView()
        }
        
    }
    
    private func generateanimatedView() -> Void{
        let image = drand48() > 0.5 ? UIImage(named: "confused") : UIImage(named: "icons8-heart-suit-96")
        let imageView = UIImageView(image: image)
        // drand wll return a value between 0 - 1
        let size = 20 + drand48() * 10
        // set the image size
        imageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        view.addSubview(imageView)
        
        // create animation for layer
        let animation = CAKeyframeAnimation(keyPath: "position")
        // set the path of animation
        animation.path = customPath().cgPath
        // set duration of animation
        animation.duration = 2 + drand48() * 3
        // set fill mode
        animation.fillMode = .forwards
        // removed the animation on completion
        animation.isRemovedOnCompletion = false
        // set the timing function
        animation.timingFunctions = [CAMediaTimingFunction(name: .easeOut)]
        // add animation to layer
        imageView.layer.add(animation, forKey: nil)
    }

}

func customPath() -> UIBezierPath {
    // Create new UIBezierPath object
    let path = UIBezierPath()
    // move to a start point
    path.move(to: CGPoint(x: 0, y: 200))
    
    // declare the end point
    let endPoint = CGPoint(x: 400, y: 200)
    // addLine adds a straignt line
    // path.addLine(to: endPoint)
    
    // create random shift in Y axis
    let randomYShift = 200 + drand48() * 300
    // draw a curve by adding control pooints
    let controlPoint1 = CGPoint(x: 100, y: 100 - randomYShift)
    let controlPoint2 = CGPoint(x: 300, y: 300 + randomYShift)
    path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    
    return path
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        let path = customPath()
        // change the line width
        path.lineWidth = 3
        // draw the line
        path.stroke()
    }
}
