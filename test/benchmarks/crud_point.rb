require 'benchmark'
require 'csv'


class CrudPointTests
  def initialize(repeat_times)
    @repeat_times = repeat_times
    @add_time = 0
    @read_time = 0
    @update_time = 0
    @delete_time = 0
    @file_name = "./rails_crud_point_model_#{@repeat_times}.csv"

    @p1 = 'POINT (17.02770217540576 51.09629326329068)'
    @p2 = 'POINT (17.02870217540576 51.09629326329068)'

    @entity = nil
  end

  def run_tests
    @repeat_times.times do
      @add_time += Benchmark.realtime { add }
      @read_time += Benchmark.realtime { read }
      @update_time += Benchmark.realtime { update }
      @delete_time += Benchmark.realtime { delete }
    end
    results = { "Odczytanie punktu" => @read_time/@repeat_times*1000,
      "Dodanie punktu" => @add_time/@repeat_times*1000,
      "Zaktualizowanie punktu" => @update_time/@repeat_times*1000,
      "Usunięcie punktu" => @delete_time/@repeat_times*1000  }
    CSV.open(@file_name, "wb") do |csv|
      results.each do |key, value|
        csv << [key, value]
      end
    end
  end

  private
  
  def add
    @entity = Point.create({name: 'test',
      coordinates: @p1,
      object_type: "część kolonii", object_class: "miejscowość",
      terc: "1234567"})
  end

  def read
    Point.find(@entity.id)
  end

  def update
    Point.update(@entity.id, {name: 'updated',
      coordinates: @p2, terc: "4567123"})
  end

  def delete
     Point.delete(@entity.id)
  end
end