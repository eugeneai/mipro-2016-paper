%%% jctart15a.cls
%%%   Article document class of the Journal of Computational Technologies
%%%   for LaTeX2e
%%%   (c) Institute of Computational Technologies SB RAS

%%\if@compatibility\input jctart.sty\endinput\fi
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{jctart15a}[2015/02/06 v0.a]

\newif\ifJCTenglish
\JCTenglishfalse
\newif\ifJCTemark
\JCTemarkfalse

\DeclareOption{JCTenglish}{\JCTenglishtrue}
\DeclareOption{english}{\JCTenglishtrue}
\DeclareOption{12pt}{\relax}
\DeclareOption{twoside}{\relax}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% style for vectors
\DeclareOption{vecphys}{\def\vec@style{phys}}
\DeclareOption{vecarrow}{\def\vec@style{arrow}}

\ProcessOptions
\PassOptionsToClass{12pt,twoside}{article}

\LoadClass{article}

%%\AtBeginDocument{\ifx\inputencoding\undefined\RequirePackage{inputenc}\fi}

\RequirePackage{mathtext}
% Next strings will cause the option clash problems. Needs correction!
\RequirePackage[T2A]{fontenc}
\RequirePackage[cp1251]{inputenc}
\RequirePackage[english,russian]{babel}

\addto\captionsenglish{%
  \def\figurename{Fig.}%
  \def\tablename{T\ a\ b\ l\ e\ }%
  }

\addto\captionsrussian{%
  \def\figurename{\cyr\CYRR\cyri\cyrs.}
  \def\tablename{\cyr\CYRT\ \cyra\ \cyrb\ \cyrl\ \cyri\ \cyrc\ \cyra\ }
  \def\contentsname{\cyr\CYRS\cyro\cyrd\cyre\cyrr\cyrzh\cyra\cyrn\cyri\cyre}
  \def\refname{\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk\ \cyrl\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyrery\ /\ References}
   }


%%% Being in onecolumn we typeset abstract without the title in boldface
\renewcommand\abstract{\if@twocolumn
\section*{\abstractname}
\else \small
\quotation
\fi}

\ifx\JCTnumber\undefined %% The file under processing is an old style file and PROBABLY
                         %% contains only one article
\let\realMaketitle\maketitle
\def\maketitle{
    \let\realNewpage\newpage
    \def\newpage{\relax}
    \realMaketitle
    \let\newpage\realNewpage
    \let\maketitle\realMaketitle
    \let\realNewpage\undefined
    \let\realMaketitle\undefined
}
\fi

\def\@maketitle{ %% Borrowed form the article style <14 Jan 1992>
 \newpage %% Think of it
  \ifx\JCTnumber\undefined\vbox to 0pt{}\vskip-\headsep\vskip-\headheight\vskip-10pt
 \else\vbox to 0pt{}\vskip-\headsep\vskip-\headheight\vskip-10pt\vbox to 1cm{\inputencoding{cp1251}\hskip-\parindent
    \ifJCTemark\bf Computational Technologies\hfill Vol \JCTvolume, No \JCTnumber, \JCTyear
    \else
     \bf {\cyr\CYRV\cyrery\cyrch\cyri\cyrs\cyrl\cyri\cyrt\cyre\cyrl\cyrsftsn\cyrn\cyrery\cyre\
         \cyrt\cyre\cyrh\cyrn\cyro\cyrl\cyro\cyrg\cyri\cyri}\hfill {\cyr\CYRT\cyro\cyrm} \JCTvolume, \No\JCTnumber, \JCTyear
    \fi
 }
 \fi
 \null            %% <--- Start article.sty
 \vskip 2em
%%06/02/15 \begin{center}%
   \begin{flushleft}
   \Large 
   \textbf{\hskip-\parindent\@title}
   \end{flushleft}
  %%\vskip .5em
  {%%%\large
   \lineskip .5em
   \hskip-\parindent\begin{flushleft}\@author
   \end{flushleft}\par}%
  \vskip 1em
  {
%%%\large
    \@date}%
%%06/02/15 \end{center}%
 \par
 \vskip 1.5em}   %% <--- End article.sty

\renewcommand\thesection {\arabic{section}}
\renewcommand\thesubsection {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection.\arabic{subsubsection}}
\renewcommand\theparagraph {\thesubsubsection.\arabic{paragraph}}
\renewcommand\thesubparagraph {\theparagraph.\arabic{subparagraph}}

\setlength{\textwidth}{165mm}
\setlength{\textheight}{240mm}
\topmargin=-10mm
\oddsidemargin=-2.5mm
\evensidemargin=-2.5mm

\def\JCTsetemark[#1]{\JCTemarktrue}
\def\JCTvolume(#1,#2,#3){\def\JCTvolume{#1}\def\JCTnumber{#2}\def\JCTyear{#3}\@ifnextchar [{\JCTsetemark}{}}
%\def\No{\char242~} %% CAUTION: Do not know how to do it better
\def\No{№} %% May be it's also not the best.

\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.\hspace{0.5em}}

\def\@begintheorem#1#2{\trivlist
   \item[\hskip \labelsep{\bfseries #1\ #2.}]\itshape}
% здесь нужно обработать случай \cite в #3
\def\@opargbegintheorem#1#2#3{\trivlist
      \item[\hskip \labelsep{\bfseries #1\ #2\ (#3).}]\itshape}
% copy of previous
%\def\@opargbegintheorem#1#2#3{\trivlist
%      \item[\hskip \labelsep{\bfseries #1\ #2\ (#3).}]\itshape}

% В \@caption внесен условный оператор, выделяющий случай "пустой" подписи
% здесь же нужно добавлять обработку варианта table
\long\def\@caption#1[#2]#3{%
  \par
  \addcontentsline{\csname ext@#1\endcsname}{#1}%
    {\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
	\def\tmpa{#3}
	\def\tmpb{}
    \ifx\tmpa\tmpb\@makecaptiona{\csname fnum@#1\endcsname}
	\else\@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\fi
	\par
  \endgroup}

% \@makecaptiona - отрисовка подписи для "пустого" случая
\long\def\@makecaptiona#1{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\small #1}%
  \ifdim \wd\@tempboxa >\hsize
    \small #1\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\small #1. #2}%
  \ifdim \wd\@tempboxa >\hsize
    \small #1. #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\let\text\mbox

%====================================================================

\DeclareRobustCommand\cited{%
  \@ifnextchar [{\@tempswatrue\@citedx}{\@tempswafalse\@citedx[]}}
\def\@citedx[#1]#2{%
  \let\@citea\@empty
  \@cited{\@for\@citeb:=#2\do
    {\@citea\def\@citea{\,--\penalty\@m\,}%
     \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
     \@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
       \G@refundefinedtrue
       \@latex@warning
         {Citation `\@citeb' on page \thepage \space undefined}}%
       {\hbox{\csname b@\@citeb\endcsname}}}}{#1}}
\def\@cited#1#2{[{#1\if@tempswa\,--\,#2\fi}]}

\providecommand{\JCTtablecaption}[2][\thetable]{
\refstepcounter{table}\hspace*{#2}\tablename\ #1\\[-5mm]
\protected@edef\@currentlabel{#1}
\setcounter{table}{#1}
}

% redefines the \vec accent to a bold character - if desired
\def\fig@type{arrow}% temporarily abused
\ifx\vec@style\fig@type\else
\@ifundefined{vec@style}{%
 \def\vec#1{\ensuremath{\mathchoice
                     {\mbox{\boldmath$\displaystyle\mathbf{#1}$}}
                     {\mbox{\boldmath$\textstyle\mathbf{#1}$}}
                     {\mbox{\boldmath$\scriptstyle\mathbf{#1}$}}
                     {\mbox{\boldmath$\scriptscriptstyle\mathbf{#1}$}}}}%
}
{\def\vec#1{\ensuremath{\mathchoice
                     {\mbox{\boldmath$\displaystyle#1$}}
                     {\mbox{\boldmath$\textstyle#1$}}
                     {\mbox{\boldmath$\scriptstyle#1$}}
                     {\mbox{\boldmath$\scriptscriptstyle#1$}}}}%
}
\fi

\providecommand{\en}{\selectlanguage{english}}
\providecommand{\ru}{\selectlanguage{russian}}

% Possibly it will be good to set \en or \ru at begin of document depending on
% <english> option

%%%% BEGIN - new headings style

\def\JCTheadodd{\@empty}
\def\JCTheadeven{\@empty}

\renewcommand{\markboth}[2]{
 \def\JCTheadodd{#1}
 \def\JCTheadeven{#2}
}

\def\@evenhead{\noindent
\centering\underline{
\makebox[0.98\textwidth]
{\rule[-3pt]{0pt}{14pt}\thepage\hfill{\slshape\JCTheadodd}}
}
}

\def\@oddhead{\noindent
\centering\underline{
\makebox[0.98\textwidth]{\rule[-3pt]{0pt}{14pt}{\slshape\JCTheadeven}
\hfill\thepage}
}
}

\def\@oddfoot{\@empty}

\def\@evenfoot{\@empty}

%%%% END - new headings style


%%%% BEGIN - section fonts downsizing

\renewcommand\section{\@startsection{section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries\itshape}}

%%%% END - section fonts downsizing

%\itemsep=0pt
%\partopsep=0pt
%\topsep=0pt
%\parsep=0pt

\renewenvironment{thebibliography}[1]
     {\section*{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
\small
            \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}
%%          \rule{\itemsep}{30pt}
            \setlength{\itemsep}{0pt}
            \small
            }%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}


\endinput
