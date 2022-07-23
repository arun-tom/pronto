class Player
    attr_accessor :name, :money, :play_order, :health

    def initialize(name, play_order)
        @name = name
        @money = 16
        @play_order = play_order
        @health = 100
    end
end