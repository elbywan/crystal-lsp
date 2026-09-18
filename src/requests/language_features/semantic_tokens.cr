require "json"
require "../../tools"
require "../../base/*"
require "../request_message"

module LSP
  macro finished
    # The semantic tokens request is sent from the client to the server to
    # resolve the semantic tokens of a whole document.
    class SemanticTokensRequest < RequestMessage(SemanticTokens?)
      @method = "textDocument/semanticTokens/full"
      property params : SemanticTokensParams
    end
  end

  struct SemanticTokensParams
    include WorkDoneProgressParams
    include PartialResultParams
    include Initializer
    include JSON::Serializable

    # The text document.
    @[JSON::Field(key: "textDocument")]
    property text_document : TextDocumentIdentifier
  end

  # The semantic tokens of a document.
  #
  # The data is an array of relative 5-tuples: delta line, delta start,
  # length, token type index and token modifier bitset.
  struct SemanticTokens
    include Initializer
    include JSON::Serializable

    property data : Array(Int32)

    # An optional result id, used by the delta protocol.
    @[JSON::Field(key: "resultId")]
    property result_id : String?
  end
end
