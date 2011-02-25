# -*- encoding: utf-8 -*-
require 'spec_helper'

describe 'Encrypted attributes' do
  context "Not encryption" do
    let(:credential) { Credential.new(:email => 'john.smith@example.com') }
    before { credential.password = 'this is not a secret' }
    subject { credential.password }
    it { should eq('this is not a secret') }
  end

  context "Has valid attributes" do
    let(:credential) { Credential.new(:email => 'john.smith@example.com') }
    before { credential.password = 'this is not a secret' }
    subject { credential }
    it { should be_valid }
  end

  context "Has invalid attributes" do
    let(:credential) { Credential.new(:email => 'invalid-address') }
    before { credential.password = '' }
    subject { credential }
    it { should_not be_valid }
  end
end
