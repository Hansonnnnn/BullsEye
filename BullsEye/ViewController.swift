//
//  ViewController.swift
//  BullsEye
//
//  Created by 谢振宇 on 2018/1/17.
//  Copyright © 2018年 谢振宇. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var targetLabel:UILabel!
    @IBOutlet weak var scoreLabel:UILabel!
    @IBOutlet weak var roundlabel:UILabel!
//    var currentValue: Int = 0
//    var targetValue:Int = 0
    //也可以这样写，只有在没给变量赋初值时，才需要指定变量类型
    var audioPlayer: AVAudioPlayer!
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
        //设置滑动条的外观
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
//            UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
//            UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top:0, left:14, bottom:0, right:14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
//            UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
//            UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        playBgMusic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(){
//        var difference: Int = 0
//        if(currentValue >= targetValue){
//            difference = currentValue - targetValue
//        }else if(targetValue > currentValue){
//            difference = targetValue - currentValue
//        }
        //或者可以这样写
//        var difference = currentValue - targetValue
//        if(difference < 0){
//            difference = -difference
//        }
        //使用函数变得更简洁，但是let和var的区别是什么？let定义的是一个常量，而var定义的是变量，常量之后不能再赋值
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        let title: String
        if(difference == 0){
            title = "运气逆天！赶紧去买注彩票吧！"
            points += 100
        }else if(difference < 5){
            title = "太棒了！差一点就到了！"
            if(difference == 1){
                points += 50
            }
        }else if(difference < 10){
            title = "很不错！继续努力！"
        }else{
            title = "差太远了，君在长江头，我在长江尾~"
        }
        score += points
        round += 1
        let message = "得分是: \(points)"
        let alert = UIAlertController(title:title,message:message, preferredStyle: .alert)
        //handler: nil:nil表示该事件不触发任何处理过程，仅仅是关闭
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in self.startNewRound()})
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
//        startNewRound()
    }
//    区分某个方法是否是动作方法很简单，只需要看前面是否有@IBAction即可
    @IBAction func slidermoved(slider: UISlider){
        currentValue = lroundf(slider.value)
//        print("滑动条当前的数值是：\(slider.value)")
    }
    
    func startNewRound(){
        //arc4random_uniform函数能得到的最大数字是99
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundlabel.text = String(round)
        //或者可以使用这样的方式进行强制类型转换
//        targetLabel.text = "\(targetValue)"
    }
    
    @IBAction func startOver(){
        startNewGame()
    }
    
    func startNewGame(){
        score = 0
        round = 0
        //这里不能直接调用updateLabels()，要清楚函数的调用关系，updateLabels是在startNewRound里面调用的
        startNewRound()
        //add crossfade effects
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    //play background music
    func playBgMusic(){
        let musicPath = Bundle.main.path(forResource: "bgmusic", ofType: "mp3")
        let url = URL.init(fileURLWithPath: musicPath!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch _ {
            audioPlayer = nil
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}

