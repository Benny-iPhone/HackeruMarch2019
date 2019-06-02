//
//  ViewController.swift
//  SlotMachinePicker
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class SlotMachineViewController: UIViewController {
    
    enum Result{
        case none
        case win
        case lose
    }
    
    var result : Result = .none
    
    @IBOutlet weak var resultLabel: UILabel!
    let imagesArray : [UIImage] = [
        "apple",
        "bar",
        "bell",
        "seven",
        "watermelon",
        "cherry"].compactMap{ UIImage(named: $0)}

    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.isUserInteractionEnabled = false
        
        makeRandomSelection(animted: false)
        updateLabelByResult()
    }
    
    private func determineResult() -> Result{
        
        var arr : [Int] = [Int](repeating: -1, count: pickerView.numberOfComponents) //[-1,-1,-1]
        for i in 0..<pickerView.numberOfComponents{
            
            let selectedRow = pickerView.selectedRow(inComponent: i)
            let value = selectedRow % imagesArray.count
            arr[i] = value
            
        }
        
        //[4,4,5]
        //arr.reduce(true, {$0 && $1 == arr[0]})
        
        let checkValue = arr[0]
        for i in 1..<arr.count{
            if arr[i] != checkValue { return Result.lose }
        }
        
        return Result.win
        
    }
    
    private func updateLabelByResult(){
        switch result {
        case .none:
            resultLabel.text = ""
        case .win:
            resultLabel.text = "WIN"
            resultLabel.textColor = .blue
            resultLabel.font = UIFont.boldSystemFont(ofSize: 48)
        case .lose:
            resultLabel.text = "Lose"
            resultLabel.textColor = .black
            resultLabel.font = UIFont.systemFont(ofSize: 24)
        }
    }

    @IBAction func spinAction(_ sender: UIButton) {
        sender.isEnabled = false
        self.result = .none
        updateLabelByResult()
        
        makeRandomSelection(animted: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            sender.isEnabled = true
            guard let strongSelf = self else { return }
            strongSelf.result = strongSelf.determineResult()
            strongSelf.updateLabelByResult()
        }
        
    }
    
    var roundsCount : Int { return 10 }
    
    private func makeRandomSelection(animted : Bool){
        for comp in 0..<pickerView.numberOfComponents{
            let maxIndex = imagesArray.count * (roundsCount - 2)
            let index = Int(arc4random_uniform(UInt32(maxIndex))) + imagesArray.count //6..<54
            
            pickerView.selectRow(index, inComponent: comp, animated: animted)
        }
    }
    
}

extension SlotMachineViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imagesArray.count * roundsCount
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //TODO: - Embed in UIView
        let index = row % imagesArray.count
        return UIImageView(image: imagesArray[index])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return imagesArray[0].size.height + 8
    }
}

