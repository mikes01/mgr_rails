require 'benchmark'
require 'csv'

class CrudLineTests
  def initialize(repeat_times)
    @repeat_times = repeat_times
    @add_time = 0
    @read_time = 0
    @update_time = 0
    @delete_time = 0
    @file_name = "./rails_crud_line_model_#{@repeat_times}.csv"

    @l1 = 'MULTILINESTRING ((17.0245292 51.1038569, 17.0291855 51.1030174))'

    @l2 = 'MULTILINESTRING ((17.0244292 51.1038569, 17.0291855 51.1030174))'

    @entity = nil
  end

  def run_tests
    @repeat_times.times do
      @add_time += Benchmark.realtime { add }
      @read_time += Benchmark.realtime { read }
      @update_time += Benchmark.realtime { update }
      @delete_time += Benchmark.realtime { delete }
    end
    results = { "Odczytanie linii" => @read_time/@repeat_times*1000,
      "Dodanie linii" => @add_time/@repeat_times*1000,
      "Zaktualizowanie linii" => @update_time/@repeat_times*1000,
      "Usunięcie linii" => @delete_time/@repeat_times*1000  }
    CSV.open(@file_name, "wb") do |csv|
      results.each do |key, value|
        csv << [key, value]
      end
    end
  end

  private
  
  def add
    @entity = Line.create({name: 'test',
      coordinates: @l1,
      road_type: "custom"})
  end

  def read
    Line.find(@entity.id)
  end

  def update
    Line.update(@entity.id, {name: 'updated',
      coordinates: @l2})
  end

  def delete
     Line.delete(@entity.id)
  end
end