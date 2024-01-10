import UIKit

final class AddCarViewContoller: UIViewController {
    // MARK: - PROPERTIES:

    private let nameTextField = UITextField()
    private let colorTextField = UITextField()
    private let yearTextField = UITextField()
    private let distanceTextField = UITextField()
    private let saveButton = UIButton()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubview(nameTextField)
        view.addSubview(colorTextField)
        view.addSubview(yearTextField)
        view.addSubview(distanceTextField)
        view.addSubview(saveButton)
    }

    // MARK: - CONFIGURE CONSTARAINTS:

    private func configureConstraints() {
        // MARK: NAME CAR:

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: COLOR CAR:
        
        colorTextField.translatesAutoresizingMaskIntoConstraints = false
        colorTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        colorTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        colorTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: YEAR CAR:
        
        yearTextField.translatesAutoresizingMaskIntoConstraints = false
        yearTextField.topAnchor.constraint(equalTo: colorTextField.bottomAnchor, constant: 20).isActive = true
        yearTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yearTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        yearTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: DISTANCE CAR:
        
        distanceTextField.translatesAutoresizingMaskIntoConstraints = false
        distanceTextField.topAnchor.constraint(equalTo: yearTextField.bottomAnchor, constant: 20).isActive = true
        distanceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        distanceTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        distanceTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: distanceTextField.bottomAnchor, constant: 20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .darkGray
        
        // MARK: NAME CAR:
        
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = .init(genericCMYKCyan: 1, magenta: 0.5, yellow: 0.5, black: 0.5, alpha: 1)
        nameTextField.textAlignment = .center
        nameTextField.placeholder = "Name car"
        
        // MARK: COLOR CAR:
        
        colorTextField.layer.borderWidth = 1
        colorTextField.layer.borderColor = .init(genericCMYKCyan: 1, magenta: 0.5, yellow: 0.5, black: 0.5, alpha: 1)
        colorTextField.textAlignment = .center
        colorTextField.placeholder = "Color car"
        
        // MARK: YEAR CAR:
        
        yearTextField.layer.borderWidth = 1
        yearTextField.layer.borderColor = .init(genericCMYKCyan: 1, magenta: 0.5, yellow: 0.5, black: 0.5, alpha: 1)
        yearTextField.textAlignment = .center
        yearTextField.placeholder = "Year car"
        
        // MARK: DISTANCE CAR:
        
        distanceTextField.layer.borderWidth = 1
        distanceTextField.layer.borderColor = .init(genericCMYKCyan: 1, magenta: 0.5, yellow: 0.5, black: 0.5, alpha: 1)
        distanceTextField.textAlignment = .center
        distanceTextField.placeholder = "Distance car"
        
        // MARK: SAVE BUTTON:
        
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = .init(genericCMYKCyan: 1, magenta: 0.5, yellow: 0.5, black: 0.5, alpha: 1)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(tapOnSaveButton), for: .touchUpInside)
    }
    
    // MARK: - HELPERS:
    
    // MARK: TAP ON SAVE BUTTON:
    
    @objc private func tapOnSaveButton() {
        guard let name = nameTextField.text,
              let color = colorTextField.text,
              let year = yearTextField.text,
              let distance = distanceTextField.text
        else { return }
        
        let result = CoreDataManager.instance.saveCar(name: name, color: color, year: Int(year) ?? 0, distance: Int(distance) ?? 0)
        
        switch result {
        case .success:
            print("Saved")
            let alertSuccess = UIAlertController(title: "Сообщение", message: "Машина добавлена", preferredStyle: .alert)
            alertSuccess.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                
            }))
            present(alertSuccess, animated: true)
        case .failure(let failure):
            print(failure)
            let alertFailure = UIAlertController(title: "Ошибка", message: "Произошла ошибка", preferredStyle: .alert)
            alertFailure.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { _ in
                
            }))
            present(alertFailure, animated: true)
        }
    }
}
