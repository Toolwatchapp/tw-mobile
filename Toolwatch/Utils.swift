//
//  Utils.swift
//  Toolwatch
//
//  Created by math on 2016-04-12.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func trim() -> String
    {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

extension UIView {
    /**
     Set x Position
     
     :param: x CGFloat
     by DaRk-_-D0G
     */
    func setX(x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    /**
     Set y Position
     
     :param: y CGFloat
     by DaRk-_-D0G
     */
    func setY(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    /**
     Set Width
     
     :param: width CGFloat
     by DaRk-_-D0G
     */
    func setWidth(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    /**
     Set Height
     
     :param: height CGFloat
     by DaRk-_-D0G
     */
    func setHeight(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
    
    
    func centerIn(parentFrame:CGRect){
        var frame:CGRect = self.frame;
        let h = frame.height / 2;
        let w = frame.width / 2;
        frame.origin.y = parentFrame.height/2-h;
        frame.origin.x = parentFrame.width/2-w;
        self.frame = frame;
    }
}