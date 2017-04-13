## \file
# setup for hexlib.{h,c}
from distutils.core import setup, Extension

module1 = Extension('hexlib',
                    define_macros = [('MAJOR_VERSION', '0'),
                                     ('MINOR_VERSION', '1')],
                    include_dirs = ['/usr/local/include'],
                    libraries = ['m'],
                    library_dirs = ['/usr/local/lib'],
                    sources = ['hexlib.c'])

setup(name = 'PackageName',
      version = '0.1',
      description = 'Hexagonal grid coordinate transformation',
      author = 'Yuan Mei',
      author_email = 'yuan.mei@gmail.com',
      url = '',
      long_description = '',
      ext_modules = [module1]
)
