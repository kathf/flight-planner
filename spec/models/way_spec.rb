require 'rails_helper'

RSpec.describe Way, type: :model do

  it do
    is_expected.to belong_to(:origin).
    class_name('Airport').
    with_foreign_key('origin_id')
  end

  it do
    is_expected.to belong_to(:destination).
    class_name('Airport').
    with_foreign_key('destination_id')
  end

end
