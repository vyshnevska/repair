ANOTHER_REASON = '8'
# Parent class which overwrite 'retoure_reason' value if it was invalid
class Rule
  def self.repair(data, repair_data)
    data.merge({'retoure_reason' => repair_data})
  end
end

# Checks if reason is in ALLOWED_REASONS
class ValidReasonsRule
  def self.can_validate? value
    ALLOWED_REASONS.include?(value)
  end
end

# Rule: reason is like '10/1'
class SlashRule < Rule
  def self.can_apply? value
    value.scan(/(\/)/).any?
  end

  def self.repair data, value
    super(data, value.split('/').map{|el| ALLOWED_REASONS.include?(el) ? el : el.scan(/\d/).join(',')}.join(','))
  end
end

# Rule: reason is like '138'
class IntegerRule < Rule
  def self.can_apply? value
    !value.match(/[^0-9]/)
  end

  def self.repair data, value
   super(data, value.scan(/\d/).join(','))
  end
end

# Rule: reason >= 1000000
class BigIntegerRule
  def self.can_apply? value
    value.to_i >= 1000000
  end
end

# Rule: reason is like '1010'
class TenRule < Rule
  def self.can_apply? value
    value.scan('10').any?
  end

  def self.repair data, value
    to_repair = value.gsub('10', 'y')
    repaired_data = to_repair.scan(/[y\d]/).map!{|el| el == 'y' ? '10' : el}.join(',')
    super(data, repaired_data)
  end
end

# When another reason
class AnotherReasonRule < Rule
  def self.repair data
    super(data, ANOTHER_REASON)
  end
end
