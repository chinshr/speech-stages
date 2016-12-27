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
            ProcessedStages.new(values)
          end
        end

        def processed_stages
          self.processed_stages_proxy ||= ProcessedStages.new
        end

        def unprocessed?
          processed_stages.empty?
        end

        def built?
          processed_stages.include?(:build)
        end

        def encoded?
          processed_stages.include?(:encode)
        end

        def converted?
          processed_stages.include?(:convert)
        end

        def extracted?
          processed_stages.include?(:extract)
        end

        def split?
          processed_stages.include?(:split)
        end

        def performed?
          processed_stages.include?(:perform)
        end

        def processing?
          raise NotImplementedError, "status not present" unless respond_to?(:status)
          status == Speech::STATUS_PROCESSING
        end

        def processed?
          raise NotImplementedError, "status not present" unless respond_to?(:status)
          status == Speech::STATUS_PROCESSED
        end

        def processing_error?
          raise NotImplementedError, "status not present" unless respond_to?(:status)
          status == Speech::STATUS_PROCESSING_ERROR
        end
      end # InstanceMethods
    end # ProcessHelper
  end # Stages
end # Speech
