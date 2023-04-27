//
//  ContextMenu.swift
//  Chat-test
//
//  Created by Zhekon Kovalevskiy on 27.04.2023.
//

import UIKit

protocol ContextMenu {
    static var title: String { get }
}

extension ContextMenu {
    func makeMenu() -> UIMenu {
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
            // action here
        }
        return UIMenu(title: "", children: [share])
    }
}
