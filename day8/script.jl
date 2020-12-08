import Base: *


mutable struct Instruction
    opcode::String
    arg::Int64
    count::Int64
end


mutable struct System
    instructions::Array{Instruction,1}
    accumulator::Int64
end


function Base.parse(::Type{Instruction}, s::String)::Instruction
    opcode = s[1:3]
    arg = parse(Int64, s[5:end])
    Instruction(opcode, arg, 0)
end


"""
Returns the next instruction to execute and a bool whether to stop execution
"""
function execute(system::System, i::Int64)::Tuple{Int64,Bool}
    println("acc: ", system.accumulator)
    instruction = system.instructions[i]

    if instruction.count >= 1
        println("Infinite loop!")
        return -1, true
    end

    println(i, " ", instruction)

    instruction.count += 1

    if instruction.opcode == "nop"
        return i + 1, false
    elseif instruction.opcode == "jmp"
        return i + instruction.arg, false
    elseif instruction.opcode == "acc"
        system.accumulator += instruction.arg
        return i + 1, false
    end

end

reset!(ins::Instruction) = (ins.count = 0)

function run(system::System)::Int64
    i = 1
    terminate = false
    while !terminate
        i, terminate = execute(system, i)
    end
    return system.accumulator
end


function fix(system::System, i::Int64)::System
    new_instructions = copy(system.instructions)

    
    for instruction in new_instructions
        reset!(instruction)
    end

    old_instruction = instructions[i]
    if old_instruction.opcode == "jmp"
        new_instructions[i] = Instruction("nop", old_instruction.arg, 0)
    elseif old_instruction.opcode == "nop"
        new_instructions[i] = Instruction("jmp", old_instruction.arg, 0)
    end

    System(new_instructions, 0)
end



file = open("input.txt")
code = readlines(file)
instructions = [parse(Instruction, line) for line = code]
sys = System(instructions, 0)
# println(run(sys))
# sys.instructions[266].opcode == "nop"
println(run(sys))

jmp_instructions = findall(ins -> ins.opcode == "jmp", sys.instructions)
for jmp_instruction in jmp_instructions
    println("corrupt ", jmp_instruction, " jmp->nop")
    new_sys = fix(sys, jmp_instruction)
    println("new system ", new_sys)
    # println(new_sys.instructions)
    println(" acc: ", run(new_sys))
end

nop_instructions = findall(ins -> ins.opcode == "nop", sys.instructions)
for nop_instruction in nop_instructions
    println("corrupt ", nop_instruction, " nop->jmp")
    new_sys = fix(sys, nop_instruction)
    println(" acc: ", run(new_sys))
end