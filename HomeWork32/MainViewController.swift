import UIKit

final class MainViewController: UIViewController {
    // MARK: - PROPERTIES:

    private let tableView = UITableView()
    
    var cars = [Car]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - LIFECYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureUI()
        configureConstraints()
        configureNavigationBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    
    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    // MARK: - CONFIGURE CONSTARAINTS:

    private func configureConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .systemFill
    }
    
    // MARK: - CONFIGURE NAVIGATION BAR:
    
    private func configureNavigationBar() {
        title = "CARS"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [weak self] _ in
            let secondViewController = AddCarViewContoller()
            self?.navigationController?.pushViewController(secondViewController, animated: true)
        }))
    }
    
    // MARK: - CONFIGURE TABLE VIEW:
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemFill
        tableView.separatorStyle = .singleLine
    }
    
    // MARK: - LOAD CARS:
    
    private func loadCars() {
        let operationResult = CoreDataManager.instance.getCars()
        switch operationResult {
        case .success(let cars):
            self.cars = cars
        case .failure(let failure):
            print(failure)
        }
    }
}

// MARK: - EXTENSION:

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNTS CARS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cars.count
    }
    
    // MARK: CELL:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "carCell")
        let car = cars[indexPath.row]
        cell.contentView.backgroundColor = .lightGray
        cell.textLabel?.text = (car.name ?? "") + " (" + car.year.description + " year., color: " + (car.color ?? "") + ") "
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: DELETE CAR:
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let car = cars[indexPath.row]
        if editingStyle == .delete {
            let alertDelete = UIAlertController(title: "Delete", message: "Delete this car?", preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            alertDelete.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                _ = CoreDataManager.instance.deleteCar(car)
                self.loadCars()
            }))
            present(alertDelete, animated: true)
        }
    }
}
