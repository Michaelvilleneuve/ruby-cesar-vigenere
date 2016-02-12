class Cesar
	attr_accessor :string,:decalage,:result,:encrypt,:alphabet,:alphabet_most_used_letter_index

	def encrypt string = nil, decalage = 1
		@string = string
		@result = string
		@encrypt = true;
		mainloop
	end

	def yield
		puts "\n==========\n"
		puts @result
		puts "\n==========\n"
		puts "Finished with "+@decalage.to_s + " letters of decalage \n"
	end

	def decrypt string = nil
		@string = string
		@result = string
		@encrypt = false
		counter_of_letter = 0

		iteration_per_letter = @string.scan(/\w/).inject(Hash.new(0)){|h, c| h[c] += 1; h}
		# hash of iterations per letter

		most_used_letter = iteration_per_letter.max_by { |index, counter| counter }
		index_of_most_used_letter = @alphabet.index most_used_letter[0]

		# Calculate decalage
		@decalage = (@alphabet.length - index_of_most_used_letter) + alphabet_most_used_letter_index

		mainloop
	end

	def initialize alphabet_most_used_letter_index = 4
		@alphabet = "abcdefghijklmnopqrstuvwxyz"
		# Defined "e" as most used letter
		@alphabet_most_used_letter_index = alphabet_most_used_letter_index
	end

	private

	def mainloop
		for i in 0...string.length

			letter_index = @alphabet.index @string[i]
			if @encrypt
				letter_index -= @decalage
				
				while letter_index < 0 do
					letter_index += @alphabet.length
				end
			else 
				letter_index += @decalage
				while letter_index + 1 > @alphabet.length do 
					letter_index -= @alphabet.length
				end
			end
	
			@result[i] = @alphabet[letter_index]
		end
		@result
	end

 end