require "json"
require "../tools"
require "../base/*"
require "./request_message"

module LSP
  macro finished
    # The workspace symbol request is sent from the client to the server to
    # list the symbols matching a query across the workspace.
    class WorkspaceSymbolRequest < RequestMessage(Array(SymbolInformation)?)
      @method = "workspace/symbol"
      property params : WorkspaceSymbolParams
    end
  end

  struct WorkspaceSymbolParams
    include WorkDoneProgressParams
    include PartialResultParams
    include Initializer
    include JSON::Serializable

    # A query string to filter symbols by, matching is server specific.
    property query : String
  end
end
