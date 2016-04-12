//
//  Utils.swift
//  Toolwatch
//
//  Created by math on 2016-04-12.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String
    {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}