//
//  RadioStationViewController.swift
//  Radio
//
//  Created by Benny Davidovitz on 18/08/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import UIKit

class RadioStationViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    var currentStation : RadioStation?{
        didSet{
            refresh()
        }
    }
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.currentStation = SharedData.shared.selectedStation
        
        refresh()
    }
    
    private func refresh(){
        if let currentStation = self.currentStation{
            navigationItem.title = currentStation.name
        } else {
            navigationItem.title = "No Station Selected"
        }
        
    }
    
    //MARK: - Actions
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        guard let currentStation = self.currentStation else {
            browseStationAction(sender)
            return
        }
        
        //play / pause, whatever
        let controller = MusicController.shared
        if controller.isPlaying{
            //pause
            controller.pause()
            actionButton.setImage(UIImage(named: "icons8-play_filled"), for: .normal)
        } else {
            //play
            controller.play(item: currentStation)
            actionButton.setImage(UIImage(named: "icons8-pause_filled"), for: .normal)
        }
    }
    
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        MusicController.shared.set(volume: sender.value)
    }
    
    @IBAction func browseStationAction(_ sender: Any) {
        self.performSegue(withIdentifier: "pickerSegue", sender: sender)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? StationPickerViewController{
            nextVC.selectedStation = self.currentStation
            nextVC.delegate = self
        }
    }
    
}

extension RadioStationViewController : StationPickerViewControllerDelegate{
    
    func stationPickerViewController(_ controller: StationPickerViewController, didSelect station: RadioStation) {
        
        SharedData.shared.selectedStation = station
        self.currentStation = station
        refresh()
        
    }
    
}
