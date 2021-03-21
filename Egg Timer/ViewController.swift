//
//  ViewController.swift
//  Egg Timer
//
//  Created by Иван Демченко on 2019-08-09.
//  Copyright © 2019 Ivan Demchenko. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    
    @IBOutlet weak var SoftBoiledBtn: UIButton!
    @IBOutlet weak var InAPouchBtn: UIButton!
    @IBOutlet weak var HardBoiledBtn: UIButton!
    
    
    @IBAction func SoftBtnPressed(_ sender: Any) {
        if !isStarted{
            selectedType[2] = false
            selectedType[1] = false
            selectedType[0] = true
            setHightlighingForButtons()
            refreshTimer()
        }
    }
    
    @IBAction func PounchBtnPressed(_ sender: Any) {
        if !isStarted{
            selectedType[2] = false
            selectedType[1] = true
            selectedType[0] = false
            setHightlighingForButtons()
            refreshTimer()
        }
    }
    
    @IBAction func HardBtnPressed(_ sender: Any) {
        if !isStarted{
            selectedType[2] = true
            selectedType[1] = false
            selectedType[0] = false
            setHightlighingForButtons()
            refreshTimer()
        }
    }
    
        
    @IBOutlet weak var StartBtn: UIButton!
    
    @IBAction func StartBtnPressed(_ sender: Any) {
        if !isStarted{
            counter = getCurrentTimer()
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.TimerAction), userInfo:nil , repeats: true)
            StartBtn.setImage(UIImage(named: "StopBtn.png"), for: UIControl.State())
            isStarted = true
            disableButtons()
        } else {
            isStarted = false
            timer.invalidate()
            refreshTimer()
            enableButtons()
            setHightlighingForButtons()
            StartBtn.setImage(UIImage(named: "PlayBtn.png"), for: UIControl.State())
        }
        
    }
    
    @objc func TimerAction(){
        counter! -= 1
        if counter! < 0 {
            TimerLabel.text = "Ready"
            AudioServicesPlaySystemSound(SystemSoundID(1304))
            AudioServicesPlaySystemSound(SystemSoundID(4095))
        } else{
            TimerLabel.text = NSString(format: "%0.2d:%0.2d", counter!/60, counter!%60) as String
        }
    }
    
    
    
    
    
    
    let SoftBoiledConst = 240
    let InAPounchConst = 360
    let HardBoiledConst = 450
    
    var selectedType = Array(repeating: false, count: 3)
    var timer = Timer()
    var isStarted = false
    var counter: Int?
    
    func refreshTimer(){
        counter = getCurrentTimer()
        TimerLabel.text = NSString(format: "%0.2d:%0.2d", counter!/60, counter!%60) as String
    }
    
    
    func disableButtons(){
        SoftBoiledBtn.isEnabled = false
        InAPouchBtn.isEnabled = false
        HardBoiledBtn.isEnabled = false
    }
    
    func enableButtons(){
        SoftBoiledBtn.isEnabled = true
        InAPouchBtn.isEnabled = true
        HardBoiledBtn.isEnabled = true
    }
    
    @IBOutlet weak var TimerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedType[2] = true
        setHightlighingForButtons()

        TimerLabel.text = NSString(format: "%0.2d:%0.2d", HardBoiledConst/60, HardBoiledConst%60) as String
        
    }
    
    func getCurrentTimer() -> Int{
        if selectedType[0] {
            return SoftBoiledConst
        } else if selectedType[1] {
            return InAPounchConst
        } else {
            return HardBoiledConst
        }
    }
    
    
    func setHightlighingForButtons(){
        if selectedType[0]{
            SoftBoiledBtn.isHighlighted = false
            InAPouchBtn.isHighlighted = true
            HardBoiledBtn.isHighlighted = true
        } else if selectedType[1]{
            SoftBoiledBtn.isHighlighted = true
            InAPouchBtn.isHighlighted = false
            HardBoiledBtn.isHighlighted = true
        } else{
            SoftBoiledBtn.isHighlighted = true
            InAPouchBtn.isHighlighted = true
            HardBoiledBtn.isHighlighted = false
        }
    }
    
    
    
}

