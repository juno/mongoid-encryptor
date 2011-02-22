# -*- encoding: utf-8 -*-
require 'spec_helper'

describe "Symmetric encryption" do
  let(:credential) { SymmetricCredential.create(:email => 'john.smith@example.com', :password => 'this is a secret') }

  context "'this is a secret'" do
    subject { credential.password }
    it { should eq("y3HnNrU0HviAl3aw2sWH1KttBLsCLYP1\n") }
    it { should be_encrypted }
    it { should eq('this is a secret') }
  end

  context 'cipher' do
    subject { credential.password.cipher }
    it { should be_an_instance_of(EncryptedStrings::SymmetricCipher) }
  end

  context 'cipher password' do
    subject { credential.password.cipher.password }
    it { should eq('key') }
  end
end
