module SpacedRepetition
  class Calendar

    Intervals = [0, 1,  3,  8,  21,  55,  144,  377] #every second fib
    attr_accessor :calendar, :current_day

    def initialize
      @calendar = {}
      create_cal
    end

    def create_cal
      Intervals.max.times do |int|
        @calendar[int+1] = DayOfTheYear.new
      end

      current_day # to make sure it gets generated
    end

    def current_day
      @current_day ||= @calendar[ rand( @calendar.size + 1 ) ]
    end

    def [](int)
      @calendar[int]
    end

    def <<(task)
      Intervals.each do |interval|
        day_of_the_year = @current_day.which + interval
        @calendar[day_of_the_year] << task if @calendar[day_of_the_year]
        #it goes out of bounds
      end
    end

    def to_s
      "spaced repetition: #{@calendar}"
    end

    private

      def []=(int,hint)
      end
  end


  class DayOfTheYear

    @@last_day_num = 0
    attr_reader :which
    attr_accessor :tasks  #just an array od object_ids for now

    def initialize
      @which = @@last_day_num
      @@last_day_num += 1
      @tasks = []
    end

    def to_s
      "'#{@which}: #{@tasks.map(&:to_object).map(&:inspect)}'"
    end

    def <<(object)
      @tasks << object.object_id
    end
  end

  class Task
    attr_accessor :description

    def initialize
    end

    def to_s
      "task: #{@description.to_s}"
    end
  end

  # class Manger
  #   def initialize

  #   end
  # end
end


class Fixnum
  def to_object
    ObjectSpace._id2ref self
  end
end

class Bignum
  def to_object
    ObjectSpace._id2ref self
  end
end

# t1 = SpacedRepetition::Task.new; t1.description = "jeden"
# t2 = SpacedRepetition::Task.new; t2.description = "dwa"

# cal = SpacedRepetition::Calendar.new
