require "active_support"
require 'active_support/core_ext/enumerable'
require "speech/stages"

module Speech

  STATUS_UNPROCESSED         = 0
  STATUS_PROCESSING          = 1
  STATUS_PROCESSED           = 3
  STATUS_PROCESSING_ERROR    = -1

end

