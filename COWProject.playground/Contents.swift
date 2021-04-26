// Класс который будет находится в Структуре
final class Bag {
    /// Брэнд
    var brand: String
    /// Цвет
    var color: String
    
    init(brand: String, color: String) {
        self.brand = brand
        self.color = color
    }
}

// Структура содержащая RefferenceType
struct Girl {
    /// Имя
    var name: String
    /// Возраст
    var age: Int
    
    /// Помечаем уровень доступа приватный чтобы нельзя было изменить значения свойст напрямую
    private var bag: Bag
    
    init(name: String, age: Int, bag: Bag) {
        self.name = name
        self.age = age
        self.bag = bag
    }
    
    /// Брэнд сумочки
    var bagBrand: String {
        get { return bag.brand }
        set {
            // Проверяем, если на объект есть сильная ссылка то создаем
            // новый объект с переданным значением
            guard isKnownUniquelyReferenced(&bag) else {
                bag = Bag(brand: newValue, color: bag.color)
                return
            }
            bag.brand = newValue
        }
    }
    
    /// Цвет сумочки
    var bagColor: String {
        get { return bag.color }
        set {
            guard isKnownUniquelyReferenced(&bag) else {
                bag = Bag(brand: bag.brand, color: newValue)
                return
            }
            bag.color = newValue
        }
    }
    
    /// Вывод параметров структуры
    func printBag() {
        print("\(name), bagID: \(ObjectIdentifier(bag))")
        print("\(name), bag brand \(bag.brand)")
        print("\(name), bag color \(bag.color)")
    }
}

var anna = Girl(name: "Anna", age: 29, bag: Bag(brand: "LOUIS VUITTON", color: "Red"))

var darya = anna
darya.name = "Darya"

anna.printBag()
darya.printBag()

print("Изменяем значение")
//darya.bagTitle = "MICHAEL KORS"
darya.bagColor = "Blue"

anna.printBag()
darya.printBag()


