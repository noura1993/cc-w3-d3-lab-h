class Album 

    attr_reader :id, :title, :genre

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @title = options['title'] 
        @genre = options['genre']
        @artist_id = options['artist_id']
    end

end