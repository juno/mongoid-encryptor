# -*- encoding: utf-8 -*-
require 'spec_helper'

describe "Symmetric encryption on embedded document" do
  let(:person) do
    Person.new(:first_name => 'John',
               :last_name => 'Smith',
               :credit_card => CreditCard.new(:number => '0000111122224444'))
  end

  context "Has valid attributes" do
    context "Before save" do
      subject { person.credit_card }
      its(:number) { should eq('0000111122224444') }
      it { should be_valid }
    end

    context "after save" do
      before { person.save! }
      subject { person.credit_card }
      its(:number) { should be_encrypted }
      its(:number) { should eq('0000111122224444') }
    end
  end

  it "doesn't encrypt value of field after validation" do
    person.credit_card.valid?
    person.should be_valid
  end

end
