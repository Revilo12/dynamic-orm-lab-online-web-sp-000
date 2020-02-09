require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash = true

    sql = <<-SQL
        PRAGMA table_info(?)
        SQL

    info_hash = DB[:conn].execute(sql, self.table_name)

    column_names = []

    info_hash.each do |column|
      column_names << column["name"]
    end

    column_names.flatten
  end
end
