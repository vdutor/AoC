file = open("./input.txt")
lines = readlines(file)
data = parse.(Int64, lines)
data = [0, data...]

sorted_data = sort(data)
# diff_sorted_data = diff(sorted_data)
# println(length(findall(n -> n == 1, diff_sorted_data)))
# println(length(findall(n -> n == 2, diff_sorted_data)))
# println(length(findall(n -> n == 3, diff_sorted_data)))

function build_graph()
    current_voltage = maximum(data) + 3
    dict = Dict{Int64,Array{Int64, 1}}()
    dict[current_voltage] = Int64[]
    while current_voltage != 0
        # println(current_voltage)
        next_voltage_indices = findall(v -> 0 < current_voltage - v <= 3, data)
        # println(next_voltage_indices)
        # println(data[next_voltage_indices])
        for idx in next_voltage_indices
            voltage = data[idx]
            voltage_list = get(dict, voltage, Int64[])
            dict[voltage] = push!(voltage_list, current_voltage)
            # println(dict)
        end
        current_voltage = maximum(data[next_voltage_indices])
        # println(current_voltage)
    end
    dict
end

visited = Dict{Int64,Int64}()

function num_path(graph, start)
    # println(start, " ", graph[start])
    v = get(visited, start, -1)
    if v != -1
        println("visited!")
        return v
    end

    v = 0
    if length(graph[start]) == 0
        v += 1
    end
    for child in graph[start]
        v += num_path(graph, child)
    end
    visited[start] = v
    return v
end

graph = build_graph()
println("build graph")
println(graph)
n = num_path(graph, 0)
println(n)

# for i in sorted_data[end:-1:1]

# end