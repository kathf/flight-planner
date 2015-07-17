require 'rails_helper'

RSpec.describe Airport, type: :model do

  it do
    is_expected.to have_one(:origin).
    class_name('Route').
    with_foreign_key('origin_id')
  end

  it do
    is_expected.to have_one(:destination).
    class_name('Route').
    with_foreign_key('destination_id')
  end

end
