% astrochallenge.cls is based on the exam class, and simplifies typesetting the NUS/NTU AstroChallenge contest.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{astrochallenge}[20/07/14 NUS/NTU AstroChallenge document class]

%%%%% MISCELLANEOUS BUT PRIMARY IMPORTS %%%%%
\RequirePackage{iftex,etoolbox,expl3,xparse}

%%%%% FONTS & SYMBOLS %%%%%
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLASS OPTIONS DECLARATION AND PROCESSING %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newbool{islmodern}
\newbool{ismpro}

\newbool{ismcq}
\newbool{isteam}
\newbool{isobs}
\newbool{isdaq}

%%%%% FONTS %%%%%
\DeclareOption{lmodern}{\booltrue{islmodern}}
\DeclareOption{minionpro}{\booltrue{ismpro}}

%%%%% AGE CATEGORIES %%%%%
\DeclareOption{junior}{\providerobustcmd{\ac@category}{Junior}}
\DeclareOption{senior}{\providerobustcmd{\ac@category}{Senior}}

%%%%% ROUNDS %%%%%
\DeclareOption{mcq}{\providerobustcmd{\ac@round}{MCQ}\booltrue{ismcq}}
\DeclareOption{team}{\providerobustcmd{\ac@round}{Team}\booltrue{isteam}}
\DeclareOption{obs}{\providerobustcmd{\ac@round}{Observation}\booltrue{isobs}}
\DeclareOption{daq}{\providerobustcmd{\ac@round}{DAQ}\booltrue{isdaq}}

%%%%% OTHER OPTIONS TO BE FORWARDED %%%%%
\DeclareOption*{\PassOptionsToClass{addpoints,\CurrentOption}{exam}}

\ProcessOptions\relax

\providerobustcmd*{\setcatround}[1]{\pgfqkeys{/ac}{#1}}
\providerobustcmd{\catround}{\textlbl{\ac@category{} \ac@round{} Round}}

\LoadClass{exam}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FONT LOADING %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifbool{islmodern}{
    \RequirePackage{fix-cm}
    \RequirePackage[rm={lining=true,tabular=false}]{cfr-lm}
    \RequirePackage{amsfonts, amssymb}
    %%%%% Define/redefine tabular-lining and oldstyle proportional figures
    \robustify{\texttl}
    \robustify{\textpo}
    \providerobustcmd{\tablining}{\tlstyle}
    \providerobustcmd{\propold}{\postyle}
    %%%%% Define bold small caps for AC and other header labels
    \rmfamily
    \DeclareFontShape{T1}{clm2}{b}{sc}{<->ssub*cmr/bx/sc}{}
    \DeclareFontShape{T1}{clm2}{bx}{sc}{<->ssub*cmr/bx/sc}{}
    \providerobustcmd{\textlbl}[1]{\textsc{\textbf{#1}}}
    %%%%% Define title style
    \providerobustcmd{\texttitle}[1]{{\Huge\textlbl{#1}}}
    \ClassWarning{astrochallenge}{lmodern is a compatibility option. Request support from the class author to get minionpro working}
}{}

\ifbool{ismpro}{
    \ifpdftex
        \RequirePackage{MnSymbol}
        \RequirePackage[
            minionint,
            lf, 
            mathtabular,
            loosequotes,
            swash,
            opticals,
            footnotefigures
        ]{MinionPro}
        %%%%% Define/redefine tabular-lining and oldstyle proportional figures
        \providerobustcmd{\texttl}[1]{{\figureversion{tab}#1}}
        \providerobustcmd{\textpo}[1]{{\figureversion{osf}#1}}
        \providerobustcmd{\tablining}{\figureversion{tab}}
        \providerobustcmd{\propold}{\figureversion{osf}}
        % Define bold small caps for AC and other header labels
        \providerobustcmd{\textlbl}[1]{\textsc{\textbf{#1}}}
        % Define title style
        \providerobustcmd{\texttitle}[1]{{\Huge\textssc{\textbf{#1}}}}
    \fi
    \ifxetex
        % TODO: COMPLETE MINIONPRO XETEX CODE
    \fi
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PACKAGE IMPORTS %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% FONTS & SYMBOLS %%%%%
\RequirePackage{inconsolata}
\RequirePackage{amsmath}
\RequirePackage{wasysym}
\RequirePackage{microtype}

%%%%% GEOMETRY, PAGE SETUP, SPACING, PARAGRAPHING %%%%%
\RequirePackage[margin=2.5cm,a4paper]{geometry}
\RequirePackage{titlesec}
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{parskip}
\RequirePackage{tabto}
\RequirePackage{pdflscape}
\RequirePackage{enumitem}
\RequirePackage{adjustbox}
\RequirePackage[randomize,overload]{exam-randomizechoices}
\RequirePackage[super]{nth}
% SETS RANDOM CHOICES SEED: 'ASTROCHALLENGE \year' TO ASCII VALUES
\setrandomizerseed{\numexpr`A+`s+`t+`r+`o+`C+`h+`a+`l+`l+`e+`n+`g+`e+\year\relax}

%%%%% SCIENCE FORMATTING %%%%%
\RequirePackage{physics}
\RequirePackage[
    arc-separator = \,,
    retain-explicit-plus,
    %inter-unit-product =\cdot,
    detect-weight=true,
    detect-family=true,
    range-phrase=--,
    range-units=single
]{siunitx}
\RequirePackage[version=4]{mhchem}
\RequirePackage[makeroom]{cancel}
\RequirePackage{circledsteps}
% OPTIONS SETUP
\renewrobustcmd{\CancelColor}{\color{red}}
\pgfkeys{
    /csteps/inner xsep=12pt,
    /csteps/inner ysep=12pt,
}

%%%%% GRAPHICS, CAPTIONS, TABLES %%%%%
\RequirePackage[table,dvipsnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{tikz,tikz-3dplot}
\RequirePackage{pgfplots}
\RequirePackage{pdfpages}
\RequirePackage[
    justification=centering,
    labelfont={small,bf},
    font={small}]{caption}
\RequirePackage{subcaption}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage[outline]{contour}
% OPTIONS SETUP
\usetikzlibrary{
    calc,
    arrows,
    arrows.meta,
    positioning,
    decorations.pathreplacing,
    decorations.markings,
    decorations.text,
    calligraphy,
    pgfplots.dateplot
}
\pgfplotsset{compat=newest}
\contourlength{1pt}

%%%%% TIKZ CIRCLES %%%%%
\providerobustcmd*\circled[1]{
    \begin{tikzpicture}[baseline=(char.base)]
        \node[shape=circle, draw, minimum size=1.5em, inner sep=0pt] (char) {#1};
    \end{tikzpicture}
}

%%%%% REFERENCES AND LINKS %%%%%
\RequirePackage{hyperref}
\RequirePackage[noabbrev]{cleveref}

%%%%% MISCELLANEOUS %%%%%
\RequirePackage[en-GB,showdow,calc]{datetime2}
\DTMlangsetup[en-GB]{ord=raise}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MATHS MACROS AND SIUNITX SETUP %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareSIUnit{\year}{y}
\DeclareSIUnit{\AU}{AU}
\DeclareSIUnit{\parsec}{pc}
\DeclareSIUnit{\lightyear}{ly}
\DeclareSIUnit{\earthmass}{\textit{M}_{\earth}}
\DeclareSIUnit{\jupitermass}{\textit{M}_{J}}
\DeclareSIUnit{\solarmass}{\textit{M}_{\astrosun}}
\DeclareSIUnit{\atm}{atm}

\providerobustcmd{\tomb}{\quad\blacksquare{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLEVEREF AND HYPERREF SETUP %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\crefdefaultlabelformat{#2\textbf{#1}#3}

\creflabelformat{equation}{#2\textbf{(#1)}#3}
\creflabelformat{figure}{#2\textbf{#1}#3}

\crefname{equation}{\textbf{equation}}{\textbf{equations}}
\Crefname{equation}{\textbf{Equation}}{\textbf{Equations}}
\crefname{figure}{\textbf{Figure}}{\textbf{Figures}}
\Crefname{figure}{\textbf{Figure}}{\textbf{Figures}}
\crefname{table}{\textbf{Table}}{\textbf{Tables}}
\Crefname{table}{\textbf{Table}}{\textbf{Tables}}
\crefname{appendix}{\textbf{Appendix}}{\textbf{Appendices}}
\Crefname{appendix}{\textbf{Appendix}}{\textbf{Appendices}}
\crefname{section}{\textbf{\S}}{\textbf{\S}}
\Crefname{section}{\textbf{\S}}{\textbf{\S}}
\crefname{algorithm}{\textbf{Algorithm}}{\textbf{Algorithms}}
\Crefname{algorithm}{\textbf{Algorithm}}{\textbf{Algorithms}}

%%%%% SPECIFIC TO EXAM CLASS %%%%%
\creflabelformat{question}{#2\textbf{#1}#3}
\creflabelformat{partno}{(#2\textbf{#1}#3)}
\creflabelformat{subpart}{(#2\textbf{#1}#3)}

\crefname{question}{question}{questions}
\Crefname{question}{Question}{Questions}
\crefname{partno}{}{}
\Crefname{partno}{}{}
\crefname{subpart}{}{}
\Crefname{subpart}{}{}

\hypersetup{
    colorlinks   = true,            %Colours links instead of ugly boxes
    urlcolor     = NavyBlue,        %Colour for external hyperlinks
    linkcolor    = Magenta,         %Colour of internal links
    citecolor    = Aquamarine       %Colour of citations
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%% EXAM CLASS SETUP %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% QUESTION/CHOICE LABELS %%%%%
\renewrobustcmd{\questionlabel}{\thequestion.\hfill}
\renewrobustcmd{\subpartlabel}{(\thesubpart)}
\renewrobustcmd{\choicelabel}{\circled{\thechoice}}

%%%%% POINTS FORMATTING %%%%%
\renewrobustcmd{\questionshook}{
    \setlength{\rightpointsmargin}{1.75cm}
    \setlength{\itemsep}{30pt}
}

%%%%% QUESTION/PART/SUBPART INDENTATION %%%%%
\renewrobustcmd{\partshook}{
    \renewrobustcmd\makelabel[1]{\rlap{##1}\hss}
    % \setlength{\itemsep}{6pt}
}

\renewrobustcmd{\subpartshook}{
    \renewrobustcmd\makelabel[1]{\rlap{##1}\hss}
    % \setlength{\itemsep}{6pt}
}

\renewrobustcmd{\choiceshook}{
    \setlength{\labelsep}{10pt}
    \settowidth{\leftmargin}{\circled{W}.\hspace{5pt}\hspace{0em}}
    \setlength{\itemsep}{8pt}
}

\renewrobustcmd{\solutiontitle}{
    \noindent\textbf{Solution:}\par\noindent
}

%%%%% MCQ STATEMENTS LIST AND COMMANDS %%%%%
\usepackage{enumitem}
\newlist{statements}{enumerate}{1}
\setlist[statements]{align=left,leftmargin=*,parsep=8pt,label=\textbf{\Roman{*}}.}


%%%%% MCQ STATEMENTS AND CHOICES ON ONE PAGE %%%%%
\BeforeBeginEnvironment{choices}{\par\nopagebreak\minipage{\linewidth}}
\AfterEndEnvironment{choices}{\endminipage}
\BeforeBeginEnvironment{statements}{\par\nopagebreak\minipage{\linewidth}}
\AfterEndEnvironment{statements}{\endminipage\vspace*{6pt}}


%%%%% ONEPAR CHOICES SPREAD %%%%%
\patchcmd{\oneparchoices}{\penalty -50\hskip 1em plus 1em\relax}{\hfill}{}{}
\patchcmd{\oneparchoices}{\penalty -50\hskip 1em plus 1em\relax}{\hfill}{}{}

%%%%% SOLUTION ENVIRONMENT %%%%%
\SolutionEmphasis{\color{NavyBlue}}
\correctchoiceemphasis{\color{NavyBlue}\bfseries\boldmath}
\marksnotpoints{}
\pointsinrightmargin{}
\pointsdroppedatright{}
\pointformat{\bfseries\textbf[\themarginpoints]}

%%%%% REDEFINE COVER PAGINATION AS ARABIC %%%%%
\renewenvironment{coverpages}{
    \ifnum \value{numquestions}>0\relax
        \ClassError{exam}{
            Coverpages cannot be used after questions have begun.\MessageBreak
        }{
            All question, part, subpart, and subsubpart environments
            \MessageBreak
            must begin after the cover pages are complete.\MessageBreak
        }
    \fi
    \@coverpagestrue
    \adj@hdht@ftht
    \thispagestyle{headandfoot}
}{
    \clearpage
    \@coverpagesfalse
    \adj@hdht@ftht
}

%%%%% SHOW 'SOLUTIONS' IN TITLEPAGE IF ANSWERS PRINTED %%%%%
\providerobustcmd{\ac@solntitle}{
    \ifprintanswers{
        \vspace{20pt}
        \fbox{\fbox{\texttitle{\textcolor{red}{solutions}}}}
        \vspace{20pt}
    }
    \else{\vspace{20pt}}
    \fi{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%% MISCELLANEOUS %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% SET NUMBERED AND BULLETED LIST MARGIN
\setlist[itemize, 1]{left=0pt}
\setlist[enumerate, 1]{left=0pt,label=\arabic*.}

%%%%% PURPOSE FORGOTTEN %%%%%
\AtBeginEnvironment{tabularx}{
    \tablining
    \sisetup{text-rm={\tablining}}
}

\renewrobustcmd{\tabularxcolumn}[1]{m{#1}}

% ADJUST SPACES AROUND SECTION HEADERS FOR TEAM ROUND
\ifbool{isteam}{
    \renewcommand{\thesection}{Question~\arabic{section}}
    \renewcommand{\thesubsection}{Part \Roman{subsection}}
    \renewcommand{\thequestion}{\alph{question}}
    \renewcommand{\questionlabel}{(\thequestion)}
    \renewcommand{\thepartno}{\roman{partno}}
}{}
\setlength{\jot}{8pt}

%%%%% COPY-PASTABLE PDF %%%%%
\input{glyphtounicode}
\pdfgentounicode=1

%%%%% MICROTYPE SETUP FOR HYPHENATION %%%%%
\pretolerance=2500
\tolerance=4500
\emergencystretch=0pt
\righthyphenmin=4
\lefthyphenmin=4

%%%%% DEFAULT CENTRED FIGURES %%%%%
\AtBeginEnvironment{figure}{\centering}

%%%%% RADIO BUTTONS %%%%%
\providerobustcmd*{\radiobutton}{%
    \@ifstar{\@radiobutton0}{\@radiobutton1}
}
\providerobustcmd*{\@radiobutton}[1]{%
    \begin{tikzpicture}
        \pgfmathsetlengthmacro\radius{height("X")/2}
        \draw[radius=\radius] circle;
        \ifcase#1 \fill[radius=.6*\radius] circle;\fi
    \end{tikzpicture}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ASTROCHALLENGE SETUP AND MACROS %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ASTROCHALLENGE PAPER DATE %%%%%
\providerobustcmd*{\setacpaperdate}[1]{\DTMsavedate{theacpaperdate}{#1}}
\providerobustcmd*{\acpaperdate}{{\large \DTMusedate{theacpaperdate}}}

%%%%% ASTROCHALLENGE LABEL %%%%%
\providerobustcmd*{\astrochallenge}{\textlbl{AstroChallenge \textpo{\DTMfetchyear{theacpaperdate}}}}

%%%%% ASTROCHALLENGE TITLING %%%%%
\renewrobustcmd*{\@title}{\texttitle{AstroChallenge \textpo{\DTMfetchyear{theacpaperdate}}}}

\renewrobustcmd{\@author}{\textcopyright{} National University of Singapore Astronomical Society \\
    \textcopyright{} Nanyang Technological University Astronomical Society \\
}

%%%%% EXAM HEADER/FOOTER SETUP %%%%%
\coverheader{\small{\astrochallenge{}}}{}{\small{\catround{}}}
\header{\small{\astrochallenge{}}}{}{\small{\catround{}}}
\headrule{}

% USEINFO COMMAND: 'USE THE FOLLOWING INFORMATION TO ANSWER QUESTIONS...' WITH COMMA-SEPARATED LIST
\providerobustcmd{\useinfo}[2]{
    \begin{EnvFullwidth}
        \textbf{Use the following information to answer \cref{#1}}.
        \\
        #2
    \end{EnvFullwidth}

}

%%%%% PAGE NUMBERING: 'Page X of total' %%%%%
\coverfooter{}{Page \thepage{} of \totalnumpages{}}{\oddeven{\textbf{[Turn over]}}}
\footer{}{Page \thepage{} of \totalnumpages{}}{
    \oddeven{
        \iflastpage{\textbf{[End of paper]}}{\textbf{[Turn over]}}
    }
}

%%%%% ASTROCHALLENGE INSTRUCTIONS: MCQ %%%%%
\providerobustcmd*{\ac@mcqinst}{
    \begin{enumerate}[itemsep=8pt]
        \item This paper consists of \textbf{\totalnumpages} printed pages, including this cover page.
        \item Do \textlbl{not} turn over this page until instructed to do so.
        \item You have \textbf{2 hours} to attempt \textlbl{all} questions in this paper. If you think there is more than one correct answer, choose the \textit{most} correct answer.
        \item At the end of the paper, submit this booklet together with your answer script.
        \item Your answer script should clearly indicate your name, school, and team.
        \item It is \textit{your} responsibility to ensure that your answer script has been submitted.
    \end{enumerate}
}

%%%%% ASTROCHALLENGE INSTRUCTIONS: TEAM %%%%%
\providerobustcmd*{\ac@teaminst}{
    \begin{enumerate}[itemsep=8pt]
        \item This paper consists of \textbf{\totalnumpages} printed pages, including this cover page.
        \item Do \textbf{NOT} turn over this page until instructed to do so.
        \item You have \textbf{2 hours} to attempt all questions in this paper.
        \item At the end of the paper, submit this booklet together with your answer script.
        \item Your answer script should clearly indicate your name, school, and team.
        \item It is your responsibility to ensure that your answer script has been submitted.
        \item The marks for each question are given in brackets in the right margin, like such: \textbf{[2]}.
        \item The \textbf{alphabetical} parts (i) and (l) have been intentionally skipped, to avoid confusion with the Roman numeral (i).
    \end{enumerate}
}

%%%%% ASTROCHALLENGE INSTRUCTIONS: DAQ %%%%%
\providerobustcmd*{\ac@daqinst}{
    In this part of \astrochallenge{}, you will work with a moderately large (approx. \num{4000} points) data set. You will process this data set, analyse it, observe trends, and draw conclusions. \textbf{There are no right or wrong answers}; you will be marked solely on the quality of your analysis, even if your statistical methods are incorrect.\\[8pt]
    We \textbf{strongly} recommend you use industry-standard tools like \texttt{Microsoft Excel}\texttrademark, \texttt{RStudio} or various \texttt{Python} libraries to process the data.\par
}

%%%%% ASTROCHALLENGE INSTRUCTIONS: OBS %%%%%
\providerobustcmd*{\ac@obsinst}{
    \begin{enumerate}[itemsep=8pt]
        \item This paper consists of \textbf{\totalnumpages} printed pages, including this cover page.
        \item Do \textlbl{not} turn over this page until instructed to do so.
        \item You have \textbf{1 hour and 30 minutes} to attempt all questions in this paper.
        \item At the end of the paper, submit this booklet together with your answer script.
        \item Your answer script should clearly indicate your name, school, and team.
        \item It is your responsibility to ensure that your answer script has been submitted.
    \end{enumerate}
}

%%%%% ASTROCHALLENGE INSTRUCTIONS %%%%%
\providerobustcmd*{\ac@instructions}{
    \ifbool{ismcq}{\ac@mcqinst}{
        \ifbool{isteam}{\ac@teaminst}{
            \ifbool{isdaq}{\ac@daqinst}{
                \ifbool{isobs}{\ac@obsinst}{}
            }
        }
    }
}

%%%%% ASTROCHALLENGE INSTRUCTION BOX %%%%%
\providerobustcmd*{\ac@instbox}{
    \vspace*{20pt}
    \fbox{
        \fbox{
            \parbox{0.8\textwidth}{
                \vspace*{5pt}
                \begin{center}
                    {\large{\textlbl{please read these instructions carefully.}}}
                \end{center}
                \vspace*{10pt}

                \ac@instructions

                \vspace*{5pt}
            }
        }
    }
}

%%%%% ASTROCHALLENGE COVER PAGE %%%%%
\renewrobustcmd{\maketitle}{
    \begin{coverpages}
        \begin{center}
            \includegraphics[width=0.8\linewidth]{../graphics/misc/logo.jpg}

            \@title

            \texttitle{\ac@category{} \ac@round{} Round}

            \ac@solntitle{}

            \acpaperdate{}

            \ac@instbox

            \vspace*{20pt}

            \@author
        \end{center}
    \end{coverpages}
}
