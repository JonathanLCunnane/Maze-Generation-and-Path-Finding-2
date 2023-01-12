class Direction
    @@north = "NORTH"
    @@east = "EAST"
    @@south = "SOUTH"
    @@west = "WEST"

    def self.north
        @@north
    end

    def self.east
        @@east
    end

    def self.south
        @@south
    end

    def self.west
        @@west
    end

    def self.opposites?(dir_one, dir_two)
        (dir_one == @@north && dir_two == @@south || dir_one == @@east && dir_two == @@west || dir_one == @@south && dir_two == @@north || dir_one == @@west && dir_two == @@east)
    end
end