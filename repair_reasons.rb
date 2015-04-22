module RepairReasons
  def repair_process(repair_data, test_mode = false)
    repaired_csv_data = []
    repair_data.each do |data|
      reason = data['retoure_reason']
      if ValidReasonsRule.can_validate?(reason)
        repaired_csv_data << data
      elsif SlashRule.can_apply?(reason)
        repaired_csv_data << SlashRule.repair(data, reason)
      elsif IntegerRule.can_apply?(reason)
        if BigIntegerRule.can_apply?(reason)
          repaired_csv_data << AnotherReasonRule.repair(data)
        else
          if TenRule.can_apply?(reason)
            repaired_csv_data << TenRule.repair(data, reason)
          else
            repaired_csv_data << IntegerRule.repair(data, reason)
          end
        end
      # If reason doesn't match to any above  rule and is not valid then '8' as unknown/another reason
      else
        repaired_csv_data << AnotherReasonRule.repair(data)
      end
    end
    repaired_csv_data
  end

  def repair_value(data, new_value = '8')
    data.merge({'retoure_reason' => new_value})
  end
end
