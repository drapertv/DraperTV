class Email < ActiveRecord::Base
	after_create :generate_unsubscribe_key

	def generate_unsubscribe_key
		update_attributes unsubscribe_key: random_code
	end

	def random_code
    random = (48..122).map {|x| x.chr}
    characters = (random - random[43..48] - random[10..16])
    code = characters.map {|c| characters.sample}
    code.join
  end

  def self.seed_codes
  	all.each(&:generate_unsubscribe_key)
  end

end
