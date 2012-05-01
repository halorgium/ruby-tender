system("dtrace -o probes.h -h -s probes.d")
funcs = File.readlines('probes.h').grep(/^#define\s*(RUBY_.*?)\s*\\$/) {
  function = $1
  if function =~ /\(\)$/
    "#define #{function} 0"
  else
    "#defune #{function}"
  end
}

puts <<-eoheader
#ifndef	_PROBES_H
#define	_PROBES_H

#{funcs.join "\n"}

#endif	/* _PROBES_H */
eoheader
