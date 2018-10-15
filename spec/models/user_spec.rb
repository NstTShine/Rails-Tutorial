require "rails_helper"

describe User do
  it "is valid with a name, email, password and password confirmation" do
    user = User.new(
      name: "TShine",
      email: "ahihibuonquadi@gmail.com",
      password: "123456",
      password_confirmation: "123456")
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without a password confirmation" do
    user = User.new(password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    User.create(
      name: "TShark",
      email: "tester@example.com",
      password: "123456",
      password: "123456"
    )
    user = User.new(
      name: "TShoul",
      email: "tester@example.com",
      password: "123456",
      password_confirmation: "123456"
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

end

describe User, "validation" do
  it {should ensure_length_of(:name).is_at_most(50)}
  it {should ensure_length_of(:email).is_at_most(255)}
  it {should ensure_length_of(:password).is_at_least(6)}

  # it {should validate_presence_of(:name)}
  # it {should validate_presence_of(:email)}
  # it {should validate_presence_of(:password)}
end

# # Check DB schema
# RSpec.describe User, type: :model do

#   describe "db schema" do
#     context "columns" do
#       it {should have_db_column(:name).of_type(:string)}
#       it {should have_db_column(:email).of_type(:string)}
#       it {should have_db_column(:password_digest).of_type(:string)}
#       it {should have_db_column(:remember_digest).of_type(:string)}
#       it {should have_db_column(:admin).of_type(:boolean)}
#       it {should have_db_column(:activation_digest).of_type(:string)}
#       it {should have_db_column(:activated).of_type(:boolean)}
#       it {should have_db_column(:reset_digest).of_type(:string)}
#     end
#   end


#   describe "when email format is invalid" do
#     let(:user) {FactoryGirl.create :user}
#     before do
#       addresses = %w[user@foo,com user_at_foo.org example.user@foo.
#         foo@bar_baz.com foo@bar+baz.com]
#       user.email = addresses
#       addresses.each do |invalid_address|
#         user.email = invalid_address
#       end
#     end
#     it {should_not be_valid}
#   end
# end

