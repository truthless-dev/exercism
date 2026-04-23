# Expert Mixologist

Welcome to Expert Mixologist on Exercism's Swift Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## Switch

A [switch statement][switch] allows you to compare a value against multiple possible matching values.
It allows you to write more concise code than using multiple `else-if` statements.
A switch statement starts with the `switch` keyword followed by the value to be compared.
Then you can define the cases using the `case` keyword followed by the value to be compared against.
The `default` keyword is used to define the default case when none of the cases match.
Like `else-if` statements, `switch` statements only execute the block of code associated with the first matching case.

```swift
switch value {
case 1:
    print("One")
case 2:
    print("Two")
default:
    print("Other")
}
```

Consider the following example:

```swift
if str == "apple" {
    print("Let's bake an apple crumble")
} else if str == "lemon" {
    print("Let's bake a lemon meringue pie!")
} else if str == "peach" {
    print("Let's bake a peach pie!")
} else {
    print("Let's buy ice cream.")
}
```

This could instead be written as:

```swift
switch str {
case "apple":
    print("Let's bake an apple crumble")
case "lemon":
    print("Let's bake a lemon meringue pie!")
case "peach":
    print("Let's bake a peach pie!")
default:
    print("Let's buy ice cream.")
}
```

## While loops

A [while loop][while-loops] is a control flow statement that allows code to be executed while a certain condition is true.
Swift provides two kinds of while loops: while and repeat-while loops.
While loop's condition is evaluated before the loop body is executed; if the condition is false, the loop body will not be executed at all.
While loops in Swift have the following structure:

```swift
while <#condition#> {
  <#code#>
}
```

Here the loop will exectute as long as count is greater than 0, and will thereby print the numbers 2, 1 and "Liftoff!".

```swift
var count = 2
while count > 0 {
  print("\(count)…")
  count -= 1
}
print("Liftoff!")

// prints:
// 2…
// 1…
// Liftoff!
```

A [repeat-while loop][while-loops] is similar to a while loop, but the condition is evaluated after the loop body is executed.
This means that the loop body will always execute at least once, even if the condition is false.
repeat-while loops in Swift have the following structure:

```swift
repeat {
  <#code#>
} while <#condition#>
```

Here the loop will only execute once, since the condition is false.
Since it is a repeat-while loop, the loop body will execute once before the condition is evaluated.

```swift
var count = 2
repeat {
  print("\(count)…")
} while count < 0
print("Liftoff!")
```

## Control Transfer

Swift has a set of statements that can be used to alter the normal control flow of loops.
These are known as control transfer statements.
You have already seen `return`; this concept will introduce other, which include `continue`, `break`, and labels.
We won't cover `fallthrough` in this concept, but you can read about it in the [Swift book][fallthrough].

### Continue

Sometimes it is necessary to skip to the next iteration of a loop early, without completing the rest of the statements in the current iteration of the loop.
The `continue` keyword can be used for this.
When `continue` is executed, the loop jumps to the next check to see if the next iteration of the loop can be run, i.e. the `while` in while and repeat-while loops or the check if there's another element in the sequence in for-in loops.

```swift
count = 1
while count < 6 {
  count += 1
  if count == 4 { continue }
  print(count)
}

// prints:
// 2
// 3
// 5
```

### Break

Break is used to exit a loop early.
When `break` is executed, the loop will immediately exit and the program will continue with the first statement after the loop.

```swift
for fruit in ["banana", "grapes", "apple", "strawberry", "kiwi", "lemon"] {
  if !fruit.count.isMultiple(of: 2) { break }
  print(fruit)
}

// prints:
// banana
// grapes
```

### Labels

When loops are nested, there are times when one may want to use `break` or `continue` to exit or restart the outer loops that contain the loop in which the `break` or `continue` are used.
In cases like these, labels may be used to specify the loop to be exited or restarted.
A loop can be labeled by putting a name followed by a colon before the `while`, `repeat`, or `for` that starts the loop.

To see the effect of using labels in this way, consider the following loop.

```swift
outerLoop: for fruit in ["banana", "grapes", "apple", "strawberry", "kiwi", "lemon"] {
  print("\n--- \(fruit) ---")
  for letter in fruit {
    guard letter != "n" else { break outerLoop }
    print(letter)
  }
}

// prints:
// --- banana ---
// b
// a
```

[control-transfer]: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/#Control-Transfer-Statements
[fallthrough]: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/#Fallthrough
[while-loops]: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/#While-Loops
[repeat-loops]: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/#Repeat-While
[switch]: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/#Switch

## Instructions

You are a expert mixologist, making tasty drinks for the public to enjoy on their nights out.
But you figured that you could make your life easier by writing a bit of code to help you with your job.

## 1. Determine how long it takes to make an order

Different drinks take different amount of time to prepare: 

- `"beer"`, `"soda"`, and `"water"` take 0.5 minutes each.
- `"shot"`s take 1.0 minutes, `"mixed drink"`s take 1.5 minutes,
- `"fancy drink"`s take 2.5 minutes,
- `"frozen drink"`s take 3.0 minutes.

Implement the function `timeToPrepare(drinks:)`, that takes the argument `drinks` which holds an array of strings representing the drinks that need to be prepared.
The function should return the total time it will take to prepare all the drinks in the array.

```swift
timeToPrepare(drinks: ["beer", "frozen drink", "shot"])
// returns 4.5
```

## 2. Replenish your lime wedge supply

One of the first things you need to do when you start your shift is to make sure your little bin of lime wedges is full for the shift ahead.
You will have different sizes of lime which will give different amount of wedges, you can get 6 wedges from a "small" lime, 8 wedges from a "medium" lime and 10 from a "large" lime.

While you still need more wedges and you still have more limes to cut up, take the first lime out of the array, and subtract the appropriate number of wedges from the amount you need.
Keep going until you don't need any more wedges or you run out of limes.

Implement the function `makeWedges(needed:limes:)`, that takes the arguments `needed` which holds the number of wedges you need to cut up, and `limes` which holds an array of strings representing the sizes of the limes you have available to cut up.
The function should return the number of limes you cut up.

```swift
makeWedges(needed: 25, limes: ["small", "small", "large", "medium", "small"])
// returns 4
```

## 3. Finish up your shift

Congratulations! Your long work day is nearly done and you will soon be going home to work on your new app.
But you still have a stream of drink orders to make before you can hand off the orders to the next shift and leave.

As long as you still have time left in your shift you are to make the first order in the Array and then remove that order from the array.
You can then subtract the amount of time it took to prepare that order, according to your function `timeToPrepare(drinks:)` from the time left on your shift.

Implement the function `finishShift(minutesLeft:remainingOrders:)` which takes in the number of minutes left in your shift (guaranteed to be greater than 0), and a non-empty array of drink orders.
The function should return the array of orders that you have not yet gotten to before the end of your shift.

```swift
finishShift(minutesLeft: 5, remainingOrders: [["beer", "frozen drink", "shot"], ["fancy drink", "soda"], ["beer", "beer", "water"], ["mixed drink", "frozen drink"]])
// returns [["beer", "beer", "water"], ["mixed drink", "frozen drink"]]
```

## 4. Track certain orders

In order to make sure the beer and soda stay fresh, you need to track their orders along with the times those orders were placed.

Implement the function `orderTracker(orders: [(drink: String, time: String)]) -> (beer: (first: String, last: String, total: Int)?, soda: (first: String, last: String, total: Int)?)` which, when given a list of orders and times return a pair of optional tuples containing the times of the first and last orders of beer and soda along with the total number of orders of each and `nil` if no orders for those beverages were made. You do not need to track any other drinks.

Implement the function `orderTracker(orders:)` which takes in an array of tuples, where each tuples holds the drink ordered and the time the order was placed.
The function should return a tuple containing the first and last time beer was ordered, the total number of beer orders, the first and last time soda was ordered, and the total number of soda orders.
It should be returned as a tuple of the format: `(beer: (first: String, last: String, total: Int)?, soda: (first: String, last: String, total: Int)?)`.

```swift
let orders = [
    (drink: "beer", time: "10:01"), (drink: "frozen drink", time: "10:02"),
    (drink: "shot", time: "10:05"), (drink: "fancy drink", time: "10:06"),
    (drink: "soda", time: "10:09"), (drink: "beer", time: "10:15"), (drink: "beer", time: "10:22"),
    (drink: "water", time: "10:26"), (drink: "mixed drink", time: "10:28"),
    (drink: "frozen drink", time: "10:33"),
]

orderTracker(orders: orders)

// returns (beer: (first "10:01", last "10:22", total 3), soda: (first "10:09", last "10:09", total 1))
```

## Source

### Created by

- @wneumann

### Contributed to by

- @meatball133