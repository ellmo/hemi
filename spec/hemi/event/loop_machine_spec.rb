describe Hemi::Event::LoopMachine do
  before { described_class.purge! }

  describe ".new" do
    subject { described_class.new }

    it "class is a Singleton" do
      expect(described_class.ancestors).to include Singleton
    end

    it "privatizes .new" do
      expect { subject }.to raise_error(NoMethodError)
    end
  end

  describe "initializaion" do
    subject { described_class.instance }

    it "does not allow to create new instances" do
      expect(subject).to be_a described_class
    end

    it "starts with an empty loop list" do
      expect(described_class.loops).to eq({})
    end

    it "has no current loop" do
      expect(described_class.current).to be_nil
    end
  end

  describe ".register" do
    subject { described_class.register(*args) }

    context "no other Loops present" do
      let(:args) { [:main] }

      it "registers a new Loop" do
        expect { subject }
          .to change(described_class.loops, :count)
          .by(1)
      end

      it "sets up `current` loop" do
        expect { subject }
          .to change(described_class, :current)
          .from(nil)
      end

      describe "loop fetching" do
        it { expect(subject).to be_a Hemi::Event::EventLoop }
        it { expect(subject).to eq described_class.current }
        it { expect(subject).to eq described_class[:main] }
      end
    end
  end
end
