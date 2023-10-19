import UIKit

class FizzBuzzViewController: UIViewController, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell") // Registering the custom cell
        tableView.rowHeight = UITableView.automaticDimension // Setting automatic dimensions for row height
        tableView.estimatedRowHeight = 44
        return tableView
    }()


    private var fizzBuzzResults: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        // Create a new UILabel
        let titleLabel = UILabel()
        titleLabel.text = "Fizz Buzz"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)

        navigationItem.titleView = titleLabel
      
        navigationController?.navigationBar.tintColor = .black
        
        setupTableView()
        calculateFizzBuzz()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.separatorColor = .systemGray4
        tableView.backgroundColor = .clear
        
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func calculateFizzBuzz() {
        for number in 1...100 {
            fizzBuzzResults.append(fizzBuzz(number))
        }
        tableView.reloadData()
    }
    
    func fizzBuzz(_ number: Int) -> String {
        var result = ""

        if number % 3 == 0 { result += "Fizz" }
        if number % 5 == 0 { result += "Buzz" }
        if result.isEmpty { result = "\(number)" }

        return result
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fizzBuzzResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let result = fizzBuzzResults[indexPath.row]
        
        cell.textLabel?.text = result
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        
        switch result {
        case "Fizz":
            cell.backgroundColor = UIColor.blue
            cell.textLabel?.textColor = UIColor.white
        case "Buzz":
            cell.backgroundColor = UIColor.red
            cell.textLabel?.textColor = UIColor.white
        case "FizzBuzz":
            cell.backgroundColor = UIColor.green
            cell.textLabel?.textColor = UIColor.white
        default:
            cell.backgroundColor = UIColor.systemBackground
            cell.textLabel?.textColor = UIColor.label
        }
        return cell
    }

}

class CustomTableViewCell: UITableViewCell {
    let customLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(customLabel)
        NSLayoutConstraint.activate([
            customLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            customLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            customLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])

    }
}
