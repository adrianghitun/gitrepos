//
//  TableSection.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation

class TableSection {
    var title: String?
    var cells: [TableCellViewModel]
    
    init(title: String? = nil, cells: [TableCellViewModel] = []) {
        self.title = title
        self.cells = cells
    }
}

