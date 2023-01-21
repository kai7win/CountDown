//
//  ViewController.swift
//  CountDown
//
//  Created by Kai Chi Tsao on 2023/1/21.
//

import UIKit

class ViewController: UIViewController {
    var timer: Timer?
    var remainingTime = 15
    var timeLabel: UILabel!
    var shapeLayer: CAShapeLayer!
    var restartButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 創建倒計時顯示文本
        timeLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 50, y: view.frame.height/2 - 25, width: 100, height: 50))
        timeLabel.textAlignment = .center
        timeLabel.text = "15"
        view.addSubview(timeLabel)
        
        // 創建環形進度條
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: view.frame.width/2 - 50, y: view.frame.height/2 - 50, width: 100, height: 100)
        shapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: 50, y: 50), radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true).cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        shapeLayer.shadowColor = UIColor.darkGray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 2, height: 2)
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.shadowRadius = 2.0
        view.layer.addSublayer(shapeLayer)
        
        // 創建並啟動定時器
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        // 創建重置按鈕
        restartButton = UIButton(frame: CGRect(x: view.frame.width/2 - 50, y: shapeLayer.frame.maxY + 10, width: 100, height: 50))
        restartButton.setTitle("Restart", for: .normal)
        restartButton.setTitleColor(.black, for: .normal)
        restartButton.addTarget(self, action: #selector(restartCountdown), for: .touchUpInside)
        restartButton.isHidden = true
        view.addSubview(restartButton)
        
    }
    
    // 更新倒計時和進度條
    @objc func updateTime() {
        remainingTime -= 1
        timeLabel.text = "\(remainingTime)"
        // 添加放大縮小動畫
        UIView.animate(withDuration: 0.5, animations: {
           self.timeLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
           UIView.animate(withDuration: 0.5) {
               self.timeLabel.transform = CGAffineTransform.identity
           }
        })
        let progress = CGFloat(remainingTime) / CGFloat(15)
        shapeLayer.strokeEnd = progress
        if remainingTime == 0 {
            timer?.invalidate()
            restartButton.isHidden = false
        }
    }
    
    // 重置倒計時
    @objc func restartCountdown() {
    remainingTime = 15
    timeLabel.text = "15"
    shapeLayer.strokeEnd = 1
    timer?.invalidate()
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
}
