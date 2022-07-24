class Player
    attr_accessor :name, :money, :index, :location, :health, :isCurrent_player

    def initialize(name, play_order)
        @name = name
        @money = 16
        @index = play_order
        @health = 100
        @location = 0
        @isCurrent_player = false
    end
end