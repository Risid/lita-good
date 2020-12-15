require "spec_helper"

describe Lita::Handlers::Translator, lita_handler: true do
    let(:robot) {
        Lita::Robot.new(registry)   
    }
    subject { described_class.new(robot) }
    describe 'routing' do
        it { is_expected.to route('Lita 翻译puma') }
        it { is_expected.to route('Lita 翻译天気がいいので散歩しましょう。') }
        it { is_expected.not_to route('Lita 什么是翻译') }

        describe "functionality" do
            it '天気がいいので散歩しましょう。 when asked to' do 
                send_message 'Lita 翻译天気がいいので散歩しましょう。'
                expect(replies.last).to include('天气很好，我们去散步吧。')
            end

        end
    end
    

        
        
        
end
