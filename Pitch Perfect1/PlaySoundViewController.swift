//
//  PlaySoundViewController.swift
//  Pitch Perfect1
//
//  Created by CALIN STEFAN on 9/20/15.
//  Copyright © 2015 CALIN STEFAN. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!


    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.

        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlow(sender: UIButton) {
        //play audio slowly ...
        playAudioWithVariableSpeed(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        //play audio fast
        playAudioWithVariableSpeed(1.5)

    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        let highPitch = AVAudioUnitTimePitch()
        highPitch.pitch = 1000
        playAudioWithEffect(highPitch)

    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        let lowPitch = AVAudioUnitTimePitch()
        lowPitch.pitch = -1000
        playAudioWithEffect(lowPitch)
        
    }
    

    @IBAction func playReverbAudio(sender: UIButton) {
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.LargeChamber)
        reverb.wetDryMix = 65
        playAudioWithEffect(reverb)
    }
    
    
    @IBAction func playEchoAudio(sender: UIButton) {
        let delay = AVAudioUnitDelay()
        delay.delayTime = 0.55
        playAudioWithEffect(delay)
    }
    
    func playAudioWithVariableSpeed(rate: Float){
        stopAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func stopAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithEffect(effect: NSObject){
        stopAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect as! AVAudioNode)
        
        audioEngine.connect(audioPlayerNode, to: effect as! AVAudioNode, format: nil)
        audioEngine.connect(effect as! AVAudioNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
        
    }
    
    @IBAction func stopPlaying(sender: UIButton) {
        stopAudio()
    }

}
