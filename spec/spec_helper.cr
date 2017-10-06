require "spec"
require "../src/honeybadger"

class HoneybadgerTest
  def self.i_raise_error(klass, message)
    raise klass.new(message)
  end
end

class DummyError
  def message
    "Foo"
  end

  def backtrace?
    [
      "0x450cb7: *CallStack::unwind:Array(Pointer(Void)) at ??",
      "0x4937cf: i_raise_error at /app/src/honeybadger.cr 18:5",
      "0x43f7fa: __crystal_main at /app/src/honeybadger.cr 22:1",
      "0x44eca9: main at /opt/crystal/src/main.cr 12:15",
      "0x7f3536d0d830: __libc_start_main at ??",
      "0x43f119: _start at ??",
      "0x0: ??? at ??",
    ]
  end
end
