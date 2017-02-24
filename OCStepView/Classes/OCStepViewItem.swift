//
//  OCStepViewItem.swift
//  OCStepView
//
//  Created by Evgene Podkorytov on 23.02.17.
//  Copyright © 2017 OverC. All rights reserved.
//

import Foundation

public class OCStepViewItem {
    internal let title: String!
    internal var isEnabled: Bool = true
    
    public init(title: String, isEnabled: Bool) {
        self.title = title
        self.isEnabled = isEnabled
    }
}
