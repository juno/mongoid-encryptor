# -*- encoding: utf-8 -*-
require 'spec_helper'

describe 'Encrypted attributes' do
  context "Not encryption" do
    let(:credential) { Credential.create(:email => 'john.smith@example.com') }
    before { credential.password = 'this is not a secret' }
    subject { credential.password }
    it { should eq('this is not a secret') }
  end

  context "Has invalid attributes" do
    let(:credential) { Credential.create(:email => nil) }
    before { credential.password = 'this is not a secret' }
    subject { credential }
    it { should_not be_valid }
  end
end
