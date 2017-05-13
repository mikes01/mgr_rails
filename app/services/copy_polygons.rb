class CopyPolygons < BaseService
  def initialize(source_model, unit_type)
    self.source_model = source_model
    self.column_names = source_model.column_names - ["id", "created_at", "updated_at"]
    self.unit_type = unit_type
  end

  attr_accessor :source_model, :column_names, :unit_type

  def call
    source_model.find_each do |source_record|
      destination_record = AllPolygon.new unit_type: unit_type
      column_names.each do |column|
        destination_record[column] = source_record[column]
      end
      destination_record.save!
    end
  end
end