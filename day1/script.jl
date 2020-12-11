file = open("input.txt")
lines = parse.(Int64, readlines(file))

for num1 in lines, num2 in lines, num3 in lines
	if num1 + num2 + num3 == 2020
		println(num1 * num2 * num3)
	end
end
