class Vigenere
	attr_accessor :string,:decalage,:result,:encrypt,:alphabet,:alphabet_most_used_letter_index,:encryption_key

	def encrypt string_to_encrypt, encryption_key
		@encrypt = true;
		@string = string_to_encrypt
		@result = string_to_encrypt
		@encryption_key = encryption_key
		change_each_letter @string
		@result
	end

	def yield
		puts "\n==========\n"+@result.to_s+"\n==========\n"
	end

	def decrypt string_to_decrypt, encryption_key = nil
		@encrypt = false
		@string = string_to_decrypt
		counter_of_letter = 0

		if encryption_key.nil?
			decrypt_loop_without_key
		else
			@encryption_key = encryption_key
			change_each_letter @string
		end
	end

	def initialize alphabet_most_used_letter_index = 4
		@alphabet = "abcdefghijklmnopqrstuvwxyz"
		# Defined "e" as most used letter
		@alphabet_most_used_letter_index = alphabet_most_used_letter_index
	end

	private

	def get_indice string
		# hash of iterations per letter
		iteration_per_letter = string.scan(/\w/).inject(Hash.new(0)){|h, c| h[c] += 1; h}
	end
	def decrypt_loop_without_key
		groups = []
		for i in 0...7
			groups.push create_group @string, i
			puts groups
		end
		
		abort('..')
		iteration_per_letter = get_indice @string
		

		most_used_letter = iteration_per_letter.max_by { |index, counter| counter }
		index_of_most_used_letter = @alphabet.index most_used_letter[0]
	end

	def create_group string, group_number
		group = ""
		# for i in 0...string.length
		# 	if (i+1) % (group_number+1) == 0 && string[i+1]
		# 		group[i] = string[i]
		# 	end
		# end
		group
	end

	def change_each_letter string
		key_length = @encryption_key.length
		increment = 0
		# Loop through letters of string
		for letter in 0...string.length
			
			letter_to_change = @alphabet.index @string[letter]
			letter_to_change_with = @alphabet.index @encryption_key[increment]
			
			# There we swap letters
			@result[letter] = swap_letter(letter_to_change, letter_to_change_with)
			
			# Increment and goes back to 0 if increment is superior to 0
			increment = increment_considering_key_length(increment, key_length)

		end
	end

	def increment_considering_key_length number_to_increment, key_length
		number_to_increment+= 1
		if number_to_increment % key_length == 0
			number_to_increment = 0
		end
		incremented_number = number_to_increment
	end
	def swap_letter letter_to_change, letter_to_change_with
		# If we encrypt, decal in one way
		unless @encrypt
			@decalage = letter_to_change + letter_to_change_with 
			if (@decalage+1 >= @alphabet.length)
				@decalage = @decalage - @alphabet.length
			end
			new_letter = @alphabet[@decalage+1]
		# Otherwise, the other way
		else
			@decalage = letter_to_change - letter_to_change_with 
			new_letter = @alphabet[@decalage-1]
		end
	end

 end