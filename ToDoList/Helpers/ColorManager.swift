//
//  ColorManager.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 29/01/2022.
//

import UIKit

extension UIColor {
    public static let cellBorder = UIColor.lightGray
//    public static let checkmarkButton = #colorLiteral(red: 0.1831425726, green: 0.5046136975, blue: 0.2493971884, alpha: 1)
    public static let checkmarkButton = UIColor(red: 47/255, green: 128/255, blue: 64/255, alpha: 1)
    public static let cellBackground = UIColor(named: "cellBackground")
    public static let viewBackground = UIColor(named: "viewBackground")
    public static let roundedButton = UIColor(named: "roundedButton")
}


extension UIColor {
    
    //MARK: - UIComponents Colors
    public static let pomodoroOrange = UIColor(red: 241/255, green: 112/255, blue: 112/255, alpha: 1)
    public static let pomodoroBlue = UIColor(red: 112/255, green: 243/255, blue: 248/255, alpha: 1)
    public static let pomodoroPurple = UIColor(red: 216/255, green: 129/255, blue: 248/255, alpha: 1)
    public static let darkPurple = UIColor(red: 22/255, green: 25/255, blue: 50/255, alpha: 1)
    public static let backgroundGray = UIColor(red: 237/255, green: 241/255, blue: 251/255, alpha: 1)
    public static let lightTextColor = UIColor(red: 89/255, green: 93/255, blue: 120/255, alpha: 1)
    
    // MARK: - Background Color
    public static let backgroundPurple = UIColor(red: 30/255, green: 33/255, blue: 63/255, alpha: 1)
    
    // MARK: - Background Layer Color
    public static let backgroundPurpleLight = UIColor(red: 57/255, green: 64/255, blue: 112/255, alpha: 1)
    
}
