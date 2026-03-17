BEGIN {
    FS = ","    # comma is the field separator
}

# Task 1: When the first field is "needs_license",
#         print "true" if the second field contains "car" or "truck".
$1 == "needs_license" && $2 ~ /car|truck/ {print "true"}

# Task 2: When the first field is "resell_price",
#         print the resell value of the original price (second field)
#         given the age of the car (third field).
$1 == "resell_price" {
    originalPrice = $2
    age = $3
    if (age < 3) print originalPrice * 0.8;
    else if (age > 10) print originalPrice * 0.5;
    else print originalPrice * 0.7
}
