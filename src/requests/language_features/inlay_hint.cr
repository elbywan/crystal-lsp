require "json"
require "../../tools"
require "../../ext/enum"
require "../../base/*"
require "../request_message"

module LSP
  macro finished
    # The inlay hints request is sent from the client to the server to compute
    # inlay hints for a given [text document, range] tuple that may be rendered
    # in the editor in place with other text.
    class InlayHintRequest < RequestMessage(Array(InlayHint)?)
      @method = "textDocument/inlayHint"
      property params : InlayHintParams
    end
  end

  struct InlayHintParams
    include WorkDoneProgressParams
    include Initializer
    include JSON::Serializable

    # The text document.
    @[JSON::Field(key: "textDocument")]
    property text_document : LSP::TextDocumentIdentifier

    # The visible document range for which inlay hints should be computed.
    property range : LSP::Range
  end

  # Inlay hint information.
  struct InlayHint
    include Initializer
    include JSON::Serializable

    # The position of this hint.
    # 
    # If multiple hints have the same position, they will be shown in the order
    # they appear in the response.
    property position : LSP::Position

    # The label of this hint. A human readable string or an array of
    # InlayHintLabelPart label parts.
    #
    # *Note* that neither the string nor the label part can be empty.
    property label : String | Array(LSP::InlayHintLabelPart)

    # The kind of this hint. Can be omitted in which case the client
    # should fall back to a reasonable default.
    property kind : LSP::InlayHintKind?

    # Optional text edits that are performed when accepting this inlay hint.
    #
    # *Note* that edits are expected to change the document so that the inlay
    # hint (or its nearest variant) is now part of the document and the inlay
    # hint itself is now obsolete.
    #
    # Depending on the client capability `inlayHint.resolveSupport` clients
    # might resolve this property late using the resolve request.
    @[JSON::Field(key: "textEdits")]
    property text_edits : Array(TextEdit)?

    # The tooltip text when you hover over this item.
    #
    # Depending on the client capability `inlayHint.resolveSupport` clients
    # might resolve this property late using the resolve request.
    property tooltip : (String | LSP::MarkupContent)?

    # Render padding before the hint.
    #
    # Note: Padding should use the editor's background color, not the
    # background color of the hint itself. That means padding can be used
    # to visually align/separate an inlay hint.
    @[JSON::Field(key: "paddingLeft")]
    property padding_left : Bool?

    # Render padding after the hint.
    #
    # Note: Padding should use the editor's background color, not the
    # background color of the hint itself. That means padding can be used
    # to visually align/separate an inlay hint.
    @[JSON::Field(key: "paddingRight")]
    property padding_right : Bool?

    # A data entry field that is preserved on an inlay hint between
    # a `textDocument/inlayHint` and a `inlayHint/resolve` request.
    property data : JSON::Any?
  end

  # An inlay hint label part allows for interactive and composite labels
  # of inlay hints.
  struct InlayHintLabelPart
    include Initializer
    include JSON::Serializable

    # The value of this label part.
    property value : String

    # The tooltip text when you hover over this label part. Depending on
    # the client capability `inlayHint.resolveSupport` clients might resolve
    # this property late using the resolve request.
    property tooltip : (String | LSP::MarkupContent)?

    # An optional source code location that represents this
    # label part.
    #
    # The editor will use this location for the hover and for code navigation
    # features: This part will become a clickable link that resolves to the
    # definition of the symbol at the given location (not necessarily the
    # location itself), it shows the hover that shows at the given location,
    # and it shows a context menu with further code navigation commands.
    #
    # Depending on the client capability `inlayHint.resolveSupport` clients
    # might resolve this property late using the resolve request.
    property location : LSP::Location?

    # An optional command for this label part.
    #
    # Depending on the client capability `inlayHint.resolveSupport` clients
    # might resolve this property late using the resolve request.
    property command : LSP::Command?
  end

  # Inlay hint kinds.
  Enum.number InlayHintKind do
    # An inlay hint that for a type annotation.
    Type = 1

    # An inlay hint that is for a parameter.
    Parameter = 2
  end
end
