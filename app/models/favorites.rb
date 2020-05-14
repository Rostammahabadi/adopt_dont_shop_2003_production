class Favorites
    attr_reader :contents
    def initialize(initial_contents)
        @contents = initial_contents || []
    end

    def total_count
        @contents.uniq.length
    end

    def add_pet(id)
        @contents << id
    end

    def remove_pet(id)
        @contents.delete(id)
    end
end
