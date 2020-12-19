# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------

project = 'RITY SDK manual'
copyright = '2020, Fabien Parent'
author = 'Fabien Parent <fparent@baylibre.com>'

# The full version, including alpha/beta/rc tags
release = 'rity/gatesgarth'
release_codename = 'gatesgarth'

# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx.ext.autosectionlabel',
    'sphinx.ext.intersphinx',
    'sphinx-prompt',
]

# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_rtd_theme'


autosectionlabel_prefix_document = True

intersphinx_mapping = {
    'bsp': ('https://baylibre.gitlab.io/rich-iot/meta-mediatek-bsp/',
            ('./bsp-objects.inv', None)),
}
