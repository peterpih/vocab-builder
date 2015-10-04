class VocabWord < ActiveRecord::Base
validates :word, presence: true
validates :level, presence: true

end