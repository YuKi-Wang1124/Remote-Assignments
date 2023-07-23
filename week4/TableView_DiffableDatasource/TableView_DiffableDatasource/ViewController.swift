//
//  ViewController.swift
//  TableView_DiffableDatasource
//
//  Created by 王昱淇 on 2023/7/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self
                       , forCellReuseIdentifier: "cell")
        return table
    }()
    
    enum Section {
        case zero
    }
    
    struct CellTitile: Hashable {
        let section: Int
        let row: Int
    }

    var cellTitles = [CellTitile]()
    
    var dataSource: UITableViewDiffableDataSource<Section, CellTitile>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...14 {
            let title = CellTitile(section: 0, row: i)
            cellTitles.append(title)
        }
        tableView.delegate = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "This is section \(model.section), row \(model.row)"
            cell.contentConfiguration = content
            return cell
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellTitile>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(cellTitles)
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

