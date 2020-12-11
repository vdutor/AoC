file = open("input.txt")
lines = readlines(file)

struct Group
    answers::Array{String,1}
end


function num_yes(g::Group)::Int
    length(intersect([Set(s) for s in g.answers]...))
end


function  main()
    num = 0
    boundaries = findall(c -> c == "", lines)
    start = 0
    for stop in boundaries
        answers = lines[start+1:stop-1]
        println(answers)
        start = stop
        num += num_yes(Group(answers))
    end

    println(num)
end

main()