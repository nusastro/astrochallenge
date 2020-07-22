# Typesetting AstroChallenge <!-- omit in toc -->

- [Introduction](#introduction)
- [Setup (Automatic)](#setup-automatic)
  - [Windows](#windows)
  - [*nix (macOS, Linux)](#nix-macos-linux)
- [Setup (Manual)](#setup-manual)
- [Typesetting Basics](#typesetting-basics)
  - [The AstroChallenge Document Class](#the-astrochallenge-document-class)
  - [Document Class Arguments](#document-class-arguments)
  - [Setting the Date](#setting-the-date)
  - [Typesetting MCQ papers](#typesetting-mcq-papers)

## Introduction

The MCQ, Team and Observation rounds of AstroChallenge have long been _manually_ typeset either in Word&reg; or LaTeX, which has been an arduous, repetitive task for the typesetter of the given year.

This repository provides a LaTeX document class file, [astrochallenge.cls](/latex/preambles/astrochallenge.cls), which attempts to alleviate some of this tedium. This class is based on the LaTeX [`exam`](https://ctan.org/pkg/exam?lang=en) class, which itself makes typesetting exams in LaTeX more straightforward (documentation for `exam` may be found [here](http://mirrors.ctan.org/macros/latex/contrib/exam/examdoc.pdf)). `astrochallenge.cls` may be used in any TeX typesetting environment, including but not limited to TeX Live, [Overleaf](https://overleaf.com), and MiKTeX.

This repository also provides a [PowerShell script](latex/scripts/createpapers.ps1) (for use on Windows) and a [Perl script](/latex/scripts/createpapers.pl) (for use on *nix environments, e.g. macOS and Linux) which sets up boilerplate code. This script is _optional_, and does not affect the functionality of the document class whatsoever.

## Setup (Automatic)

This section assumes that the repository has already been cloned to a local drive on your computer (for more information, see [the relevant section in the main README](/docs/README.md#Setup)).

As mentioned above, two scripts—in PowerShell for Windows and in Perl for *nix have been provided, both of which:

1. Create a working directory for the LaTeX files (**hard-coded** as `latex/typeset`; if this directory is already present, no changes are made);
2. generate boilerplate code for each of the categories and rounds;
3. copy the document class file to the working directory.

### Windows

`createpapers.ps1` is *unsigned*, so you will have to change or bypass the Windows execution policy to execute it (assuming the defaults). This documentation will assist you with the latter.

1. Navigate to the `latex/scripts` directory in PowerShell (either with `cd`, or by directly launching it from Windows Explorer by going to the Ribbon, selecting `File` → `Open Windows PowerShell` → `Open Windows PowerShell` (yes, that's twice)).
2. Execute the following command:

    ```PowerShell
    > -ExecutionPolicy Bypass -File .\createpapers.ps1
    ```

     Follow the on-screen prompts to create the boilerplate files, currently named `AC_<year>_<category>_<round>.tex`. For instance, the Team Round paper for AstroChallenge 2022, in the Senior category, would be named `AC_2022_SNR_Team.tex`.

3. Proceed with typesetting the competition.

### *nix (macOS, Linux)

> **INCOMPLETE SECTION: SCRIPT NOT READY**

## Setup (Manual)

If you would rather set up the `.tex` files yourself than rely on the scripts provided, refer to the following section, [Typesetting Basics](#typesetting-basics).

## Typesetting Basics

> **NOTE**: This document assumes at least *some* familiarity with LaTeX typesetting; therefore, basic typesetting commands are out of scope. For a comprehensive LaTeX tutorial, consult any one of:
>
> - [*The Not So Short Introduction to LaTeX*](http://mirrors.ctan.org/info/lshort/english/lshort.pdf);
> - [OverLeaf's *Learn LaTeX in 30 minutes* online tutorial](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes),
>
> or any number of the tutorials on YouTube, or Reddit. Furthermore, help with the `exam` class may be found at the

### The AstroChallenge Document Class

If you have chosen to use the scripts to automate set-up, the file, `astrochallenge.cls`, is copied into a working directory, `latex/typeset`, and several `.tex` files are generated, with boilerplate code. These files are *immediately* compilable, given some caveats:

1. The document class assumes that a file, `logo.jpg`, is present in the directory `latex/graphics/misc`. This file comes with the repository, and is meant to handle graphics files created by the author.
2. The compiler used is `pdfLaTeX`, and a *complete* TeX installation is available.

> **NOTE**: If you are manually creating your files, copy **both** the `astrochallenge.cls` file, **and** the `latex/graphics` directory to a working directory of your choice; otherwise, your compilation **will** fail.

The first line of each file is as follows, with some variations corresponding to the filename:

```latex
\documentclass[lmodern,junior,mcq]{astrochallenge}
```

The `\documentclass` command typically accepts *optional* arguments, given as a comma-separated list within square brackets, as demonstrated above. However, in this case, *at least* one argument from *each* table is **mandatory**, for a total of three arguments. If you are setting up your `.tex` files manually, consult the following tables for the behaviour of each argument.

### Document Class Arguments

| Typeface command | Effect |
|:-:|-|
| `lmodern` | The document is typeset in Latin Modern, the default LaTeX typeface. <br><br> **NOTE**: This is a compatibility option, as some text in the title is rasterised upon compilation; the document class emits a warning, notifying the user as such, too.  |
| `minionpro` | The document is typeset in Adobe Minion Pro, and this is the author-intended typeface for AstroChallenge. <br><br>This typeface requires some setup, at least at this stage. Contact the author to set up minionpro on your system. |

| Category command | Effect |
|:-:|-|
| `junior` | The title page and header display `Junior XYZ Round`, where `XYZ` is the Round command in effect. |
| `senior` | The title page and header display `Senior XYZ Round`, where `XYZ` is the Round command in effect. |

| Round command | Effect |
|:-:|-|
| `mcq` | The title page and header display `XYZ MCQ Round`, where `XYZ` is the Category command in effect. |
| `team` | The title page and header display `XYZ Team Round`, where `XYZ` is the Category command in effect. |
| `obs` | The title page and header display `XYZ Observation Round`, where `XYZ` is the Category command in effect. |
| `daq` | The title page and header display `XYZ Data Analysis Round`, where `XYZ` is the Category command in effect. |

In the case of the latter three commands, i.e. `team`, `obs` and `daq`, the numbering of the `questions` environment is changed, as it is expected that each Team Round question is delimited by the LaTeX-native `\section{}` command.

### Setting the Date

`astrochallenge.cls` provides another **mandatory** command to set the date of the paper:

```latex
\setacpaperdate{2020-12-01}
```

This command accepts an argument in the `YYYY-MM-DD` format, which is *automatically* populated by the script, if the latter is used. The resultant date is displayed on the cover page, along with previously-provided details.

### Typesetting MCQ papers

The document class provides easy typesetting for the MCQ round of AstroChallenge, and the options are *auto-randomised*. unless explicitly requested by the typesetter. 
