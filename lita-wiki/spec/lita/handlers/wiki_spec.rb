require "spec_helper"

describe Lita::Handlers::Wiki, lita_handler: true do
  # 允许下列格式
  it { is_expected.to route('Lita wiki Ruby') }
  it { is_expected.to route('Lita, wiki Ruby') }

  # 不会被识别
  it { is_expected.not_to route('Lita Ruby wiki') }

  describe "functionality" do
    describe "contain" do

      it 'when wiki contain' do
        good_list = %w[Ruby Kotlin Python]
        good_list.each { |info_good|
          actual = subject.search_info info_good
          expect(actual).to include("1.")
        }

      end
    end
  end

end
