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

    def update_pet(id)
        if @contents.include?(id)
            remove_pet(id)
        else
            add_pet(id)
        end
    end
end
