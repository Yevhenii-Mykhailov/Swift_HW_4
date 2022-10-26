//
//  Extensions.swift
//  Homework_4
//
//  Created by Yevhenii M on 26.10.2022.
//

import Foundation

extension String {
    func leaveByOffset(offSet: Int) -> Substring {
        let index = self.index(self.startIndex, offsetBy: offSet)
        let mySubstring = self[..<index]
        return mySubstring
    }
}
