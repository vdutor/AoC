function num_occupied(seating::Array{Char,2}, row::Int, col::Int)::Int
    nrows, ncols = size(seating)
    # extended_seating = fill('L', (nrows+2,ncols+2))
    # extended_seating[2:end-1,2:end-1] .= seating
    # row += 1
    # col += 1
    num = 0
    # left
    for i in 1:col-1
        if seating[row, col-i] == '#'
            println("left")
            num += 1
            break
        elseif seating[row, col-i] == 'L'
            break
        end
    end
    # right
    for i in 1:ncols-col
        if seating[row, col+i] == '#'
            println("right")
            num += 1
            break
        elseif seating[row, col+i] == 'L'
            break
        end
    end
    # top
    for i in 1:row-1
        if seating[row-i, col] == '#'
            println("top")
            num += 1
            break
        elseif seating[row-i, col] == 'L'
            break
        end
    end
    # down
    for i in 1:nrows-row
        if seating[row+i, col] == '#'
            println("down")
            num += 1
            break
        elseif seating[row+i, col] == 'L'
            break
        end
    end
    # top-left
    for i in 1:min(row,col)-1
        if seating[row - i, col - i] == '#'
            println("top-left")
            num += 1
            break
        elseif seating[row-i, col-i] == 'L'
            break
        end
    end
    # top-right
    for i in 1:min(row - 1, ncols - col)
        if seating[row - i, col + i] == '#'
            println("top-right")
            num += 1
            break
        elseif seating[row - i, col+i] == 'L'
            break
        end
    end
    # down-right
    for i in 1:min(nrows - row, ncols - col)
        if seating[row + i, col + i] == '#'
            println("down-right")
            num += 1
            break
        elseif seating[row + i, col+i] == 'L'
            break
        end
    end
    # down-left
    for i in 1:min(nrows - row, col - 1)
        if seating[row + i, col - i] == '#'
            println("down-left")
            num += 1
            break
        elseif seating[row+i, col-i] == 'L'
            break
        end
    end
    return num
end

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
            if num_occupied(seating, i, j) == 0
                new_seating[i, j] = '#'
            end
            # neighboors = get_neighboors(seating, i, j)
            # if length(findall(c -> c == 'L' || c == '.', neighboors)) == 8
            #     new_seating[i, j] = '#'
            # end
        end
    end
    new_seating
end


function empty_seats(seating::Array{Char,2})
    new_seating = copy(seating)
    nrows, ncols = size(seating)
    for i in 1:nrows, j in 1:ncols
        if seating[i, j] == '#'  # occupied
            if num_occupied(seating, i, j) >= 5
                new_seating[i, j] = 'L'
            end
            # neighboors = get_neighboors(seating, i, j)
            # if length(findall(c -> c == '#', neighboors)) >= 4
            #     new_seating[i, j] = 'L'
            # end
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
        # print(equal)
        seating = new_seating
        println(seating)
    end
    seating
end

s = main()
println(length(findall(c -> c == '#', s)))

# file = open("./input1.txt")
# lines = readlines(file)
# seating = reduce(vcat, permutedims.(collect.(lines)))
# seating = fill_seats(seating)
# seating = empty_seats(seating)
# seating = fill_seats(seating)
# # seating = empty_seats(seating)
# seating
# # num_occupied(new_seating, 1, 1)

