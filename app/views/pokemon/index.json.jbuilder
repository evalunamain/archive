json.array! @pokemon do |pokemon|
  json.partial! 'pokemon/pokemon', pokemon: pokemon
end
