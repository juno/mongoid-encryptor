# -*- encoding: utf-8 -*-
require 'spec_helper'

describe 'SHA encryption' do
  let(:credential) {
    ShaCredential.create(:email => 'john.smith@example.com',
                         :password => 'this is a secret',
                         :options => ['foo', 'bar', 'baz'])
  }

  context "#to_s" do
    subject { "#{credential.password}" }
    it { should eq("70a202166f0a78defe464d810f30b50b767cb89a") }
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

  context "use default salt" do
    subject { credential.password.cipher.salt }
    it { should eq('salt') }
  end

  context "load from database" do
    subject { ShaCredential.find(credential.id).password }
    it { should be_encrypted }
    it { should eq('this is a secret') }

    context "#to_s" do
      subject { "#{ShaCredential.find(credential.id).password}" }
      it { should eq("70a202166f0a78defe464d810f30b50b767cb89a") }
    end
  end

  context "with mass assignment" do
    let(:credential) {
      ShaCredential.new(:email => 'john.smith@example.com',
                        :password => 'this is a secret',
                        :options => ['foo', 'bar', 'baz'])
    }
    subject { credential.password }
    it { should eq('this is a secret') }
    it { should_not be_encrypted }

    context "after save" do
      before { credential.save! }
      subject { credential.password }
      it { should be_encrypted }
      it { should eq('this is a secret') }

      context "#to_s" do
        subject { "#{credential.password}" }
        it { should eq('70a202166f0a78defe464d810f30b50b767cb89a') }
      end
    end
  end
end
