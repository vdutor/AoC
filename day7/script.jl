file = open("input.txt")
lines = readlines(file)
println(lines)

mutable struct Bag
    color::String
    contains::Array{Bag,1}
end

# colors_to_row = dict
# for line in lines 
# Dict(

line_to_color(line) = join(split(line, " ")[1:2], " ")

function line_to_other_colors(line) 
    words = split(line, " ")
    bag_indices = findall(word -> occursin(r"bag", word), words)
    contains = Tuple{String,Int}[]

    if length(bag_indices) <= 1
        return contains
    end

    for i in bag_indices[2:end]
        color = join(words[i - 2:i - 1], " ")
        if color != "no other"
            println(words[i - 3])
            m = parse(Int, words[i - 3])
            push!(contains, (color, m))
        end
    end

    return contains
end

color_dict = Dict(line_to_color(line) => line_to_other_colors(line) for (i, line) = enumerate(lines))


function can_contain_color(color, color_to_find)
    childern = get(color_dict, color, String[])
    if color_to_find in childern
        return true
    end

    for child in childern
        if can_contain_color(child, color_to_find)
            return true
        end
    end

    return false

end

color_dict


function num_bags(color)
    childern = get(color_dict, color, [])
    if length(childern) == 0
        println(color, " ", 1)
        return 1
    end

    n = 0
    for (c, m) in childern
        n += (m * num_bags(c))
    end

    println(color, " ", n + 1)
    return n + 1
end



# end

# COLOR_TO_FIND = "shiny gold"
# global num = 0

# for color in keys(color_dict)
#     childern = get(color_dict, color, String[])
#     println(color, " ", childern, " ", can_contain_color(color, COLOR_TO_FIND))
#     global num = can_contain_color(color, COLOR_TO_FIND) ? num + 1 : num
# end

# println(num)
