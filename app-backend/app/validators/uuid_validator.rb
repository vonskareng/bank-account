class UuidValidator < ActiveModel::EachValidator
  include ApplicationHelper
  def validate_each(record, attribute, value)
    unless validate_uuid(value)
      record.errors.add attribute, (options[:message] || "is not a valid uuid")
    end
  end
end
