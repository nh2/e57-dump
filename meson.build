project('e57-dump', ['cpp'], version: '1.0', default_options: [
  # Note: Changing this requires a build dir wipe.
  'cpp_std=c++17',
  'default_library=shared', # if you change this, update the comment at `library()` below
])

warning_level = 3 # Implies `-Wall`; we want all the warnings.

common_linker_flags = [
  # Treats undefined symbols as errors; raises linker errors early
  # (creating shared libraries that are missing direct dependencies),
  # see https://wiki.gentoo.org/wiki/Project:Quality_Assurance/-Wl,-z,defs_and_-Wl,--no-allow-shlib-undefined
  '-Wl,-z,defs',
]

cxx = meson.get_compiler('cpp')

# libe57format

libe57format_dep = dependency('E57Format')

# xercesc, dependency of libE57Format

xercesc_dep = dependency('XercesC')


# Our dependencies

e57dump_dependencies = [
  libe57format_dep,
  xercesc_dep,
]

# Our executables

executable(
  'e57-dump',
  sources: ['src/main.cpp'],
  dependencies: e57dump_dependencies,
  link_args: common_linker_flags,
  install: true,
)

# Configuration summary

# Print important variables and configuration results
summary_dict = {
  # TODO: The string formatting is a workaround for `--reconfigure --debug` crashing
  #       on non-string variables.
  #       Remove formatting when https://github.com/mesonbuild/meson/issues/6646 is available.
  'buildtype': '@0@'.format(get_option('buildtype')),
  'debug': '@0@'.format(get_option('debug')),
  # TODO: The string formatting is a workaround for `summary()` crashing on empty list.
  #       Remove formatting when https://github.com/mesonbuild/meson/issues/6645 is available.
  'common_linker_flags': '@0@'.format(common_linker_flags),
}

summary(summary_dict, section: 'Important variables')
