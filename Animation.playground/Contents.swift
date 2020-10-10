//: A UIKit based Playground for presenting user interface
//https://www.jianshu.com/p/f2def3da931f
import UIKit
import PlaygroundSupport
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
let margin_ViewMidPosition: CGFloat = 10
let margin_ViewWidthHeight: CGFloat = 10


class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
//        CABasicAnimation 基础动画
//        CAKeyframeAnimation 关键帧g动画
//        CAAnimationGroup 组动画
//        CATransition 过渡动画
        
        
        let rectagle = UIView()
        rectagle.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        rectagle.backgroundColor = UIColor.red
        view.addSubview(rectagle)
        
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.fromValue = CGPoint(x: 100, y: 150)
//        animation.toValue = CGPoint(x: 300, y: 150)
//        animation.duration = 1.0
//        animation.autoreverses = true
//        rectagle.layer.add(animation, forKey: "positionAnimation")
        
//        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
//        animation.toValue = NSNumber(value: Double.pi)
//        animation.duration = 0.1
//        animation.repeatCount = 1e100
//        rectagle.layer.add(animation, forKey: "ratateAnimation")
        
//        let animation = CABasicAnimation(keyPath: "transform.scale")
//        animation.toValue = NSNumber(value: 2.0)
//        animation.duration = 1.0
//        animation.autoreverses = true
//        rectagle.layer.add(animation, forKey: "scaleAnimation")
        
//        let animation = CABasicAnimation(keyPath: "backgroundColor")
//        animation.toValue = UIColor.green.cgColor
//        animation.duration = 1.0
//        animation.autoreverses = true
//        rectagle.layer.add(animation, forKey: "backgroundColorAnimation")
        
//        let animation = CAKeyframeAnimation(keyPath: "position")
//        let value_0 = CGPoint(x: margin_ViewMidPosition, y: kScreenH/2 - margin_ViewWidthHeight)
//        let value_1 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 - margin_ViewWidthHeight)
//        let value_2 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 + margin_ViewMidPosition)
//        let value_3 = CGPoint.init(x: kScreenW * 2 / 3, y: kScreenH / 2 + margin_ViewMidPosition)
//        let value_4 = CGPoint.init(x: kScreenW * 2 / 3, y: kScreenH / 2 - margin_ViewWidthHeight)
//        let value_5 = CGPoint.init(x: kScreenW - margin_ViewMidPosition, y: kScreenH / 2 - margin_ViewWidthHeight)
//        animation.values = [value_0, value_1, value_2, value_3, value_4, value_5]
//        animation.duration = 2.0
//        rectagle.layer.add(animation, forKey: "keyFrameAnimation")
        
//        let animation = CAKeyframeAnimation(keyPath: "position")
//        let path = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100), radius: 60, startAngle: 0.0, endAngle: .pi * 2, clockwise: true)
//        animation.duration = 2.0
//        animation.path = path.cgPath
//        rectagle.layer.add(animation, forKey: "pathAnimation")
        
//        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
//        let value_0 = NSNumber(value: -Double.pi)
//        let value_1 = NSNumber(value: Double.pi)
//        animation.values = [value_0, value_1]
//        animation.duration = 0.1
//        animation.repeatCount = 1e100
//        rectagle.layer.add(animation, forKey: "shakeAnimation")
        
        
        
        let animation_Curl = CATransition()
        animation_Curl.type = CATransitionType.fade
        animation_Curl.subtype = CATransitionSubtype.fromRight
        animation_Curl.duration = 1.0
        rectagle.layer.add(animation_Curl, forKey: "curlAnimation")
        
        
        
        
        
        
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
