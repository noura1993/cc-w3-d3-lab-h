require('pry')
require_relative('./models/artist')
require_relative('./models/album')

# Album.delete_all()
# Artist.delete_all()


katy = Artist.new({
    'name' => 'Katy Perry'
})

katy.save()

adele = Artist.new({
    'name' => 'Adele'
})

adele.save()

prism = Album.new({
    'title' => "Prism",
    'genre' => 'pop',
    'artist_id' => katy.id
})

prism.save()

witness = Album.new({
    'title' => "Witness",
    'genre' => 'electropop',
    'artist_id' => katy.id
})

witness.save()

twenty_one = Album.new({
    'title' => 'Twenty One',
    'genre' => 'pop',
    'artist_id' => adele.id
})

twenty_one.save()

binding.pry

nil