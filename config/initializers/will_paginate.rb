require 'will_paginate/array'

Kaminari.configure do |config|
 config.page_method_name = :per_page_kaminari
end