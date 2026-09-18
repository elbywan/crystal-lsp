require "json"
require "../../tools"
require "../../ext/enum"
require "../../base/*"
require "../request_message"

module LSP
  macro finished
    # The document highlight request is sent from the client to the server to
    # resolve the occurrences of the symbol at a position.
    class DocumentHighlightRequest < RequestMessage(Array(DocumentHighlight)?)
      @method = "textDocument/documentHighlight"
      property params : DocumentHighlightParams
    end
  end

  struct DocumentHighlightParams
    include TextDocumentPositionParams
    include WorkDoneProgressParams
    include PartialResultParams
    include Initializer
    include JSON::Serializable
  end

  # A document highlight is a range inside a text document which deserves
  # special attention, usually an occurrence of a symbol.
  struct DocumentHighlight
    include Initializer
    include JSON::Serializable

    # The range this highlight applies to.
    property range : Range

    # The highlight kind, defaulting to `Text`.
    property kind : DocumentHighlightKind?
  end

  # The kind of a document highlight.
  Enum.number DocumentHighlightKind do
    # A textual occurrence.
    Text = 1
    # Read-access of a symbol, like reading a variable.
    Read = 2
    # Write-access of a symbol, like writing to a variable.
    Write = 3
  end
end
