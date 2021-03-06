require_relative('../db/sql_runner')
require_relative('./album')

class Artist 

    attr_reader :id
    attr_accessor :name

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
    end

    def albums()
        sql = "SELECT * FROM albums WHERE artist_id = $1;"
        values = [@id]
        albums_hashes = SqlRunner.run(sql, values)
        return albums_hashes.map{ |album| Album.new(album)}
    end

    def save()
        sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id;"
        values = [@name]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
        sql = "UPDATE artists SET name = $1 WHERE id = $2;"
        values = [@name, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM artists WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM artists;"
        SqlRunner.run(sql)
    end

    def self.all()
        sql = "SELECT * FROM artists;"
        artists_hashes = SqlRunner.run(sql)
        return artists_hashes.map{ |artist| Artist.new(artist)}
    end

    def self.find(id)
        sql = "SELECT * FROM artists WHERE id = $1;"
        values = [id]
        result = SqlRunner.run(sql, values)[0]
        return nil if result == nil
        return Artist.new(result)
    end

end