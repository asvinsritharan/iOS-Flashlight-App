//
//  ViewController.swift
//  Light
//
//  Created by Asvin Sritharan on 2020-05-31.
//  Copyright © 2020 AsvinSritharan. All rights reserved.
//

import UIKit
import AVFoundation

//create a variable to detect whether the light is on
var lightOn = true
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        // button is pressed
        // make the light on variable to the opposite boolean
        lightOn.toggle()
        // set the flashlight on
        toggleLight()
        // make screen white if light is on, black if off
        updateUI()
    }
    func toggleLight () {
        // () -> Nil
        // Turn on the flashlight if possible.
        
        // enable the device to control the torch of the device
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        // if the device has a torch proceed or else set the button to say "Flashlight Unavailable"
        guard device.hasTorch else { lightButton.setTitle("Flashlight Unavailable", for: .normal); return }
        do {
            // lock the phone so only the app can control the flashlight
            try device.lockForConfiguration()
            // switch the torch on or off depending on its current state
            device.torchMode = lightOn ? .on : .off
            // once we complete, unlock the device so other apps
            // can control the flashlight
            device.unlockForConfiguration()
        } catch {
            // if an error is caught then set the button to say the flashlight is unavailable
            lightButton.setTitle("Flashlight Unavailable", for: .normal)
        }
    }
    
    @IBOutlet weak var lightButton: UIButton!
    func updateUI() {
        // change background so it is white if light is on and black if it is off
        view.backgroundColor = lightOn ? .white : .black
    }
    
}

