require 'mkmf'

if RbConfig::CONFIG['GCC'] == 'yes'
  $CFLAGS << " -fno-defer-pop -fno-omit-frame-pointer"
end

$INSTALLFILES = [
  ["dl.h", "$(HDRDIR)"],
]

dir_config('ffi')

unless have_header('ffi.h')
  if have_header('ffi/ffi.h')
    $defs.push(format('-DUSE_HEADER_HACKS'))
  else
    abort "ffi is missing"
  end
end

unless have_library('ffi')
  abort "ffi is missing"
end

have_header('sys/mman.h')

check = true
if( have_header("dlfcn.h") )

  have_library("dl")
  check &&= have_func("dlopen")
  check &&= have_func("dlclose")
  check &&= have_func("dlsym")
  have_func("dlerror")
elsif( have_header("windows.h") )
  check &&= have_func("LoadLibrary")
  check &&= have_func("FreeLibrary")
  check &&= have_func("GetProcAddress")
else
  check = false
end

if check
  $defs << %[-DRUBY_VERSION=\\"#{RUBY_VERSION}\\"]
  create_makefile("dl")
end
