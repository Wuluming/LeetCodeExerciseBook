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
        
        
        
        
        
        
        
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
