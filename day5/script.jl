file = open("input.txt")
lines = readlines(file)
println(lines)

struct Seat
    row::Int64
    col::Int64
    id::Int64

    Seat(row::Int64, col::Int64) = new(row, col, row * 8 + col)
end

function Base.isless(x::Seat, y::Seat)
    x.id < y.id
end

function parse(::Type{Seat}, s::String)
    base = "0b"
    row = s[1:7]
    row = replace(row, "F" => "0")
    row = replace(row, "B" => "1")
    row = Base.parse(Int, "$base$row")
    col = s[8:end]
    col = replace(col, "L" => "0")
    col = replace(col, "R" => "1")
    col = Base.parse(Int, "$base$col")
    Seat(row, col)
end
# function Seat(s::String)::Seat
# end


dump(parse(Seat, lines[1]))

dump(parse(Seat, "BBFFBBFRLL"))

seats = Seat[]

for line in lines
    push!(seats, parse(Seat, line))
end

println(seats)

println(findmax(seats))
println(sort(seats))
