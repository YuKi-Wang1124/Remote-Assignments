//
//  CustomTableViewCell.swift
//  RemoteAssignmentTableView
//
//  Created by 王昱淇 on 2023/7/17.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = false
        contentView.backgroundColor = .white
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(text: String) {
        label.text = text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelSize = label.sizeThatFits(contentView.frame.size)
        label.frame = CGRect(x: 8,
                             y: (contentView.frame.size.height - labelSize.height) / 2,
                             width: labelSize.width,
                             height: labelSize.height)
    }
}
