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

        def stage_built?
          processed_stages.include?(:build)
        end

        def stage_encoded?
          processed_stages.include?(:encode)
        end

        def stage_converted?
          processed_stages.include?(:convert)
        end

        def stage_extracted?
          processed_stages.include?(:extract)
        end

        def stage_split?
          processed_stages.include?(:split)
        end

        def stage_performed?
          processed_stages.include?(:perform)
        end

        def state_processing?
          raise NotImplementedError, "status not present" unless respond_to?(:status)
          status == Speech::State::STATUS_PROCESSING
        end

        def state_processed?
          raise NotImplementedError, "status not present" unless respond_to?(:status)
          status == Speech::State::STATUS_PROCESSED
        end

        def state_processing_error?
          raise NotImplementedError, "status not present" unless respond_to?(:status)
          status == Speech::State::STATUS_PROCESSING_ERROR
        end
      end # InstanceMethods
    end # ProcessHelper
  end # Stages
end # Speech
