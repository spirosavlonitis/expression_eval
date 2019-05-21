class ExpressionEval
	def evaluate expr
		expr.gsub!(/\s/,'')
		while expr.match(/\(.+\)/)
			while expr.gsub!(/\((-*?[0-9.]+)\)/) { $1 };end
        	while expr.gsub!(/\((-?[0-9.]{1,})([*\/+-])(-?[0-9.]{1,})\)/).each { $1.to_f.send($2,$3.to_f).to_s};end
			while expr.gsub!(/(-?[0-9.]{1,})([*\/])(-?[0-9.]{1,})/) { $1.to_f.send($2,$3.to_f).to_s};end        
		    while	expr.gsub!(/(-?[0-9.]{1,})([+-])(-?[0-9.]{1,})/).each {	 $1.to_f.send($2,$3.to_f)};	end 	if !expr.include?('*') and !expr.include?('/')
		end
    	expr.gsub!(/(?<=[*\/+-]{1})(\-\-)/,'')
	  	while expr.gsub!(/(-?[0-9.]{1,})([*\/])(-?[0-9.]{1,})/).each {$1.to_f.send($2,$3.to_f) };end
		while expr.gsub!(/^(-?[0-9.]{1,})([+-])(-?[0-9.]{1,})/).each { $1.to_f.send($2,$3.to_f) };end
		return expr.to_f
	end

	def start
		loop do 
			begin
				puts evaluate(STDIN.gets)
			rescue Exception => e
				puts e
				break
			end
		end
	end
end

if __FILE__ == $0
	calc = ExpressionEval.new
	calc.start
end
#foo