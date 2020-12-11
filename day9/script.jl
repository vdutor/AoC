file = open("./input.txt")
lines = readlines(file)
data = parse.(Int64, lines)
len_history = 25

# first star results
invalid_number = 70639851
invalid_number_idx = 562

"""
Checks that there exists two numbers in history
such that num1 + num2 == num
"""
function check(history, num)
    for num1 in history, num2 in history
        if num1 != num2 && num1 + num2 == num
            return true
        end
    end
    return false
end

function star1()
    for i in len_history+1:length(data)
        valid = check(data[i - len_history: i-1], data[i])
        if !valid
            println(i, " ", data[i], " ", valid)
        end
    end
end

function star2()
    for i in 1:length(data)-1, j in i+1:length(data)
        if sum(data[i: j]) == invalid_number
            set = data[i:j]
            return set, i, j
        end
    end
end


set, idx_start, idx_end = star2()
println()
