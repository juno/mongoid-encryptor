# -*- encoding: utf-8 -*-
require 'spec_helper'

describe "Symmetric encryption on embedded document" do
  let(:credit_card) { CreditCard.new(:number => '0000111122224444') }
  let(:person) { Person.new(:first_name => 'John', :last_name => 'Smith', :credit_card => credit_card) }

  context "Has valid attributes" do
    context "Before save" do
      subject { credit_card }
      its(:number) { should eq('0000111122224444') }
      it { should be_valid }
    end

    context "after save" do
      before { credit_card.save! }
      subject { credit_card }
      its(:number) { should be_encrypted }
      its(:number) { should eq('0000111122224444') }
    end
  end

end
