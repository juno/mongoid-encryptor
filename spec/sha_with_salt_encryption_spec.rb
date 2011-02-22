# -*- encoding: utf-8 -*-
require 'spec_helper'

describe 'SHA with salt encryption' do
  let(:credential) { ShaWithSaltCredential.create(:email => 'john.smith@example.com', :password => 'this is a secret') }

  context "#to_s" do
    subject { "#{credential.password}" }
    it { should eq("f218935d0c4b9a5e6d5faae7bc6b6bd35f319cbe") }
  end

  context "'this is a secret'" do
    subject { credential.password }
    it { should be_encrypted }
    it { should eq('this is a secret') }
  end

  context "cipher" do
    subject { credential.password.cipher }
    it { should be_an_instance_of(EncryptedStrings::ShaCipher) }
  end

  context "use custom salt" do
    subject { credential.password.cipher.salt }
    it { should eq('admin') }
  end
end
