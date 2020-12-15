require "spec_helper"

describe Lita::Handlers::Weather, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }
  subject { described_class.new(robot) }

  describe 'routing' do
    # 允许下列格式
    it { is_expected.to route('Lita 北京天气如何') }
    it { is_expected.to route('Lita, 北京天气怎样') }

    # 不会被识别
    it { is_expected.not_to route('Lita 北京会不会下雨') }
    it { is_expected.not_to route('Lita 北京是晴天吗') }

    describe "functionality" do
      describe "city weather" do

        it 'query city weather' do
          bad_list = %w[怀柔 大兴 海淀]
          bad_list.each { |info_bad|
            actual = subject.query_weather(info_bad)
            expect(actual).to include('温度')
          }

        end
      end
    end

  end

end
