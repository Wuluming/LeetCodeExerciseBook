//: A UIKit based Playground for presenting user interface
//https://www.jianshu.com/p/f2def3da931f
import UIKit
import PlaygroundSupport

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
        
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor.green.cgColor
        animation.duration = 1.0
        animation.autoreverses = true
        rectagle.layer.add(animation, forKey: "backgroundColorAnimation")
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
