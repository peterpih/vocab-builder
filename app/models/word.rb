class VocabWord < ActiveRecord::Base
validates :content, presence: true
validates :level, presence: true

end