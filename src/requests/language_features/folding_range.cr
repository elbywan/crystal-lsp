require "json"
require "../../tools"
require "../../base/*"
require "../request_message"

module LSP
  macro finished
    # The folding range request is sent from the client to the server to
    # resolve the foldable regions of a document.
    class FoldingRangeRequest < RequestMessage(Array(FoldingRange)?)
      @method = "textDocument/foldingRange"
      property params : FoldingRangeParams
    end
  end

  struct FoldingRangeParams
    include WorkDoneProgressParams
    include PartialResultParams
    include Initializer
    include JSON::Serializable

    # The text document.
    @[JSON::Field(key: "textDocument")]
    property text_document : TextDocumentIdentifier
  end

  # A range of lines the client can fold.
  struct FoldingRange
    include Initializer
    include JSON::Serializable

    # The zero-based line where the folding range starts.
    @[JSON::Field(key: "startLine")]
    property start_line : Int32

    # The zero-based line where the folding range ends (included in the folded
    # region).
    @[JSON::Field(key: "endLine")]
    property end_line : Int32

    # The zero-based character where the folding range starts. Only sent to
    # clients that did not announce `lineFoldingOnly`.
    @[JSON::Field(key: "startCharacter")]
    property start_character : Int32?

    # The zero-based character where the folding range ends.
    @[JSON::Field(key: "endCharacter")]
    property end_character : Int32?

    # The kind of the folding range, if it is not a comment or an import.
    property kind : FoldingRangeKind?
  end

  # A kind of folding range.
  Enum.string FoldingRangeKind do
    # Folding range for a comment.
    Comment
    # Folding range for a group of imports.
    Imports
    # Folding range for a region (`#region`/`#endregion`).
    Region
  end
end
