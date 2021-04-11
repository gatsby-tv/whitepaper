% gatsby.cls

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gatsby}[2021/03/21 Gatsby whitepaper class]

\LoadClass{article}

\RequirePackage[utf8]{inputenc}
\RequirePackage[margin=1.25in]{geometry}
\RequirePackage{fontspec}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{parskip}
\RequirePackage{afterpage}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{standalone}
\RequirePackage{graphicx}
\RequirePackage{pifont}
\RequirePackage{tikz}
\RequirePackage{multicol}
\RequirePackage{soul}
\RequirePackage{lipsum}

\usetikzlibrary{calc,arrows,decorations.markings,positioning}

\tikzset{pointer/.style={
  line cap=round,
  line width=3pt,
  shorten >=2mm,
  decoration={markings,mark=at position 0.99 with {\arrow[scale=2,>=stealth]{>}}},
  postaction={decorate}}}

\newif\if@presentation

\DeclareOption{presentation}{\@presentationtrue}
\DeclareOption{paper}{\@presentationfalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{paper}
\ProcessOptions\relax

\if@presentation\geometry{paperwidth=14.7in,paperheight=8.27in}\fi
\if@presentation\pagestyle{empty}\fi
\if@presentation\parskip=1cm\fi
\if@presentation\renewcommand{\thefootnote}{\fnsymbol{footnote}}\fi

\hypersetup{
  colorlinks=true,
  linkcolor=RoyalBlue,
  urlcolor=RoyalBlue,
  citecolor=RoyalBlue,
}

\graphicspath{{../png/}}

\definecolor{Gold}{HTML}{B29B5C}
\definecolor{LightGold}{rgb}{0.83, 0.69, 0.22}
\definecolor{Silver}{HTML}{B9B9B9}
\definecolor{DarkestGrey}{HTML}{141414}
\definecolor{DarkerGrey}{HTML}{1a1a1a}
\definecolor{DarkGrey}{HTML}{202020}
\definecolor{FontBody}{gray}{.1}
\definecolor{FontInverted}{gray}{.9}

\setmainfont[
  Path = ../fonts/,
  Extension = .ttf,
  UprightFont = *-Regular,
  ItalicFont = *-Italic,
  BoldFont = *-Bold
]{Montserrat}[
  FontFace={ul}{n}{Font=*-Thin},
  FontFace={el}{n}{Font=*-ExtraLight},
  FontFace={l}{n}{Font=*-Light},
  FontFace={sb}{n}{Font=*-SemiBold},
  FontFace={eb}{n}{Font=*-ExtraBold},
  FontFace={xb}{n}{Font=*-Black},
]

\DeclareRobustCommand{\HUGE}{\fontsize{42pt}{42pt}\selectfont}
\DeclareRobustCommand{\mega}{\fontsize{64pt}{64pt}\selectfont}
\DeclareRobustCommand{\Mega}{\fontsize{72pt}{72pt}\selectfont}
\DeclareRobustCommand{\MEGA}{\fontsize{96pt}{96pt}\selectfont}
\DeclareRobustCommand{\ulseries}{\fontseries{ul}\selectfont}
\DeclareRobustCommand{\elseries}{\fontseries{el}\selectfont}
\DeclareRobustCommand{\lseries}{\fontseries{l}\selectfont}
\DeclareRobustCommand{\sbseries}{\fontseries{sb}\selectfont}
\DeclareRobustCommand{\ebseries}{\fontseries{eb}\selectfont}
\DeclareRobustCommand{\xbseries}{\fontseries{xb}\selectfont}

\setuldepth{y}

\renewcommand{\thesubsection}{\Alph{subsection}}

\titleformat{\section}{\sbseries\if@presentation\HUGE\else\huge\fi}{}{0pt}{}
\titleformat{\subsection}{\scshape\LARGE}{\unless\if@presentation\thesubsection.\fi}{0.5ex}{}
\titleformat{\subsubsection}{\sbseries\large}{}{0pt}{}

\newcommand{\svg}[2]{\def\svgwidth{#1}\scalebox{1}{\input{#2.pdf_tex}}}
\newcommand{\png}[2]{\includegraphics[width=#1]{#2}}

\newcommand{\comment}[1]{}
\newcommand{\notopskip}{\null\vspace*{-\headsep}\vspace*{-\topskip}}
\newcommand{\thispagecolor}[1]{\pagecolor{#1}\afterpage{\nopagecolor}}
\newcommand{\pageimage}[3]{
  \tikz[remember picture,overlay]
  \node[#3,inner sep=0pt,outer sep=0pt] at (current page.#2)
  {\png{\paperwidth}{#1}};
}

\newcommand{\textblock}[2]{
  \begin{minipage}[t]{#1}
    \centering
    #2
  \end{minipage}
}

\newenvironment{tikzfigure}[1][]
{
  \begin{figure}[hbt!]
    \LARGE
    \begin{tikzpicture}[#1]
}
{
    \end{tikzpicture}
  \end{figure}
}

\newenvironment{tikzoverlay}[1][]
{
  \begin{figure}[hbt!]
    \LARGE
    \begin{tikzpicture}[remember picture,overlay,#1]
}
{
    \end{tikzpicture}
  \end{figure}
}

\renewenvironment{vcenter}{\vspace*{\fill}}{\vspace*{\fill}}
