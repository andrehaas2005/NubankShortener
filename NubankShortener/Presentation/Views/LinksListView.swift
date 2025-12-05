//
//  LinksListView.swift
//  NubankShortener
//
//  Created by Andre  Haas on 04/12/25.
//


import UIKit
import Core

final class LinksListView: UIView, UITableViewDataSource, UITableViewDelegate {

    private var items: [AliasResponse] = []

    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .clear
        return tv
    }()

    private let emptyStateLabel: UILabel = {
        let l = UILabel()
        l.text = "Nenhum link encurtado ainda"
        l.font = Theme.Typography.body
        l.textColor = Theme.muted
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        addSubview(tableView)
        addSubview(emptyStateLabel)

        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func update(_ newItems: [AliasResponse]) {
        items = newItems
        tableView.reloadData()
        emptyStateLabel.isHidden = !items.isEmpty
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var conf = cell.defaultContentConfiguration()
        conf.text = item.alias
        conf.secondaryText = item.links.short
        conf.textProperties.font = Theme.Typography.body
        conf.secondaryTextProperties.font = Theme.Typography.caption
        cell.contentConfiguration = conf
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 72 }
}
