//
//  Extensions.swift
//  Homework_4
//
//  Created by Yevhenii M on 26.10.2022.
//

import Foundation
import UIKit

extension String {
    func leaveByOffset(offSet: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: offSet)
        let mySubstring = self[..<index]
        return String(mySubstring)
    }
}

extension UIImageView {
    func load(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
