module Speech
  module Stages
    class ProcessedStages
      include Enumerable

      PROCESSED_STAGES = {
        build: 2**0,
        encode: 2**1,
        convert: 2**2,
        extract: 2**3,
        split: 2**4,
        perform: 2**5
      }

      attr_accessor :bits

      def initialize(values = nil)
        @bits = 0
        set(values) if values
      end

      def self.bit_of(number)
        numbers = PROCESSED_STAGES.map {|k,v| number.is_a?(Fixnum) ? v : k}
        index   = numbers.index(number.is_a?(Fixnum) ? number : number.to_sym)
        index ? 2**index : 0
      end

      def set(values)
        new_keys  = ([values].flatten.map(&:to_sym) & PROCESSED_STAGES.keys)
        self.bits = new_keys.sum {|d| self.class.bit_of(d)}
        self
      end

      def get
        PROCESSED_STAGES.keys.reject {|d| ((bits || 0) & self.class.bit_of(d)).zero?}
      end
      alias_method :to_a, :get

      def add(values)
        combined_keys = (([values].flatten.map(&:to_sym) & PROCESSED_STAGES.keys) | get)
        self.bits = combined_keys.sum {|d| self.class.bit_of(d)}
      end
      alias_method :push, :add

      def <<(values)
        add(values)
      end

      def ==(other_object)
        if other_object.is_a?(self.class)
          get == other_object.get
        else
          get == ProcessedStages.new(other_object).get
        end
      end

      def each(&block)
        get.each {|stage| block.call(stage)}
      end

      def empty?
        get.empty?
      end

      def status
        bits
      end
    end # ProcessedStages
  end # Stages
end # Speech
