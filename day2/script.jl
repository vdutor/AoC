struct PassWordInfo
    char::Char
    min_reps::Int64
    max_reps::Int64
    password::String
end

function parse_string(s::String)::PassWordInfo
    info = split(s, " ")
    reps = info[1]
    min_reps, max_reps = split(reps, "-")
    char = info[2][1]
    password = info[3]
    PassWordInfo(convert(Char, char), parse(Int64, min_reps), parse(Int64, max_reps), convert(String, password))
end


function is_valid(self::PassWordInfo)::Bool
    reps = length(findall(c -> c == self.char, collect(self.password)))
    self.min_reps <= reps <= self.max_reps
end


function is_valid2(self::PassWordInfo)::Bool
    (self.password[self.min_reps] == self.char) ⊻ (self.password[self.max_reps] == self.char)
end


function main()
    file = open("input.txt")
    lines = readlines(file)

    num_valid = 0

    for line in lines
        password_info = parse_string(line)
        num_valid = is_valid2(password_info) ? num_valid + 1 : num_valid
    end

    println("Number of valid passwords: $num_valid")
end