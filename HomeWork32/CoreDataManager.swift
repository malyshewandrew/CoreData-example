import CoreData
import UIKit.UIApplication

enum CoreDataError: Error {
    case error(String)
}

final class CoreDataManager {
    static let instance = CoreDataManager()
    private init() {}

    // MARK: SAVE CAR:

    func saveCar(name: String, color: String, year: Int, distance: Int) -> Result<Void, CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "Car", in: managedContext)!

        let car = NSManagedObject(entity: entity, insertInto: managedContext)

        car.setValue(name, forKey: "name")
        car.setValue(color, forKey: "color")
        car.setValue(year, forKey: "year")
        car.setValue(distance, forKey: "distance")

        do {
            try managedContext.save()
        } catch {
            return .failure(.error("Could not save. \(error)"))
        }

        return .success(())
    }

    // MARK: GET CARS:

    func getCars() -> Result<[Car], CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Car>(entityName: "Car")

        do {
            let objects = try managedContext.fetch(fetchRequest)
            return .success(objects)
        } catch {
            return .failure(.error("Could not fetch \(error)"))
        }
    }

    // MARK: DELETE CAR:

    func deleteCar(_ car: Car) -> Result<Void, CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        do {
            managedContext.delete(car)
            try managedContext.save()
            return .success(())
        } catch {
            return .failure(.error("Error deleting car: \(error)"))
        }
    }
}
