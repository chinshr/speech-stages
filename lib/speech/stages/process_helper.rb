module Speech
  module Stages
    module ProcessHelper
      def self.included(base)
        base.send :attr_accessor, :processed_stages_proxy
        base.include(InstanceMethods)
      end

      module InstanceMethods

        def processed_stages=(values)
          self.processed_stages_proxy = if processed_stages_proxy
            processed_stages_proxy.set(values)
          else
            ProcessedStages.new(self, values)
          end
        end

        def processed_stages
          self.processed_stages_proxy ||= ProcessedStages.new(self)
        end

        def unprocessed?
          processed_stages.empty?
        end

        def process_built?
          processed_stages.include?(:build)
        end

        def process_encoded?
          processed_stages.include?(:encode)
        end

        def process_converted?
          processed_stages.include?(:convert)
        end

        def process_extracted?
          processed_stages.include?(:extract)
        end

        def process_split?
          processed_stages.include?(:split)
        end

        def process_performed?
          processed_stages.include?(:perform)
        end

        def processing?
          raise NotImplementedError, "status not present" unless respond_to?(:status)
          status == Speech::State::STATUS_PROCESSING
        end

        def processed?
          raise NotImplementedError, "status not present" unless respond_to?(:status)
          status == Speech::State::STATUS_PROCESSED
        end

        def processing_error?
          raise NotImplementedError, "status not present" unless respond_to?(:status)
          status == Speech::State::STATUS_PROCESSING_ERROR
        end
      end # InstanceMethods
    end # ProcessHelper
  end # Stages
end # Speech
