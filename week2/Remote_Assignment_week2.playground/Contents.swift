import UIKit

/*:
  Batch #21 / iOS Class
 ## Remote Learning Assignment - Week 2
 ---
 #### Part 1: Object-Oriented Swift
1. Declare a class Animal with a property gender and a method eat(). The data type of gender should be enum Gender as below and when you call eat() method, it will print I eat everything!
*/

enum Gender {
    case male
    case female
    case undefined
}

class Animal {
    var gender: Gender
    
    func eat() {
        print("I eat everything!")
    }
    
    init(gender: Gender) {
        self.gender = gender
    }
}



let kitty = Animal(gender: .female)
kitty.eat()

/*:
 2. Declare three classes: Elephant, Tiger, Horse that inherits from Animal and override the eat() method to print what they usually eat.
 */

class Elephant: Animal {
    override func eat() {
        print("Elephant usually eat vegetable!")
    }
    
}


class Tiger: Animal {
    override func eat() {
        print("Tiger usually eat meat!")
    }
}


class Horse: Animal {
    override func eat() {
        print("Horse usually eat grass!")
    }
}

/*:
 3. Declare a class Zoo with a property weeklyHot which means the most popular one in the zoo this week. The codes below can’t work correctly, please find what data type should A be and solve the problem. Note that tiger, elephant, and horse are instances of class Tiger, Elephant, and Horse, respectively.
 */

class Zoo {
    var weeklyHot: Animal

    init(weeklyHot: Animal) {
        self.weeklyHot = weeklyHot
    }
}

let zoo = Zoo(weeklyHot: Tiger(gender: .undefined))
zoo.weeklyHot = Tiger(gender: .undefined)
zoo.weeklyHot = Elephant(gender: .undefined)
zoo.weeklyHot = Horse(gender: .undefined)


/*:
 4. What’s the difference between Class and Struct?
 
    1. class 是 reference typr，struct 是 Value type。
    在 class 的情況，若有互相參照的情境，在其中一個物件屬性的內容被改變時，另一個參照此物件的物件屬性內容也會被改變，因爲在記憶體中他們的屬性使用了相同的位置，因此可能會造成循環參照，最終導致程式出現 memory leak。
    在 struct 的情況下，物件間互相參照或傳遞時，會複製出一個新的記憶體位置給 struct 用
    2. struct 不能繼承，class 之間則可以繼承，因此 class 可以做型別轉換成父類別或子類別，但 struct 不可以。
    3. class 必須要建立 initilizer，在建立 class 時就必須建立好 init。
       struct 則可以從編譯器取得 memberwise initilizer，可以不用自己建 init。
    4. class 可以有 deinitializer，在移除物件時進行最後的動作，因為 class 的生命週期會有 reference count 管理，因此可以定義物件在被釋放時的操作。
        struct 的複製與消失則是swift 自動處理的，在不作用時就會被銷毀。
  
---
 5. What does Initilizer do in class and struct?
 
    class 裡需自行建立 initilizer，而 struct 的 initilizer 可不用自行建立，而是會內建一個 memberwise initilizer，兩者的 initilizer 都是在確保建立物件時，初始化物件的內容正確。兩者都可以有 convenience initilizer 但差別在於在 class 裡面的 convenience initilizer 須加關鍵字 convenience 。
 
 ---
 6. What’s the difference between reference type and value type?
 
    reference type 在建立及傳遞時，使用的是引用的內容，也就是說一經更改指派的內容，所有互相參照或傳遞的的物件內的屬性的指派內容皆會被更改。使用時需注意 reference count 的次數問題，可能會導致記憶體管理的問題。
    value type 在建立或傳遞時，使用的是複製的方式，因此在更動其中一個物件的屬性的內容時，並不會更改到其他物件的屬性內容。在使用時，value type 的建立與銷毀的生命週期都有賴於 swift 的管理，通常在不使用時即被釋放。
 
 ---
 7. What’s the difference between instance method and type method?
 
    type method 在調用時不用建立物件，直接用該型別呼叫方法，在類別內建立時需加上 class 或 static 關鍵字，static function 不可被覆寫，class function 則允許子類別複寫用 class 當關鍵字建立型別方法。
    instance method 在使用時須先建立物件，再由該物件呼叫該型別有的法法來執行。
 ，
 ---
 8. What does self mean in an instance method and a type method respectively?
 
 在 type method 裡，self 指的是該類別的本身，不需要建立物件就可調用。
 在 instance method 裡，self 指的是依照該型別建立的物件本身。
 
 ---
 #### Part 2: Enumerations and Optionals in Swift
 
 1. There are several gasoline types, 92, 95, 98, and diesel that we can use enum to model them.
 
    ● Please create an enum named Gasoline to model gasoline.
 
    ● Every kind of gasoline has its price. Please create a method named getPrice in Gasoline enum that will return different prices depending on different gasoline.
 
    ● Please establish raw values for Gasoline. The data type of raw value should be String. For example, Gasoline.oil92.rawValue should be “92”.
 
    ● Please explain what enum associated value is and how it works.
 
 */

enum Gasoline: String {
    case oil92 = "92"
    case oil95 = "95"
    case oil98 = "98"
    case diesel = "diesel"
    
    func getPrice(gasoline: Gasoline) -> Float {
        switch gasoline {
        case .oil92:
            return 28.8
        case .oil95:
            return 30.3
        case .oil98:
            return 32.3
        case .diesel:
            return 27.1
        }
    }
}

var oil: Gasoline = .oil92
print(oil.rawValue)
print("oil price is \(oil.getPrice(gasoline: .oil92))")

Gasoline.oil98.rawValue


// enum 的 associate value 像是每個 case 裡的補述，每個 case 都可以有不同的值，建立在 case 的名稱後面，用括號表示，需先預設型別，可選擇直接括號內加型別或是加上 label 再加 associate value型別。
//associate value 跟 raw value 只能擇一使用。使用時先用點語法叫出 case，再用括號帶出 associate value。在 switch 語法時，可以用 associate value 裡面的值當作範圍。


enum weather {
    case temperature(Celsius: Int)
    case humidity(percentage: Float)
    case cloud(situation: String)
    case rainfall(millimeter: Int)
}

let todayWeather = weather.temperature(Celsius: 33)

switch todayWeather {
case .temperature(Celsius: 0...20):
    print("a little bit cold")
case .temperature(Celsius: 20...):
    print("It's so boiling hot!")
case .temperature(let celsius):
    print("today's temperature is \(celsius)")
case .humidity(percentage: let percentage):
    print("today's humidity is \(percentage)")
case .cloud(situation: let situation):
    print("today's cloud is \(situation)")
case .rainfall(millimeter: let millimeter):
    print("today's rainfall is \(millimeter)")
}



/*:
 2. Optional is a very special data type in Swift. Take var a: Int? = 10 for example, the value of a will be nil or Int. You should have learned how to deal with Optional.
 
   ● People would like to have pets, but not everyone could have one. Declare a class Pet with name property and a class People with pet property which will  store a Pet instance or nil. Please try to figure out what data type is suitable for these properties in Pet and People.
 
   ● Please create a People instance. Use guard let to unwrap the pet property and print its name.
 
   ● Please create another People instance. Use if let to unwrap the pet property and print its name.
 
 */

class Pet {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class People {
    let name: String
    var pet: Pet?
    
    init(name: String) {
        self.name = name
    }
    
    convenience init(name: String, pet: Pet?) {
        self.init(name: name)
        self.pet = pet
    }
}


var dog = Pet(name: "dog")

var mandy = People(name: "Mandy",pet: dog)

var sam = People(name: "Sam", pet: nil)


func getPetName(people: People) -> String {
    guard let petName = people.pet?.name else {
        return "\(people.name) don't have a pet!"
    }
    return "\(people.name)'s pet name is \(petName)!"
}
getPetName(people: mandy)
getPetName(people: sam)


var tom = People(name: "Tom", pet: Pet(name: "Kitty"))

if let tomPetName = tom.pet?.name {
    print("The name of Tom's pet is \(tomPetName)")
} else {
    print("Tom don't have a pet!")
}


/*:
 ---
 #### Part 3: Protocol in Swift
 1. Declare a struct Person with a name property type String and a protocol name PoliceMan. There is only one method arrestCriminals with no argument and return void in the protocol.
 */

struct Person {
    let name: String
}


protocol PoliceMan {
    func arrestCriminals() -> Void
}

/*:
 2. Make struct Person conform to PoliceMan protocol.
 */

extension Person: PoliceMan {
    func arrestCriminals() {
        print("\(self.name) is arresting criminals.")
    }
}

/*:
 3. Declare a protocol ToolMan with a method fixComputer that has no argument and return void.
 */

protocol ToolMan {
    func fixComputer() -> Void
}

/*:
 4. Add a property toolMan to the struct Person with data type ToolMan.
 */

struct PersonQ4: PoliceMan {
    let name: String
    var toolman: ToolMan?
    
    func arrestCriminals() {
    }
}


/*:
 5. Declare a struct named Engineer that conforms to the ToolMan protocol.
 */

struct Engineer: ToolMan {
    func fixComputer() {
    }
}

/*:
 6. Create a Person instance with the name “Steven” and also create the relative data you need to declare this instance.
 */

PersonQ4(name: "Steven", toolman: Engineer())



/*:
 ---
 #### Part 4: Error Handling in Swift
 */
//enum GuessNumberGameError {
//    case wrongNumber
//}
//class GuessNumberGame {
//    var targetNumber = 10
//
//    func guess(number: Int) throws {
//        guard number == targetNumber else {
//            throw GuessNumberGameError.wrongNumber
//        }
//        print("Guess the right number: \(targetNumber)")
//    }
//}

/*:
 Read the code above first and paste it in the playground file, there is an error inside the code. Please solve the error by adding a piece of code in the file. Call guess(number:) and pass 20 as the argument after you fix the problem.
 */


enum GuessNumberGameError: Error {
    case wrongNumber
}

class GuessNumberGame {
    var targetNumber = 10

   func guess(number: Int) throws {
        guard number == targetNumber else {
            throw GuessNumberGameError.wrongNumber
        }
        print("Guess the right number: \(targetNumber)")
    }
}


try? GuessNumberGame().guess(number: 20)


/*:
 ---
 #### Part 5: A Simple App
Please implement the app by following the design below (measured in points.)
 
 UI Requirements:
 
 Label on the top:
 Top: 100, Leading: 40, Font size: 16, Font Color: White
 
 Label in the middle:
 Top: 100, Leading: 40, Trailing: 40, Font size: 16, Font Color: White
 
 Button:
 Bottom: 50, Leading: 40, Trailing: 40, Font size: 16, Font Color: White
 

 Functional Requirements:
 
 Each time the user hits the button, the background color and text should change
 randomly. We give the text below. There are 7 sentences in the array. You can choose 7  kinds of color to cooperate with it. For example, you can take the colors of the rainbow as your color set.
 
 Hints:
 
 1. RGB color
 2. Random number in Swift
 */
 
 let text = [
 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempus.",
 "Contrary to popular belief, Lorem Ipsum is not simply random text.",
 "Richard McClintock, a Latin professor at Hampden-Sydney College in ",
 "looked up one of the more obscure Latin words, consectetur",
 "from a Lorem Ipsum passage, and going through the cities of the word",
 "This book is a treatise on the theory of ethics, very popular during the.",
 "The first line of Lorem Ipsum, Lorem ipsum dolor sit amet..",
 ]
