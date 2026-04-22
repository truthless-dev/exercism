# Slice Sizing

Welcome to Slice Sizing on Exercism's Swift Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## Optionals

Swift uses [_optionals_][optionals] to allow programmers to represent the possible absence of a value.
Optional is a type that can either hold a value or be [`nil`][nil], which represents the absence of a value.
Using an optional requires a program to check if a value does exist before using it after unwrapping it.

Any type can be made into an optional by appending a `?` onto the end of the type name.
So an optional integer would have type `Int?` and an optional string would have type `String?`.
Defining constants or variables of optional type and assigning them values is done the same as for values of non-optional types.

```swift
let x: Int? = 42
var y: String? = "Hello"
y = "Goodbye"
```

You can assign the absence of a value to a variable of optional type by assigning it the special value `nil`.
`nil` can be used with all optional types, but `nil`s assigned to two different optional types do not have the same type, and cannot be interchanged or even compared.

```swift
let intOpt: Int? = nil
let stringOpt: String? = nil

intOpt = stringOpt
// Compiler error: Cannot assign value of type 'String?' to type 'Int?'

intOpt == stringOpt
// Compiler error: Binary operator '==' cannot be applied to operands of type 'Int?' and 'String?'
```

Also note that even though `nil` can be assigned to any optional type, it cannot be assigned to a non-optional type (even if it doesn't actually hold `nil`).
And methods that is expecting a non-optional type cannot be passed an optional type without unwrapping it first.

```swift
var x: Int = 42
var y: Int? = 42

y = x
// Works fine
x = y
// error: value of optional type 'Int?' must be unwrapped to a value of type 'Int'
x + y
// error: value of optional type 'Int?' must be unwrapped to a value of type 'Int'
```

## Using optionals

Because optional types are not the same types as their base types, the two types cannot be used in the same ways.
For example: `Int("123") + 1` results in a compiler error "Value of optional type 'Int?' must be unwrapped to a value of type 'Int'".
This is because the `Int("123")` returns an optional `Int?` type, not an `Int` type, since if the string cannot be converted to an integer, the result will be `nil`.
In order to access the `Int` from the conversion, one must "unwrap" it first.

This is most commonly done in Swift using the `if-let` and `guard-let` constructs for [_optional binding_][optional-binding] which check for `nil` and take one code path with the unwrapped value bound to a supplied name if a value exists and taking a different code path if `nil` was found.

```swift
if let safeNum = Int("123") {
	let sum = safeNum + 1
	…
} else {
  // code for the case where nil was found -- may be left out
}
```

It is worth noting that the `safeNum` variable has the type `Int` and not `Int?`.
In the example below, `num` is of type `Int?` and `safeNum` is of type `Int`.

```swift
let num = Int("123")
if let safeNum = num {
  // num is of type Int
}
```

This _optional binding_ is important because it unwraps (or "removes") the optional type from the value, allowing it to be used as a non-optional value.
If you would just do a conditional check on if the value is `nil`, the value would still be of optional type:

```swift
let num = Int("123")
if num != nil {
  // num is of type Int?
}
```

The `guard-let` option may also be used in the cases where early return is desired:

```swift
guard let num = Int("123") else { return nil }
let sum = num + 1
…
```

## Comparing optionals

Note that even if the base type of a pair of optionals can be compared using the standard comparison operators, the optionals themselves cannot be compared.
They can only be checked for equality.
Two optionals are equal if they are both `nil` or if the values they wrap are equal within their base types.

However, code can be written to perform a custom comparison of two optional values.
Below is an example of a `switch` statement that will return `true` only if both optional values are non-nil and the first value is less than the second. 
To do this it uses the _optional pattern_ `varName?` which only matches non-nil optionals, binding the value inside the optional to the name `varName`.

```swift
switch (optionalA, optionalB) {
case let (valA?, valB?): return valA < valB
default: return false
}
```

[optionals]: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#Optionals
[nil]: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#nil
[optional-binding]: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#Optional-Binding

## Instructions

You have a number of pizza slice shops in your town and you want to write a webapp that will let you compare two different pizza configurations to let you know who will give you the bigger slice.

## 1. Write a function to compute slice sizes which returns nil for invalid input.

Implement the function, `sliceSize(diameter: Double?, slices: Int?) -> Double?`, which, given the diameter of a pizza and the number of slices per pizza returns the area of a slice.
For negative diameters and for number of slices less than 1, return `nil`, as there is no such thing as a pizza with negative diameter and no way to slice a pizza into fewer than 1 slice.
If either parameter is `nil`, also return `nil`

```swift
sliceSize(diameter: 16, slices: 12)
// Returns 16.75516081914556
sliceSize(diameter: nil, slices: 8)
// Returns nil
```

## 2. Process input from your web application to determine the larger slice.

You web application will pass four strings to your function, `biggestSlice(diameterA: String, slicesA: String, diameterB: String, slicesB: String) -> String`.
The first and second strings are the diameter and number of slices of the first pizza respectively, and the third and fourth are the diameter and number of slices of the second pizza respectively.

Implement `biggestSlice` so that it attempts to convert the diameter and number of slices for each pizza into a `Double` and an `Int` respectively.
If both of these values can be obtained from the strings, use your first function to try to compute the area, otherwise the area for that slice is `nil`.
Once the areas of both slices are obtained, compare the two areas using the following rules:

1. If slice A's area is a `Double` and slice B's is `nil`, return "Slice A is bigger". If the reverse is true, return "Slice B is bigger".
2. If both areas are `Double`s, return "Slice A is bigger" or "Slice B is bigger" according to which slice has the greater area.
3. If both areas are `nil`, or if both are `Double`s and they are equal, return "Neither slice is bigger".

~~~~exercism/note
Even if the input result in a slice area of 0, the slice is still considered valid, and should be seen as bigger than a slice with an area of `nil`.
~~~~

```swift
biggestSlice(diameterA: "10", slicesA: "6", diameterB: "14", slicesB: "12")
// Returns "Slice A is bigger"
biggestSlice(diameterA: "10", slicesA: "6", diameterB: "12", slicesB: "8")
// Returns "Slice B is bigger"
biggestSlice(diameterA: "Pepperoni", slicesA: "6", diameterB: "Sausage", slicesB: "12")
// Returns "Neither slice is bigger"
```

## Source

### Created by

- @wneumann