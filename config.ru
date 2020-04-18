run -> env {
  [200, {'Content-Type' => 'text/plain'},
    ["Your IP: #{env['REMOTE_ADDR']}"]]
  }
