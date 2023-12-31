import UIKit

class LibraryHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "\(LibraryHeaderView.self)"
    @IBOutlet var titleLabel: UILabel!
}

class LibraryViewController: UITableViewController {
    
    var dataSource: UITableViewDiffableDataSource<Section, Book>!
    
    enum Section: String, CaseIterable {
        case addNew
        case readMe = "Read Me!"
        case finished = "Finished!"
    }

    @IBSegueAction func showDetailView(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow,
              let book = dataSource.itemIdentifier(for: indexPath)
        else { fatalError("Nothing selected!") }
        return DetailViewController(coder: coder, book: book)
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        tableView.register(UINib(nibName: "\(LibraryHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: LibraryHeaderView.reuseIdentifier)
        
        configurationDataSource()
        updateDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDataSource()
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Read Me!" :  nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: LibraryHeaderView.reuseIdentifier) as? LibraryHeaderView
        else { return nil }
        
        headerView.titleLabel.text = Section.allCases[section].rawValue
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section != 0 ? 60 : 0
    }
    

    // MARK: - DataSource
    func configurationDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) {
            tableView, indexPath, book -> UITableViewCell in
            if indexPath == IndexPath(row: 0, section: 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
                return cell
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell
            else { fatalError("Could not creat BookCell") }
            
            cell.titleLabel.text = book.title
            cell.authorLabel.text = book.author
            cell.bookTumbnail.image = book.image ?? LibrarySymbol.letterSquare(letter: book.title.first).image
            cell.bookTumbnail.layer.cornerRadius = 12
            if let review = book.review {
                cell.reviewLabel.text = review
                cell.reviewLabel.isHidden = false
            }
            cell.readMeBookmark.isHidden = !book.readMe
            return cell
        }
    }
    
    func updateDataSource() {
        var newSnapshot = NSDiffableDataSourceSnapshot<Section, Book>()
        newSnapshot.appendSections(Section.allCases)
        let booksByReadMe: [Bool: [Book]] = Dictionary(grouping: Library.books, by: \.readMe)
        for (readMe, books) in booksByReadMe {
            newSnapshot.appendItems(books, toSection: readMe ? .readMe : .finished)
        }
        newSnapshot.appendItems([Book.macBook], toSection: .addNew)
        dataSource.apply(newSnapshot, animatingDifferences: true)
    }
}

