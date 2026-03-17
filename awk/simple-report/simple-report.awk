BEGIN {
    # define the field separator
    FS = ","
}

{
    # generate and print the output for each record
    id = "#" $1
    location = $2
    first = $3 $4
    second = $5 $6
    average = (first + second) / 2
    print id ", " location " = " average
}
