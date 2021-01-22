import os
import glob
from setuptools import setup
from distutils.core import Extension

setup(
    name = "RPI.icestick",
    packages = ['RPI_icestick'],
    package_dir = {'RPI_icestick' : 'python'},
    ext_modules = [Extension('RPI_icestick_spi',
                             sources = glob.glob('program/*.c'),
                             libraries = ['wiringPi'])]
)