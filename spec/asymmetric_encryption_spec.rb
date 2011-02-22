# -*- encoding: utf-8 -*-
require 'spec_helper'

describe 'Asymmetric encryption' do
  let(:credential) { AsymmetricCredential.create(:email => 'john.smith@example.com', :password => 'this is a secret') }

  context "#to_s" do
    subject { "#{credential.password}" }
    it { should_not eq('this is a secret') }
  end

  context "'this is a secret'" do
    subject { credential.password }
    it { should be_encrypted }
    it { should eq('this is a secret') }
  end

  context "attribute length" do
    subject { credential.password.length }
    it { should eq(175) }
  end

  context "cipher" do
    subject { credential.password.cipher }
    it { should be_an_instance_of(EncryptedStrings::AsymmetricCipher) }
  end
end
