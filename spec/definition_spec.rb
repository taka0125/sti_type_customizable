require 'spec_helper'

class Message
end

class WarningMessage < Message
end

class ErrorMessage < Message
end

class Definition
  include ::StiTypeCustomizable::Definition

  def load_definitions
    {warning_message: 1, error_message: 2}
  end
end

describe Definition do
  describe "#resolve_class" do
    subject { Definition.new(0).resolve_class(type_value) }

    context 'warning_message type_value' do
      let(:type_value) { 1 }

      it { expect(subject).to eq WarningMessage }
    end

    context 'error_message type_value' do
      let(:type_value) { 2 }

      it { expect(subject).to eq ErrorMessage }
    end

    context 'unknown type_value' do
      let(:type_value) { -1 }

      it { expect(subject).to be_nil }
    end
  end

  describe "#resolve_type_value" do
    subject { Definition.new(default_type_value).resolve_type_value(klass) }

    let(:default_type_value) { 0 }

    context 'warning_message class' do
      let(:klass) { WarningMessage }

      it { expect(subject).to eq 1 }
    end

    context 'error_message class' do
      let(:klass) { ErrorMessage }

      it { expect(subject).to eq 2 }
    end

    context 'unknown class' do
      let(:klass) { Message }

      it { expect(subject).to eq default_type_value }
    end
  end
end
