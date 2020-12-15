require "spec_helper"

describe Lita::Handlers::What, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }
  subject { described_class.new(robot) }

  describe 'routing' do
    # ...是什么
    it { is_expected.to route('Lita 中国科学院大学是什么') }

    # 不支持，“什么是...”
    it { is_expected.not_to route('Lita 什么是中国科学院大学') }

    describe "functionality" do
      it '中国科学院大学 when asked to' do
        send_message 'Lita 中国科学院大学是什么'
        expect(replies.last).to include('Lita找到如下')
      end

      it '中国科学院小学 when asked to' do
        send_message 'Lita 中国科学院小学是什么'
        expect(replies.last).to include('Lita没有找到')
      end
    end

  end

end
