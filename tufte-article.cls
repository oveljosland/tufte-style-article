\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tufte-article}[]

% This is the 'tufte-article' LaTeX class,
% inherited from the 'article' class and inspired
% by the work of Edward Tufte.

% For information about usage, see README.md

% This class is hosted and maintained at:
% https://github.com/oveljosland/tufte-style-article



% --- options --- %

% makes all paragraphs left-aligned
\DeclareOption{raggedright}{
	\AtBeginDocument{
		\setlength{\RaggedRightParindent}{1em}
		\RaggedRight
	}
}

% changes paragraph indents for vertical skips
\DeclareOption{parskip}{
	\AtBeginDocument{\usepackage{parskip}}
	\setlength{\parskip}{\baselineskip}
}

% disables section titles on page headers
\DeclareOption{noheaders}{
	\renewcommand{\leftmark}{}
	\renewcommand{\rightmark}{}
}

% removes header numbering, still included in toc
\DeclareOption{casual}{
	\AtBeginDocument{\setcounter{secnumdepth}{0}}
}
\newif\if@sans\@sansfalse
\DeclareOption{sans}{
	\@sanstrue
	\renewcommand{\familydefault}{\sfdefault}
}
\newif\if@colorful\@colorfulfalse
\newif\if@black\@blackfalse
\DeclareOption{colorful}{
	\@colorfultrue
	\@blackfalse
}
\DeclareOption{black}{
	\@blacktrue
	\@colorfulfalse
}
\newif\if@nomargins\@nomarginsfalse
\DeclareOption{notufte}{
	\@nomarginstrue
	\AtBeginDocument{
		\captionsetup{width = .7\textwidth}
		\renewcommand{\sidecaption}[2][]{
			\caption[#1]{#2}
		}
		\renewenvironment{marginfigure}[1][]{
			\begin{figure}[!htb]
		}{
			\end{figure}
		}
		\renewenvironment{figure*}[1][]{
			\begin{figure}[!htb]
		}{
			\end{figure}
		}
		\renewenvironment{margintable}[1][]{
			\begin{table}[!htb]
		}{
			\end{table}
		}		\renewenvironment{table*}[1][]{
			\begin{table}[!htb]
		}{
			\end{table}
		}
		\renewcommand{\textfig}[4][]{%
			\begin{figure}[ht!]
				\noindent\includegraphics[width=#1\textwidth]{#2}%
				\caption{#3}%
				\label{#4}%
			\end{figure}
		}
		\renewcommand{\marginfig}[3]{%
			\begin{figure}[ht!]
				\noindent\includegraphics[width=.5\textwidth]{#1}%
				\caption{#2}%
				\label{#3}%
			\end{figure}
		}
		\renewcommand{\widefig}[4][]{%
			\begin{figure}[ht!]
				\noindent\includegraphics[width=#1\textwidth]{#2}%
				\caption{#3}%
				\label{#4}%
			\end{figure}
		}
		\renewcommand{\plainfig}[4][]{%
			\begin{figure}[ht!]
				\noindent\includegraphics[width=#1\textwidth]{#2}%
				\caption{#3}%
				\label{#4}%
			\end{figure}
		}
		\renewcommand{\plainwidefig}[4][]{%
			\begin{figure}[ht!]
				\noindent\includegraphics[width=#1\textwidth]{#2}%
				\caption{#3}%
				\label{#4}%
			\end{figure}
		}
		\renewcommand{\sidenote}[1]{
			\footnote{#1}
		}
		\renewcommand{\sidetext}[1]{
			\footnote{#1}
		}
	}
}

\ExecuteOptions{black}
\ProcessOptions\relax
\LoadClassWithOptions{article}



% --- package definition --- %
\RequirePackage{geometry}         % page geometry
\RequirePackage{emptypage}        % check if page is empty
\RequirePackage{fullwidth}        % for wide environments
\RequirePackage{marginnote}
\RequirePackage{sidenotes}        % for margins
\RequirePackage[
	hypcap=false                  % hypcap=true gives an error
]{caption}                        % for caption formatting
\RequirePackage[T1]{fontenc}      % font encoding
\RequirePackage[osf]{libertinus}  % main font
\RequirePackage{libertinust1math}
\RequirePackage{gillius}          % sans font
\if@sans
	\RequirePackage[              % font for full sans document
		osf,
		default
	]{sourcesanspro}
\fi
\RequirePackage[
	defaultmono,
	scale=.8
]{droidsansmono}          % monospaced font
\RequirePackage{ragged2e} % for better raggedright
\RequirePackage{titlesec} % header customisation
\RequirePackage{titletoc} % toc customisation
\RequirePackage{fancyhdr} % page header customisation
\RequirePackage{graphicx} % for including images
\RequirePackage[
	protrusion=true,
	expansion=true,
	final,
	tracking,
]{microtype}                                % fine-tuning in text
\RequirePackage{amsfonts}                   % math fonts
\RequirePackage{amsmath}                    % math
\RequirePackage{mathtools}                  % amsmath extension
\RequirePackage{physics}                    % handy macros for physics
\RequirePackage[table]{xcolor}              % colours
\RequirePackage[framemethod=TikZ]{mdframed} % for custom code boxes
\RequirePackage{tabularx}                   % adaptive columns on tables
\RequirePackage{booktabs}                   % for top, bottom and midrule
\RequirePackage{enumitem}                   % better looking lists
\RequirePackage[hidelinks]{hyperref}        % automatic references in pdf
\RequirePackage{etoolbox}
\RequirePackage[strict]{changepage}         % needed by sidenotes
\RequirePackage{placeins}                   % for floatbarrier
\RequirePackage{listings}                   % code listings
\RequirePackage[titles]{tocloft}
\RequirePackage[
	autocite = superscript,
	backend = biber,
	bibstyle = ieee,
	% citecolor = NiceBlue,
	style = numeric-comp,
	sorting=none,
	texencoding=ascii,
]{biblatex}
\RequirePackage{setspace}



% --- colour definition --- %
\definecolor{NiceRed}{HTML}{980326}
\definecolor{NiceBlue}{HTML}{025472}
\definecolor{TooRed}{HTML}{cc0000}
\if@colorful
	\hypersetup{
		colorlinks = true,
		linkcolor = NiceBlue,
		% anchorcolor = NiceBlue,
		citecolor = .,
		urlcolor = NiceBlue,
	}
	\renewcommand\thefootnote{\color{NiceBlue}\arabic{footnote}}
	\renewcommand\thesidenote{\color{NiceBlue}\arabic{sidenote}}
\else
\fi
\if@black
	\definecolor{NiceRed}{HTML}{000000}
	\definecolor{NiceBlue}{HTML}{000000}
\else
\fi
\newcommand\red[1]{\textcolor{NiceRed}{#1}}



% --- geometry definition --- %
\newgeometry{
	tmargin = 80pt,
	bmargin = 80pt,
	lmargin = 100pt,
	rmargin = 100pt,
}
\savegeometry{titlepage}
\newgeometry{
	textwidth = .56\paperwidth,
	textheight = .8\paperheight,
	lmargin = 70pt,
	marginparwidth = .38\textwidth,
	marginparsep = 28pt,
	headheight = 16pt,
	tmargin = 80pt,
	% showframe,
}
\savegeometry{regular}
\newgeometry{
	tmargin = 80pt,
	bmargin = 80pt,
	lmargin = 70pt,
	rmargin = 70pt,
}
\savegeometry{evenmargins}

\if@nomargins
	\newgeometry{
		textheight = .8\paperheight,
		lmargin = 80pt,
		rmargin = 80pt,
		marginparwidth = 50pt,
		marginparsep = 10pt,
		headheight = 15pt,
		tmargin = 100pt,
		%showframe,
	}
	\savegeometry{regular}
\fi



% --- margins --- %
% formatting sidenote text
\makeatletter
\RenewDocumentCommand\sidenotetext{ o o +m }{%
    \IfNoValueOrEmptyTF{#1}{%
        \@sidenotes@placemarginal{#2}{\setstretch{1.0}\noindent\footnotesize\RaggedRight{\thesidenote{}}~~ #3}%
        \refstepcounter{sidenote}%
    }{%
        \@sidenotes@placemarginal{#2}{\textsuperscript{#1}~#3}%
    }%
}
\makeatother

\newcommand{\sidetext}[1]
{\marginpar{\setstretch{1.0}\RaggedRight\footnotesize\noindent #1 \vskip 4pt}}

\newenvironment{wide}{
\begin{fullwidth}[outermargin=-\marginparwidth-\marginparsep, width=\linewidth+\marginparwidth+\marginparsep]
}%
{
\end{fullwidth}
}



% --- page headers --- %
\loadgeometry{evenmargins}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[LO]{
	\footnotesize\textls{\MakeUppercase{\sffamily\rightmark}} \hfill \normalfont\normalsize\thepage
}
\fancyhead[LE]{
	\normalfont\normalsize\thepage \hfill \footnotesize\textls{\MakeUppercase{\sffamily\leftmark}}
}

\fancypagestyle{plain}{
\fancyhf{}
\fancyhead[RO]{\thepage}
\fancyhead[LE]{\thepage}
}
\loadgeometry{regular}



% --- title headers --- %
\titleformat{\section}
	{\itshape\Large}
	{\normalfont\thesection}
	{1em}
	{\setstretch{0.9}\raggedright\itshape}
\titleformat{\subsection}
	{\itshape\large}
	{\raggedright\normalfont\thesubsection}
	{1em}
	{\setstretch{0.9}\itshape}
\titleformat{\subsubsection}
	{\itshape}
	{\normalfont\thesubsubsection}
	{1em}
	{\setstretch{0.9}\raggedright\itshape}

% new title without numbering
\newcommand{\littletitle}[1]{%
	\medskip%
	\noindent\textit{#1}%
	\\\smallskip%
}



% --- maketitle --- %
\makeatletter
\newcommand\@maketitlebis{%
	\hfill
	\setstretch{1.0}
	\begin{minipage}{0.9\textwidth}
		\vskip -40pt
		\let\footnote\thanks
		{\LARGE\raggedright \@title \par }
		\vskip 10pt
		{\Large \itshape \@author \hfill \normalsize \@date}
		\vskip 60pt~
	\end{minipage}
	\setstretch{1.12}
}
\renewcommand\maketitle{
	\@maketitlebis
	\thispagestyle{empty}
}
\makeatother



% --- figures --- %
% caption formatting
\DeclareCaptionLabelFormat{lc}{\MakeLowercase{#1}~#2}
\DeclareCaptionLabelSeparator{mysep}{.\quad}
\captionsetup{
	labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=on,
}
\DeclareCaptionStyle{sidecaption}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{marginfigure}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{widefigure}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{margintable}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{widetable}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}



% --- figure macros --- %
\AtBeginDocument{\usepackage[export]{adjustbox}}
% \newcommand{\textfig}[4][]{%
% 	\medskip%
% 	\marginpar{%
% 		\vskip 8pt%
% 		\captionof{figure}{#3}%
% 		\label{#4}%
% 	}\nopagebreak%
% 	\noindent\includegraphics[width=#1\textwidth, outer]{#2}%
% 	\medskip%
% }
\newcommand{\textfig}[4][]{%
	\FloatBarrier
	\begin{figure}[!htb]%
		\sidecaption{#3\label{#4}}%
		\includegraphics[width = #1\linewidth, outer]{#2}%
	\end{figure}%
}
\newcommand{\marginfig}[3]{%
	\FloatBarrier%
	\begin{marginfigure}%
		\includegraphics[width = \linewidth]{#1}%
		\caption{#2\label{#3}}%
	\end{marginfigure}%
}
\newcommand{\widefig}[4][]{%
	\FloatBarrier%
	\begin{figure*}[!htb]%
		\includegraphics[width=#1\linewidth, outer]{#2}%
		\sidecaption{#3\label{#4}}%
	\end{figure*}%
}
\newcommand{\plainfig}[4][]{%
	\FloatBarrier%
	\begin{figure}[!htb]%
		\includegraphics[width=#1\linewidth, left]{#2}%
		\caption{#3\label{#4}}%
	\end{figure}%
}
\newcommand{\plainwidefig}[4][]{%
	\FloatBarrier%
	\begin{figure*}[!htb]%
		\includegraphics[width=#1\linewidth, left]{#2}%
		\caption{#3\label{#4}}%
	\end{figure*}%
}



% --- table macros --- %
\newcolumntype{Y}{>{\centering\arraybackslash}X} % tabularx column type
\newenvironment{texttable}[2]{%
	\begingroup%
	\small%
	\marginpar{%
		\vskip 8pt%
		\captionof{table}{#1}%
		\label{#2}%
	}

	\noindent%
}
{
	\endgroup%
}



% --- table of contents --- %
\contentsmargin[1cm]{0cm}
\titlecontents{section}[0em]
	{\large\vspace{16pt}}
	{\makebox[-1em][r]{\bfseries\large\thecontentslabel}\large\hspace{1em}}
	{\large}
	{~~~~\textcolor{NiceBlue}{\contentspage}}[\vskip 4pt]
% \titlecontents{subsection}[0em]
% 	{\vspace{4pt}}
% 	{\normalfont\thecontentslabel\enspace\itshape}
% 	{\itshape}
% 	{\qquad\contentspage}[\vskip 0pt]
\titlecontents*{subsection}[0em]
	{}
	{{\thecontentslabel}~~}
	{}
	{~~\textcolor{NiceBlue}{\contentspage}}
	[\vskip 4pt]
% \titlecontents{subsubsection}[1em]
% 	{\vspace{0pt}}
% 	{\normalfont\thecontentslabel\enspace\itshape}
% 	{\itshape}
% 	{\quad\quad\contentspage}[\vskip 0pt]
% \pretocmd{\contentsname}{}{}{}

% begin tocloft (stolen from classicthesis)
\renewcommand{\cftfigpresnum}{\scshape\MakeTextLowercase}%
\renewcommand{\cftfigfont}{\normalfont}%
\renewcommand{\cftfigleader}{\hspace{2.5em}}%
\renewcommand{\cftfigafterpnum}{\cftparfillskip}%
\renewcommand{\cftfigpresnum}{\figurename~}%Fig.~}
\newlength{\figurelabelwidth}
\settowidth{\figurelabelwidth}{\cftfigpresnum~999}
\addtolength{\figurelabelwidth}{1em}
\cftsetindents{figure}{0em}{\figurelabelwidth}

% tables
\renewcommand{\cfttabfont}{\normalfont}%
\renewcommand{\cfttableader}{\hspace{2.5em}}%
\renewcommand{\cfttabafterpnum}{\cftparfillskip}%
\renewcommand{\cfttabpresnum}{\tablename~}%Tab.~}
\newlength{\tablelabelwidth}
\settowidth{\tablelabelwidth}{\cfttabpresnum~999}
\addtolength{\tablelabelwidth}{1em}
%\cftsetindents{table}{0em}{\tablelabelwidth}
\cftsetindents{table}{0em}{\figurelabelwidth}

% listings
\newcommand\listingsname{Listing}
\renewcommand\lstlistingname{Listing}
\renewcommand\lstlistlistingname{List of Listings}
\newlistof{listings}{lol}{\lstlistlistingname}%
\renewcommand{\cftlistingspresnum}{\scshape\MakeTextLowercase}%
\renewcommand{\cftlistingsfont}{\normalfont}%
\renewcommand{\cftlistingspresnum}{\lstlistingname~}%
\renewcommand{\cftlistingspagefont}{\normalfont}%
\renewcommand{\cftlistingsleader}{\hspace{1.5em}}%
\renewcommand{\cftlistingsafterpnum}{\cftparfillskip}%
\newlength{\listingslabelwidth}%
\settowidth{\listingslabelwidth}{\cftlistingspresnum~999}%
\addtolength{\listingslabelwidth}{2.5em}%
\cftsetindents{listings}{0em}{\figurelabelwidth}%
% \let\l@lstlisting\l@listings%
\let\lstlistoflistings\listoflistings%

% blue page numbers
\renewcommand{\cftsecpagefont}{\color{NiceBlue}}
\renewcommand{\cftsubsecpagefont}{\color{NiceBlue}}
\renewcommand{\cftsubsubsecpagefont}{\color{NiceBlue}}
\renewcommand{\cftfigpagefont}{\color{NiceBlue}}
\renewcommand{\cfttabpagefont}{\color{NiceBlue}}
\renewcommand{\cftlistingspagefont}{\color{NiceBlue}}
% end tocloft

% toc offset
% \let\oldtoc\tableofcontents
% \renewcommand{\tableofcontents}{
% \begin{quote}
% \oldtoc
% \end{quote}
% }

% toc depth
\AtBeginDocument{\setcounter{tocdepth}{1}}

% toc offset
\let\oldtoc\tableofcontents
\renewcommand{\tableofcontents}{%
	\bgroup
	\thispagestyle{plain}
	\setstretch{1.0}
	\oldtoc
	\egroup
}


% --- bibliography --- %
% black magic
\newbibmacro{sidecite}{%
	\textsuperscript{
		\printtext[labelnumberwidth]{%
		\printfield{labelnumber}}%
	}%
	\addspace
	\printnames{author}%
	\setunit{\printdelim{nametitledelim}}%
	\printfield[citetitle]{labeltitle}%
	\setunit{\addcomma\space}%
	\printfield{year}}

% \DeclareCiteCommand{\sidecitehelper}[\bibfootnotewrapper]
% 	{\usebibmacro{prenote}}
% 	{\usebibmacro{citeindex}%
% 	\usebibmacro{sidecite}}
% 	{\multicitedelim}
% 	{\usebibmacro{postnote}}
% \DeclareCiteCommand{\supercite}[\mkbibsuperscript]
% 	{\iffieldundef{prenote}
% 	   {}
% 	   {\BibliographyWarning{Ignoring prenote argument}}%
% 	 \iffieldundef{postnote}
% 	   {}
% 	   {\BibliographyWarning{Ignoring postnote argument}}%
% 	 \bibopenbracket}%
% 	{\usebibmacro{citeindex}%
% 	 \usebibmacro{cite}}
% 	{\supercitedelim}
% 	{\bibclosebracket}

% \ExplSyntaxOn
% \NewDocumentCommand\sidecite{D<>{}O{}om}{%
%   \iftoggle{blx@footnote}
%     {\cs_set_protected_nopar:Npn \__sct_wrapper:nn ##1 ##2 {\mkbibparens{##2}}}
%     {\cs_set_protected_nopar:Npn \__sct_wrapper:nn ##1 ##2 {\sidetext[][##1]{##2}}}
%     {\IfNoValueTF{#3}
% 		{\__sct_wrapper:nn{#1}{\sidecitehelper[#2]{#4}}}
% 		{\__sct_wrapper:nn{#1}{\sidecitehelper[#2][#3]{#4}}}
% 	}
% }
% \ExplSyntaxOff

\DeclareCiteCommand{\supercite}[\mkbibsuperscript]
  {\usebibmacro{cite:init}%
   \let\multicitedelim=\supercitedelim
   \iffieldundef{prenote}
     {}
     {\BibliographyWarning{Ignoring prenote argument}}%
   \iffieldundef{postnote}
     {}
     {\BibliographyWarning{Ignoring postnote argument}}%
  \bibopenbracket}%
  {\usebibmacro{citeindex}%
   \usebibmacro{cite:comp}}
  {}
  {\usebibmacro{cite:dump}\bibclosebracket}

\AtNextBibliography{\small}

\newcommand{\sidecite}[1]{\autocite{#1}\sidetext{\cite{#1} \citeauthor{#1}, \citetitle{#1}, \citeyear{#1}.}}



% --- tight lists --- %
\AtBeginDocument{
	\setlist{topsep=0pt, itemsep=0pt, noitemsep, leftmargin = 0pt}
}
% smaller bullets
\renewcommand{\labelitemi}{$\vcenter{\hbox{\scriptsize$\bullet$}}$}



% --- code --- %
% colours
\definecolor{bg}{rgb}{.95,.95,.95}
\definecolor{key}{HTML}{333399}
\definecolor{comment}{HTML}{6b6b99}
\definecolor{codegrey}{rgb}{0.4,0.4,0.4}
\definecolor{string}{HTML}{2b4f2b}

% boxes
\mdfdefinestyle{code_box}{%
    roundcorner= 2pt,
	backgroundcolor=white,
    linecolor = lightgray,
    linewidth = .5pt,
    topline = true,
    bottomline = true,
    leftline = true,
    rightline = true,
	innertopmargin=.2em,
	innerbottommargin=.2em,
}

% listing styles
\lstdefinestyle{unnumbered}{
    commentstyle=\color{comment},
    keywordstyle=\color{key},
    stringstyle=\color{string},
    basicstyle=\ttfamily\normalsize\lst@ifdisplaystyle\small\fi,
    breakatwhitespace=false,
    breaklines=true,
    keepspaces=true,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=4,
    framexleftmargin=30pt,
}

\lstdefinestyle{numbered}{
    commentstyle=\color{comment},
    keywordstyle=\color{key},
    stringstyle=\color{string},
    basicstyle=\ttfamily\normalsize\lst@ifdisplaystyle\small\fi,
    breakatwhitespace=false,
    breaklines=true,
    keepspaces=true,
    numbers=left,
    numberstyle = \color{codegrey}\footnotesize\ttfamily,
    numbersep=10pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=4,
    framexleftmargin=30pt,
    framextopmargin=100pt,
    framexbottommargin=30pt,
}

% code macros
\lstnewenvironment{codebox}[1]{%
	\mdframed[style = code_box, innerleftmargin=10pt]%
	\lstset{style=unnumbered, language=#1}
}
{
    \endmdframed
}
\lstnewenvironment{altcodebox}[1]{%
	\mdframed[style = code_box, innerleftmargin=10pt]%
	\lstset{style=unnumbered, language=#1}
}
{
    \endmdframed
}
\lstnewenvironment{codeboxnum}[1]{%
	\mdframed[style = code_box, innerleftmargin=25pt]%
	\lstset{style=numbered, language=#1}
}
{
    \endmdframed
}
\newcommand{\inlinecode}[1]{\lstinline[style=unnumbered, language=#1]}

% snippet environments
\lstnewenvironment{snippet}[3]{%
	\marginpar{~\vskip 10pt\captionof{listings}{#2}}
	\mdframed[style = code_box, innerleftmargin=10pt]%
	\lstset{style=unnumbered, language=#1}
}
{
    \endmdframed
}
\lstnewenvironment{snippetnum}[3]{%
	\marginpar{~\vskip 10pt\captionof{listings}{#2\label{#3}}}
	\mdframed[style = code_box, innerleftmargin=25pt]%
	\lstset{style=numbered, language=#1}
}
{
    \endmdframed
}

% --- in-text fine-tuning --- %
% widows and orphans
\clubpenalty = 10000
\widowpenalty = 10000
\displaywidowpenalty = 10000


% --- miscellaneous --- %

% for tight lists (pandoc like)
\providecommand{\tightlist}{%
	\setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}
}
\providecommand{\toight}{%
	\tightlist%
}

% minipages with margin notes
\usepackage{minipage-marginpar}

% no page break environment
\newenvironment{absolutelynopagebreak}
	{\par\nobreak\vfil\penalty0\vfilneg
	\vtop\bgroup}
	{\par\xdef\tpd{\the\prevdepth}\egroup
	\prevdepth=\tpd}



% --- mathematics & physics macros --- %
%\iffalse
% uncomment this \iffalse and the \fi at the end to disable (or delete)

	% i find it more pleasing
	\renewcommand{\phi}{\varphi}
	\renewcommand{\epsilon}{\varepsilon}
	\newcommand{\N}{\mathbb{N}} % shortcuts for usual number sets
	\newcommand{\Z}{\mathbb{Z}}
	\newcommand{\Q}{\mathbb{Q}}
	\newcommand{\R}{\mathbb{R}}
	\newcommand{\C}{\mathbb{C}}
	% powers of 10
	\newcommand{\ee}[1]{\cdot 10^{#1}}
	% new vect with overrightarrow style
	\newcommand{\vect}[1]{\:\overrightarrow{#1}}
%fi

% --- stretch --- %
\AtBeginDocument{%
	\setstretch{1.12}
}