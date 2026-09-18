require "json"
require "../../tools"
require "../../base/*"
require "../request_message"

module LSP
  macro finished
    # The prepare rename request is sent from the client to the server to check
    # whether a symbol can be renamed at a given position.
    class PrepareRenameRequest < RequestMessage(PrepareRenameResult?)
      @method = "textDocument/prepareRename"
      property params : PrepareRenameParams
    end

    # The rename request is sent from the client to the server to rename the
    # symbol at a given position.
    class RenameRequest < RequestMessage(WorkspaceEdit?)
      @method = "textDocument/rename"
      property params : RenameParams
    end
  end

  struct PrepareRenameParams
    include TextDocumentPositionParams
    include WorkDoneProgressParams
    include Initializer
    include JSON::Serializable
  end

  struct RenameParams
    include TextDocumentPositionParams
    include WorkDoneProgressParams
    include Initializer
    include JSON::Serializable

    # The new name of the symbol.
    @[JSON::Field(key: "newName")]
    property new_name : String
  end

  # The range of the symbol that would be renamed, and the text the client
  # should use as its placeholder.
  struct PrepareRenameResult
    include Initializer
    include JSON::Serializable

    property range : Range

    property placeholder : String
  end
end
