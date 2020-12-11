function get_neighboors(seating::Array{Char,2}, i::Int, j::Int) # ::Array{Char,1}
    nrows, ncols = size(seating)
    # extended_seating = Array{Char,2}('L', nrows+1, ncols+1)
    extended_seating = fill('L', (nrows+2,ncols+2))
    extended_seating[2:end-1,2:end-1] .= seating
    i += 1
    j += 1
    neighboors = reshape(extended_seating[i-1:i+1, j-1:j+1], (9))
    return [neighboors[1:4]..., neighboors[6:end]...]
end

function fill_seats(seating::Array{Char,2})
    new_seating = copy(seating)
    nrows, ncols = size(seating)
    for i in 1:nrows, j in 1:ncols
        if seating[i, j] == 'L'  # empty
            neighboors = get_neighboors(seating, i, j)
            if length(findall(c -> c == 'L' || c == '.', neighboors)) == 8
                new_seating[i, j] = '#'
            end
        end
    end
    new_seating
end


function empty_seats(seating::Array{Char,2})
    new_seating = copy(seating)
    nrows, ncols = size(seating)
    for i in 1:nrows, j in 1:ncols
        if seating[i, j] == '#'  # occupied
            neighboors = get_neighboors(seating, i, j)
            if length(findall(c -> c == '#', neighboors)) >= 4
                new_seating[i, j] = 'L'
            end
        end
    end
    new_seating
end


function main()
    file = open("./input.txt")
    lines = readlines(file)
    seating = reduce(vcat, permutedims.(collect.(lines)))

    equal = false
    while !equal
        new_seating = empty_seats(fill_seats(seating))
        equal = (new_seating == seating)
        print(equal)
        seating = new_seating
    end
    seating
end

s = main()