# `lsp`

[![ci](https://github.com/elbywan/crystal-lsp/actions/workflows/ci.yml/badge.svg)](https://github.com/elbywan/crystal-lsp/actions/workflows/ci.yml)
[![docs](https://img.shields.io/badge/%F0%9F%93%9A-Crystal%20docs-blueviolet)](https://elbywan.github.io/crystal-lsp/)

### An implementation of the Language Server Protocol written in Crystal.

This shard is a **partial** implementation of the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/).
It contains json mappings to the data structures and messages as well as a fully working server implementation.

_The code has originally been written for the [crystalline](https://github.com/elbywan/crystalline) tool and is now extracted here._

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     lsp:
       github: elbywan/crystal-lsp
   ```

2. Run `shards install`

## Usage

```crystal
require "lsp/server"

# Declare the server capabilities
# See: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#capabilities
server_capabilities = LSP::ServerCapabilities.new(
  # ...
)

# STDIN and STDOUT are used by default, but you can pass any IO.
server = LSP::Server.new(STDIN, STDOUT, server_capabilities)
# A Controller is a class or struct that responds to client events.
# Example: https://github.com/elbywan/crystalline/blob/master/src/crystalline/controller.cr
server.start(Controller.new)

struct Controller
  # Called just after receiving the "initialize" request
  def on_init(init_params : LSP::InitializeParams) : Nil
    # …
  end

  # Called after the handshake is complete and before listening for requests and notifications
  def when_ready : Nil
    # …
  end

  # Called when the client sends a request (https://microsoft.github.io/language-server-protocol/specifications/specification-3-16/#requestMessage)
  def on_request(message : LSP::RequestMessage)
    # …
  end

  # Called when the client sends a notification (https://microsoft.github.io/language-server-protocol/specifications/specification-3-16/#notificationMessage)
  def on_notification(message : LSP::NotificationMessage) : Nil
    # …
  end

  # Called when the client sends a response (https://microsoft.github.io/language-server-protocol/specifications/specification-3-16/#responseMessage)
  def on_response(message : LSP::ResponseMessage, original_message : LSP::RequestMessage?) : Nil
    # …
  end
end
```

## Contributing

1. Fork it (<https://github.com/elbywan/lsp/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Julien Elbaz](https://github.com/elbywan) - creator and maintainer
