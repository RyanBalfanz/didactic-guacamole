# The Scripts

<https://github.com/github/scripts-to-rule-them-all>

Each of these scripts is responsible for a unit of work. This way they can be called from other scripts.

## script/install

[`script/install`][install] installs the Python requirements.

System dependencies configured via Travis CI.

## script/build

[`script/build`][build] builds the additional resume formats from source Markdown resume.

The goal is to make sure all required files are created before generating the documentation website.

## script/build_docs

[`script/build_docs`][build_docs] builds the documentation website.

The result of this script is a directory to be publish via the [`gh-pages`](https://github.com/RyanBalfanz/resume-proof-of-concept/tree/gh-pages) branch.

[install]: ./install
[build]: ./build
[build_docs]: ./build_docs
