from distutils.core import setup, Extension

module0 = Extension('command',
                    define_macros = [('MAJOR_VERSION', '0'),
                                     ('MINOR_VERSION', '1')],
                    include_dirs = ['/usr/local/include'],
                    libraries = ['m'],
                    library_dirs = ['/usr/local/lib'],
                    sources = ['command.c'])

module1 = Extension('sigproc',
                    define_macros = [('MAJOR_VERSION', '0'),
                                     ('MINOR_VERSION', '1')],
                    include_dirs = ['/usr/local/include'],
                    libraries = ['m'],
                    library_dirs = ['/usr/local/lib'],
                    sources = ['sigproc.c'])

setup(name = 'PackageName',
       version = '0.1',
       description = 'Control interface command generator and signal processing utilites',
       author = 'Yuan Mei',
       author_email = 'yuan.mei@gmail.com',
       url = '',
       long_description = '',
       ext_modules = [module0, module1]
)
