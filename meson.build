project('Judy', 'c',
  meson_version : '>=0.58.0',
)

mod = import('unstable_external_project')


##
# hack: copy sources to build directory.
#
# It appears Judy's autotools config may be broken for out-of-source builds:
# no amount of -I added to CFLAGS or --srcdir option to 'configure' gets any traction.
##
run_command(find_program('cp'), '-v', '-r',
  meson.current_source_dir(),
  meson.current_build_dir() + '/build',
  capture: true,
  check: true
)

# vanilla autotools subproject
p = mod.add_project('configure')
Judy_dep = p.dependency('Judy')
