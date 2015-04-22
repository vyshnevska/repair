require './repair_rules'
require 'rspec'

describe ValidReasonsRule do
  context '#can_validate?' do
    it "should return valid for '10'" do
      ValidReasonsRule.can_validate?('10').should eq(true)
    end
    it "should not be valid for 'x10'" do
      ValidReasonsRule.can_validate?('x10').should eq(false)
    end
  end
end

describe SlashRule do
  let(:reason){'10/1'}
  let(:data){ {'id' => '10010101', 'retoure_reason' => reason}}

  context '#repair' do
    it "should return valid for '10/1'" do
      SlashRule.repair(data, reason).should eq({"id"=>"10010101", "retoure_reason"=>'10,1'})
    end
    it "should not repair data if it can't be applied" do
      SlashRule.can_apply?('10').should eq(false)
    end
  end
end

describe IntegerRule do
  let(:reason){'138'}
  let(:data){ {'id' => '10010101', 'retoure_reason' => reason}}

  context '#repair' do
    it "should repair '138' to '1,3,8'" do
      IntegerRule.can_apply?(reason).should eq(true)
      IntegerRule.repair(data, reason).should eq({"id"=>"10010101", "retoure_reason"=>"1,3,8"})
    end
  end
end

describe BigIntegerRule do
  let(:reason){'10000000111'}

  context '#can_apply?' do
    it "should apply for big numbers like '10000000111'" do
      BigIntegerRule.can_apply?(reason).should eq(true)
    end
  end
end

describe TenRule do
  let(:reason){'1012310'}
  let(:data){{'id' => '10010101', 'retoure_reason' => reason}}

  context '#repair' do
    it "should repair '138' to '1,3,8'" do
      TenRule.can_apply?(reason).should eq(true)
      TenRule.repair(data, reason).should eq({"id"=>"10010101", "retoure_reason"=>"10,1,2,3,10"})
    end
  end
end

