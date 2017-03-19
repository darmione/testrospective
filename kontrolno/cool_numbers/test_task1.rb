def cool_numbers(n)
	return n.to_s + 'th' if n.abs == 11 || n.abs == 12 || n.abs == 13
  case (n.abs % 10)
	when 1
		n.to_s + 'st'
	when 2
		n.to_s + 'nd'
	when 3
		n.to_s + 'rd'
	else
		n.to_s + 'th'
  end
end

p cool_numbers(11)
p cool_numbers(123)
p cool_numbers(112)
p cool_numbers(-101)
p cool_numbers(-22)
p cool_numbers(-103)
p cool_numbers(1)
p cool_numbers(0)
p -23.abs % 10
