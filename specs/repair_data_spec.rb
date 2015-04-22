require './repair_data'
require 'rspec'

describe RepairData do
  let(:csv_file) { RepairData.new('./specs/test_repair_data.csv') }

  context '#file_header' do
    it "should have header ['id', 'retoure_reason']" do
      csv_file.file_header.should eq(["id", "retoure_reason"])
    end
  end

  context '#csv_data_ho_hash' do
    it "should convert to hash" do
      mocked_hash = [{"id"=>"test_id1", "retoure_reason"=>"10"},
                     {"id"=>"test_id12", "retoure_reason"=>"1078"},
                     {"id"=>"test_id13", "retoure_reason"=>"14"},
                     {"id"=>"test_id14", "retoure_reason"=>"10/01/15"},
                     {"id"=>"test_id15", "retoure_reason"=>"x1"},
                     {"id"=>"test_id16", "retoure_reason"=>"111100000"}]
      csv_file.csv_data_ho_hash.should eq(mocked_hash)
    end
  end

  context "#repair" do
    it "should repair csv file" do
      repaired_hash = [{"id"=>"test_id1", "retoure_reason"=>"10"},
                       {"id"=>"test_id12", "retoure_reason"=>"10,7,8"},
                       {"id"=>"test_id13", "retoure_reason"=>"1,4"},
                       {"id"=>"test_id14", "retoure_reason"=>"10,0,1,1,5"},
                       {"id"=>"test_id15", "retoure_reason"=>"x1"},
                       {"id"=>"test_id16", "retoure_reason"=>"8"}]

      generated_csv = csv_file.repair
      generated_csv.should == repaired_hash
    end
  end
end
