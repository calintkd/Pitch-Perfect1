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
    

    @IBAction func playSlow(sender: AnyObject) {
        //play audio slowly ...
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()

    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
    
        playAudioWithVariablePitch(1000)

    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
        
    }
    

    @IBAction func playReverbAudio(sender: UIButton) {
        playAudioWithVariableReverb(65,preset: .LargeChamber)
    }
    
    
    @IBAction func playEchoAudio(sender: UIButton) {
        playAudioWithVariableEcho(0.55)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)

        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)

        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()

        audioPlayerNode.play()
}
    
    func playAudioWithVariableReverb(reverb: Float, preset: AVAudioUnitReverbPreset){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changeReverbEffect = AVAudioUnitReverb()
        changeReverbEffect.loadFactoryPreset(preset)
        changeReverbEffect.wetDryMix = reverb
        audioEngine.attachNode(changeReverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeReverbEffect, format: nil)
        audioEngine.connect(changeReverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }

    func playAudioWithVariableEcho(delay: NSTimeInterval){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changeEchoEffect = AVAudioUnitDelay()
        changeEchoEffect.delayTime = delay
        audioEngine.attachNode(changeEchoEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeEchoEffect, format: nil)
        audioEngine.connect(changeEchoEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }

    
    @IBAction func stopPlaying(sender: UIButton) {
        audioPlayer.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
