require "pagy/extras/overflow"

Pagy::DEFAULT[:limit] = 15 # items per page
Pagy::DEFAULT[:size] = 9  # nav bar links
Pagy::DEFAULT[:overflow] = :last_page
