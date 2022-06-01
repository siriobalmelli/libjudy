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

##
# autotools subproject
#
# Build only static libraries, otherwise callers (aka "superprojects")
# will likely build but then fail runtime linkage.
#
# This seems to be because this back-end does not support/honor the 'static'
# flag of 'dependency()' in the superproject.
##
p = mod.add_project('configure',
  configure_options: [
    '--enable-shared=no',
    '--enable-static=yes'
  ]
)
Judy_dep = p.dependency('Judy')
