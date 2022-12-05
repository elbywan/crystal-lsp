require "../ext/enum"

module LSP
  Enum.number MessageType do
    # An error message.
    Error = 1
    # A warning message.
    Warning = 2
    # An information message.
    Info = 3
    # A log message.
    Log = 4
  end
end
