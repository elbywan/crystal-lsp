require "json"
require "../../tools"
require "../../base/*"
require "../request_message"

module LSP
  macro finished
    # The selection range request is sent from the client to the server to
    # resolve the selection ranges around the given positions.
    class SelectionRangeRequest < RequestMessage(Array(SelectionRange)?)
      @method = "textDocument/selectionRange"
      property params : SelectionRangeParams
    end
  end

  struct SelectionRangeParams
    include WorkDoneProgressParams
    include PartialResultParams
    include Initializer
    include JSON::Serializable

    # The text document.
    @[JSON::Field(key: "textDocument")]
    property text_document : TextDocumentIdentifier

    # The positions inside the text document.
    property positions : Array(Position)
  end

  # A selection range: a range and its parents, from the innermost to the
  # outermost. Every parent contains its child.
  #
  # A class rather than a struct: the parent is another selection range.
  class SelectionRange
    include Initializer
    include JSON::Serializable

    property range : Range

    property parent : SelectionRange?
  end
end
