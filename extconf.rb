require 'mkmf'

ok = true
hdr = nil
case
when macro_defined?("_WIN32", "")
  have_func("rb_w32_map_errno", "ruby.h")
when hdr = %w"termios.h termio.h".find {|h| have_header(h)}
  have_func("cfmakeraw", hdr)
when have_header(hdr = "sgtty.h")
  %w"stty gtty".each {|f| have_func(f, hdr)}
else
  ok = false
end
if ok
  create_makefile("io/console")
end
