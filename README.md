# Description

KAIST Thesis Template for B.S., M.S., Ph.D graduation.

## Usage

### 0. Preprequisite

You need to install `textlive-full` before using this package.

```/bin/bash
$ sudo apt install texlive-full
```

### 1. Clone the git repo:
```
$ git clone git@github.com:0xdkay/kaist-thesis-template.git
```

### 2. Build it:
``` sh
$ make

(check p.pdf)
```

### 3. Structure
```
├── aspell.words                 # checked spell words for `make spell`
├── bin                          # helper scripts
│   ├── abbrv.pl
│   ├── aspell.sh
│   ├── diff.sh
│   ├── double.pl
│   ├── get-tex-files.sh
│   ├── hyphens.sh
│   ├── latexrun
│   ├── parse-latex-log.py
│   ├── passive.sh
│   ├── shortmonth.sh
│   └── weasel.sh
├── cmds.tex                     # handle commands
├── code                         # folder for program code
│   └── fmt.tex
├── hdr.tex                      # title, author, advisor, referee, etc
├── tabs                         # folder for latex tables
├── figs                         # folder for figures
├── kaist-ucs.cls                # KAIST thesis template
├── Makefile
├── pkgs.tex                     # import latex packages here
├── p.tex
├── README.md
├── refs                         # folder for references
│   └── p.bib
├── sections                     # your writing starts here
│   ├── abstract.tex             # sample abstract and keywords
│   ├── ack.tex                  # sample acknoledgement
│   ├── concl.tex
│   ├── cv.tex                   # sample curriculum vitae
│   ├── intro.tex
│   └── summary.tex              # sample abstract and keywords in Korean
└── warning.tex                  # filtering warnings
```

### Original Format
```
https://github.com/tsgates/die
```
