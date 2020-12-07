import Base

file = open("input.txt")
lines = readlines(file)
println(lines)

boundaries = findall(x -> x == "", lines)
prepend!(boundaries, [0])
println(boundaries)

mutable struct Passport
    byr::Union{Missing,String}
    iyr::Union{Missing,String}
    eyr::Union{Missing,String}
    hgt::Union{Missing,String}
    hcl::Union{Missing,String}
    ecl::Union{Missing,String}
    pid::Union{Missing,String}
    cid::Union{Missing,String}
end

function Passport()::Passport
    Passport(missing, missing, missing, missing, missing, missing, missing, missing)
end


function validate_propery_and_set!(passport::Passport, k::Symbol, v::Union{SubString,String})
    if k == :byr
        value = parse(Int64, v)
        if length(v) == 4 && value >= 1920 && value <= 2002
            setproperty!(passport, k, v)
        end

    elseif k == :iyr
        value = parse(Int64, v)
        if length(v) == 4 && value >= 2010 && value <= 2020
            setproperty!(passport, k, v)
        end

    elseif k == :eyr
        value = parse(Int64, v)
        if length(v) == 4 && value >= 2020 && value <= 2030
            setproperty!(passport, k, v)
        end

    elseif k == :hgt
        if v[end - 1:end] == "cm"
            value = parse(Int64, v[1:end - 2])
            if value >= 150 && value <= 193
                setproperty!(passport, k, v)
            end
        elseif v[end - 1:end] == "in"
            value = parse(Int64, v[1:end - 2])
            if value >= 59 && value <= 76
                setproperty!(passport, k, v)
            end
        end

    elseif k == :hcl
        if occursin(r"^#[a-f0-9]{6}$", v)
            setproperty!(passport, k, v)
        end

    elseif k == :ecl
        if v ∈ ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
            setproperty!(passport, k, v)
        end

    elseif k == :pid
        if occursin(r"^[0-9]{9}$", v)
            setproperty!(passport, k, v)
        end
    end
end


function Passport(s::String)::Passport
    data = split(s, " ")
    passport = Passport()
    for el in data
        k, v = split(el, ":")
        validate_propery_and_set!(passport, Symbol(k), v)
    end
    return passport
end


function is_valid(self::Passport)::Bool
    if self.byr === missing
        return false
    end
    if self.iyr === missing
        return false
    end
    if self.eyr === missing
        return false
    end
    if self.hgt === missing
        return false
    end
    if self.hcl === missing
        return false
    end
    if self.ecl === missing
        return false
    end
    if self.pid === missing
        return false
    end
    return true
end

global num_valid = 0

for (i, j) in zip(boundaries[1:end - 1], boundaries[2:end])
    s = join(lines[i + 1:j - 1], " ")
    p = Passport(s)
    println(p)
    global num_valid = is_valid(p) ? num_valid + 1 : num_valid
end

println(num_valid)