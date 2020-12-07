file = open("input.txt")
lines = readlines(file)


function traverse(forrest::Array{Char}, right::Int64, down::Int64)::Int64
    nrows, ncols = size(forrest)
    # println(forrest)
    # show(forrest)
    global i = 1 + down
    global j = 1 + right
    global num_trees = 0
    while i <= nrows
        # println(i, " ", j, " ", forrest[i, j])
        is_tree = forrest[i, j] == '#'
        if is_tree
            num_trees = num_trees + 1
        end
        i += down
        j = mod1(j + right, ncols)
    end
    return num_trees
end


# function main()
forrest = permutedims(reshape(collect(join(lines, "")), (length(lines[1]), length(lines))), (2, 1))
num_trees1 = traverse(forrest, 1, 1)
num_trees2 = traverse(forrest, 3, 1)
num_trees3 = traverse(forrest, 5, 1)
num_trees4 = traverse(forrest, 7, 1)
num_trees5 = traverse(forrest, 1, 2)
println(num_trees1 * num_trees2 * num_trees3 * num_trees4 * num_trees5)
# end