//
//  FSCalendarTextField.swift
//  WeatherHistory
//
//  Created by hackeru on 21/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import FSCalendar

class FSCalendarTextField: UITextField {
    
    var selectedDate : Date?{
        let calendarView = self.inputView as? FSCalendar
        return calendarView?.selectedDate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        var rect = UIScreen.main.bounds
        rect.size.height = 300
        
        let calendarView = FSCalendar(frame: rect)
        calendarView.backgroundColor = .white
        calendarView.appearance.weekdayTextColor = .red
        calendarView.delegate = self
        
        self.inputView = calendarView
    }
}

extension FSCalendarTextField : FSCalendarDelegate{
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        
        self.text = formatter.string(from: date)
    }
    
}
