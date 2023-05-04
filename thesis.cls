%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLASS - THESIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2023/05/22 Thesis]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[12pt]{report}

%-------------------------------------------------
% MISCELLANEOUS
%-------------------------------------------------
% SETSPACE: line spacing
\RequirePackage{setspace} % set line spacing in text body without affecting footnotes
    \setstretch{1.4}

% GEOMETRY: page layout
\RequirePackage[a4paper, margin=1in, headheight=\baselineskip, headsep=.5\baselineskip, footskip=\dimexpr .5in + .5\fontcharht\font`0 \relax]{geometry}

% TITLING: reusable document metadata for custom title page
\RequirePackage{titling}

% CALC: calculations on command arguments
\RequirePackage{calc}

% XCOLOR: extended colour library
\RequirePackage[dvipsnames]{xcolor} % import a set of default colors to be used in the document

%-------------------------------------------------
% GENERAL TYPOGRAPHY
%-------------------------------------------------
% MICROTYPE: micro-typographic adjustments to avoid under- & overfull \hbox
\RequirePackage{microtype}

% FANCYHDR: nicer headers & footers
\RequirePackage{fancyhdr} % customise header and footer
    \pagestyle{fancy} % set default page-style to fancy
    \fancyhf{} % empty header & footer
    \renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter:\ #1}{}} % redefine leftmark to show chapter
    \fancyhead[L]{\scshape\leftmark} % place leftmark in left header
    \fancyhead[R]{\thepage} % place page number in right header
    \renewcommand{\headrulewidth}{0.5pt} % set width of header-rule
    \fancypagestyle{plain}{ % set up plain page-style for first page of each chapter
        \fancyhf{} % empty header & footer
        \renewcommand{\headrulewidth}{0pt} % omit header-rule
        \fancyfoot[C]{\thepage} % place page number in center footer
        }
        
% TITLESEC: title format
\RequirePackage[nostruts]{titlesec} % align top of chapter title with margin
    % REMOVE WHITE SPACE BEFORE CHAPTER HEADING
    \makeatletter
    \def\ttl@mkchap@i#1#2#3#4#5#6#7{%
      \ttl@assign\@tempskipa#3\relax\beforetitleunit
      %\vspace*{\@tempskipa}% NEW
      \global\@afterindenttrue
      \ifcase#5 \global\@afterindentfalse\fi
      \ttl@assign\@tempskipb#4\relax\aftertitleunit
      \ttl@topmode{\@tempskipb}{%
        \ttl@select{#6}{#1}{#2}{#7}}%
      \ttl@finmarks  % Outside the box!
      \@ifundefined{ttlp@#6}{}{\ttlp@write{#6}}}
    \makeatother
    
    % CHAPTER
    \titleformat{\chapter}[block]{\centering\LARGE\scshape}{\thechapter}{1ex}{}[]
    \titlespacing*{\chapter}{0pt}{0pt}{.25\baselineskip}

    % SECTION
    \titleformat{\section}[hang]{\Large\bfseries}{\thesection}{1ex}{}[]
    \titlespacing*{\section}{0pt}{.5\baselineskip}{0pt}

    % SUBSECTION
    \titleformat{\subsection}[hang]{\large\bfseries}{\thesubsection}{1ex}{}[]
    \titlespacing*{\subsection}{0pt}{.5\baselineskip}{0pt}

    % SUBSUBSECTION
    \titleformat{\subsubsection}[hang]{\bfseries}{\thesubsubsection}{}{}[]
    \titlespacing*{\subsubsection}{0pt}{.5\baselineskip}{0pt}

    % PARAGRAPH
    \titleformat{\paragraph}[runin]{\bfseries}{\theparagraph}{}{}[.~~]
    \titlespacing*{\paragraph}{0pt}{.5\baselineskip}{0pt}

    % SUBPARAGRAPH
    \titleformat{\subparagraph}[runin]{\bfseries}{\thesubparagraph}{}{}[.~~]
    \titlespacing*{\subparagraph}{\parindent}{.5\baselineskip}{0pt}

% ENUMITEM: enumerate & itemize layout
\RequirePackage{enumitem}
    \setlist{
        leftmargin=.5in, rightmargin=\leftmargin, % set margins
        itemsep=.25\baselineskip, topsep=\itemsep, parsep=0pt, partopsep=0pt % set vertical spacing
        }
    \setlist[itemize, 1]{label=$\vcenter{\hbox{\scriptsize$\bullet$}}$} % change bullet point symbol

% LISTINGS: source code listings
\RequirePackage{listings}
    \input{listings-python.prf} % load predefined style for Python: python-idle-code
    \lstdefinestyle{python} % define single-spaced python style based on python-idle-code
        {style=python-idle-code, basicstyle=\normalsize\ttfamily\linespread{1}\selectfont} % append \linespread{1}\selectfont to basicstyle found in python-idle-code
    \lstset{
        aboveskip=\fpeval{-1 / \baselinestretch * \baselineskip}pt + \baselineskip, belowskip=0pt, % adjust spacing above & below listing
        xleftmargin=.5in, xrightmargin=.5in, breaklines=true, % confine listing to margins
        showstringspaces=false % disable space encoding (_) in strings
        }

% FOOTMISC: footnote layout
\RequirePackage[bottom]{footmisc} % fix footnotes to bottom of page
    \setlength{\footnotesep}{1.4\footnotesep} % adjust spacing between footnotes

%-------------------------------------------------
% LISTS & REGISTERS (EXCL. ABBREVIATIONS)
%-------------------------------------------------
% TOCLOFT: toc, lof & lot layout
\RequirePackage[titles]{tocloft} % use titlesec chapter format on tocloft pages
    \renewcommand{\cftdotsep}{2} % set dot spacing

    % ADJUST FONT-STYLES IN TOC
    \renewcommand{\cftchapfont}{\scshape}
    \renewcommand{\cftchappagefont}{}
    \renewcommand{\cftsubsecfont}{\itshape}
    
    % REMOVE GROUP-SKIP FROM TOC, LOT & LOF
    \setlength{\cftbeforechapskip}{0pt}
    \setlength{\cftbeforetabskip}{0pt}
    \setlength{\cftbeforefigskip}{0pt}
    
    % REMOVE INDENTATION FROM LOT & LOF
    \setlength{\cfttabindent}{0pt}
    \setlength{\cftfigindent}{0pt}

    % ALIGN NUMERATION-INDENT OF LOT & LOF WITH TOC
    \setlength{\cfttabnumwidth}{\cftchapnumwidth}
    \setlength{\cftfignumwidth}{\cftchapnumwidth}
    
    % REMOVE VSPACE FROM LOT & LOF
    \newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
    \addtocontents{lot}{\protect\noaddvspace}
    \addtocontents{lof}{\protect\noaddvspace}

% TOCBIBIND: include lists in toc
\RequirePackage[nottoc]{tocbibind} % exclude toc itself

% BIBLATEX: citations & bibliography
\RequirePackage[style=apa]{biblatex} % set apa citation
    \addbibresource{Resources/references.bib} % import references from Zotero

    % FORMATTING
    \setlength\bibitemsep{.5\baselineskip} % space bibliography entries
    \setlength{\bibhang}{\parindent} % align bibliography indent with paragraph indent
    \renewcommand*\mkbibnamefamily[1]{\textsc{#1}} % can be set directly above bibliography to prevent in-text small caps

    % ALLOW BIBLIOGRPAHY URLS TO BREAK ANYWHERE
    \setcounter{biburlnumpenalty}{9999}
    \setcounter{biburlucpenalty}{9999}
    \setcounter{biburllcpenalty}{9999}

%-------------------------------------------------
% FLOATS
%-------------------------------------------------
% SWITCH FROM CHAPTER-BASED NUMBERING TO CONTINUOUS NUMBERING
\counterwithout{table}{chapter}
\counterwithout{figure}{chapter}

% FLOATROW: float layout
\RequirePackage{floatrow}
    % \abovecaptionskip WITHOUT FLOATROW ADDS ADDITIONAL VSPACE
    \floatsetup{style=plaintop, captionskip=.25\baselineskip, footskip=.25\baselineskip}

% ETOOLBOX: code injection
\RequirePackage{etoolbox}
    % ALTERNATIVE TO \DeclareFloatVCode{halving_float_to_baseline_distance}{\vspace{-.5\baselineskip}} VIA postcode OPTION THAT ALLOWS FLOAT OBJECTS TO BE ALIGNED AT THE TOP
    \AfterEndEnvironment{table}{\vspace{-.5\baselineskip}} % remove skip after tables
    \AfterEndEnvironment{figure}{\vspace{-.5\baselineskip}} % remove skip after figures
    \setlength{\intextsep}{.5\baselineskip} % set equal skips above & below floats

% CSVSIMPLE: tables from csv files
\RequirePackage{csvsimple}

% BOOKTABS: nicer tables
\RequirePackage{booktabs}

% SIUNITX: better number alignment in tables
\RequirePackage{siunitx}
    \sisetup{group-minimum-digits = 4} % specify minimum digits before three-digit grouping

% GRAPHICX: graphics import
\RequirePackage{graphicx}
    \graphicspath{{Resources}} % set default graphics import path

% CAPTION: captions
\RequirePackage{caption}
    \captionsetup{labelfont=bf, labelsep=period, textformat=period} % set caption formatting
    \captionsetup[floatfoot]{font={singlespacing, footnotesize}, textformat=simple} % set floatfoot formatting

%-------------------------------------------------
% HYPERREF
%-------------------------------------------------
% HYPERREF: embedded links
\RequirePackage[pdfusetitle]{hyperref} % use document title & author as pdf-metadata
    \hypersetup{
        pdfcreator={}, % ommit pdf-creator
        pdfproducer={}, % omit pdf-producer
        linktoc=all, % make both text and page clickable tin toc, lot & lot
        colorlinks=true, % highlight links thorugh text colour
        allcolors={}, % set default colour to text colour
        citecolor=MidnightBlue, % set citation-link colour
        }

    % CAPITALISE AUTOREF COUNTER LABELS TO MATCH TABLE & FIGURE
    \renewcommand{\chapterautorefname}{Chapter}
    \renewcommand{\sectionautorefname}{Section}
    \renewcommand{\subsectionautorefname}{Subsection}

%-------------------------------------------------
% POST-HYPERREF
%-------------------------------------------------
% GLOSSARIES-EXTRA: abbreviations
\RequirePackage[abbreviations, automake, nonumberlist, stylemods=longextra]{glossaries-extra}
    \renewcommand{\abbreviationsname}{List of Abbreviations} % was "Abbreviations" before
    \setglossarystyle{long-name-desc} % booktabs style from longextra
    \makeglossaries % creates a hidden gls file, if omitted the glossry is no longer updated
    \loadglsentries{Resources/abbreviations.tex}

    % ALTERNATIVELY THE ALTTREE STYLE CAN BE USED:
    % \setglossarystyle{alttree}
    % \glsfindwidesttoplevelname
    % WITH SOME MINOR ADJUSTMENTS:
    % \setglossarypreamble[abbreviations]{\setlength{\parskip}{-0.5\baselineskip}} % reduce line-spacing for abbreviations
    % \setglossarypreamble{\setlength{\parskip}{-0.5\baselineskip}} % reduce line-spacing for glossary
    % \renewcommand\glstreenamefmt[1]{#1} % remove bold font from "names"-column
    % \renewcommand{\glossarysection}[2][]{} % omit glossary titles

    % FURTHER STYLES CAN BE FOUND AT https://www.dickimaw-books.com/gallery/glossaries-styles/