module UniversesHelper

  def description_column(record)
    textilize(h record.description)
  end
end
