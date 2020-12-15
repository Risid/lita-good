require "spec_helper"

describe Lita::Handlers::Good, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }
  subject { described_class.new(robot) }

  describe 'routing' do
    # 允许下列格式
    it { is_expected.to route('Lita "lita translation"') }
    it { is_expected.to route('Lita, "lita translation"') }

    # 单引号和不加引号都不会被识别
    it { is_expected.not_to route('Lita \'lita translation\'') }
    it { is_expected.not_to route('Lita lita translation') }

    describe "functionality" do
      describe "not contain" do

        it 'when wiki not contain' do
          bad_list = %w[asdfawefsdfa herthsdbes tq38rghikudfhg]
          bad_list.each { |info_bad|
            actual = subject.search_info info_bad
            expected = "Lita没有找到有关#{info_bad}的信息"
            expect(actual).to eq(expected)
          }

        end
      end

      it 'lita when asked to' do
        send_message 'Lita "lita"'
        respond_data = '1. Lita translation：如果lita translation missing，可以通过设置临时的utf-8.us来解决。 https://wiki.risid.com/index.php/Lita%20translation'
        expect(replies.last).to eq(respond_data)
      end
    end

  end

end


