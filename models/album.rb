require_relative('../db/sql_runner')
require_relative('./artist')

class Album 

    attr_reader :id
    attr_accessor :title, :genre, :artist_id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @title = options['title'] 
        @genre = options['genre']
        @artist_id = options['artist_id']
    end

    def save()
        sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id;"
        values = [@title, @genre, @artist_id]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
        sql = "UPDATE albums SET title = $1, genre = $2, artist_id = $3 WHERE id = $4;"
        values = [@title, @genre, @artist_id, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM albums WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM albums;"
        SqlRunner.run(sql)
    end

    def self.all()
        sql = "SELECT * FROM albums;"
        albums_hashes = SqlRunner.run(sql)
        return albums_hashes.map{ |album| Album.new(album)}
    end

    # def self.find_all_by_artist(artist)
    #     sql = "SELECT * FROM albums WHERE artist_id = $1;"
    #     values = [artist.id]
    #     albums_hashes = SqlRunner.run(sql, values)
    #     return albums_hashes.map{ |album| Album.new(album)}
    # end

    def artist()
        sql = "SELECT * FROM artists WHERE id = $1;"
        values = [@artist_id]
        artist_hash = SqlRunner.run(sql, values)[0]
        return Artist.new(artist_hash)
    end

end