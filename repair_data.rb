##
# Script to repair corrupted return reasons
#
# Main file: 'repair_data.rb'
#   Parses corrupted csv file and creates new with fixed return reasons.
#
# File: 'repair_reasons.rb'
#   Provides logic of identifying invalid reasons and generate repaired output
#
# File: 'repair_rules.rb'
#   Provides classes for each type of repair rule. Class knows if it can be applied and how to repair value
#
##
require 'csv'
require 'roo'
require './repair_rules'
require './repair_reasons'

ALLOWED_REASONS   = %w(1 2 3 4 5 6 7 8 9 10 x1 x2 x3 x4)
CSV_FILE          = 'corrupt_reasons.csv'
REPAIRED_CSV      = 'corrupt_reasons_fixed.csv'

class RepairData
  include RepairReasons
  attr_reader :corrupted_file, :file_header

  def initialize(file)
   @corrupted_file = Roo::CSV.new(file)
  end

  def file_header
    @file_header = @corrupted_file.row(1)
  end

  def csv_data_ho_hash
    (2..@corrupted_file.last_row).inject([]){|arr, i| arr << Hash[[file_header, @corrupted_file.row(i)].transpose]; arr}
  end

  def generate_repaired_csv(new_file, data = {})
    CSV.open(new_file, 'wb', converters: :numeric) do |csv_object|
      csv_object << file_header
      data.each do |data_row|
        csv_object << data_row.values
      end
    end
  end

  def repair
    repaired_csv_data = repair_process(csv_data_ho_hash)
    puts "File #{REPAIRED_CSV} was created!"
    generate_repaired_csv(REPAIRED_CSV, repaired_csv_data)
  end
end

# Let's repair our data!
file_to_repair = RepairData.new(CSV_FILE)
file_to_repair.repair
