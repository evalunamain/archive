json.(pokemon, :id, :name, :poke_type, :attack, :defense, :image_url, :moves)

json.toys pokemon.toys, partial: 'toys/toy', as: :toy if display_toys
