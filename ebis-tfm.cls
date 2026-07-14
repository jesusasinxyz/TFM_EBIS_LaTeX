\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ebis-tfm}[2026/07/14 EBIS EUNEIZ TFM class]

\LoadClass[12pt,a4paper,twoside]{article}

% =========================================================
% TIPOGRAFÍA
% =========================================================

\RequirePackage{fontspec}

\defaultfontfeatures{Ligatures=TeX}
\setmainfont{Carlito}

\newfontfamily\TFMHeadingFont{Carlito}
\newfontfamily\TFMLightFont{Carlito}

% =========================================================
% PAQUETES
% =========================================================

\RequirePackage[spanish,es-nodecimaldot]{babel}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{ragged2e}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{enumitem}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{xcolor}
\RequirePackage{hyperref}
\RequirePackage{bookmark}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{etoolbox}
\RequirePackage{url}
\RequirePackage{xparse}

% =========================================================
% GEOMETRÍA
% =========================================================

\geometry{
  a4paper,
  inner=35mm,
  outer=25mm,
  top=25mm,
  bottom=25mm,
  headheight=15pt,
  headsep=10.5pt,
  footskip=17mm
}

% =========================================================
% HIPERVÍNCULOS
% =========================================================

\definecolor{TFMLinkBlue}{RGB}{0,82,204}

\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=TFMLinkBlue,
  pdfborder={0 0 0},
  bookmarksnumbered=true,
  bookmarksopen=true
}

% =========================================================
% TEXTO GENERAL
% =========================================================

\setlength{\parindent}{0pt}
\setlength{\parskip}{22pt}

\AtBeginDocument{%
  \normalfont
  \upshape
  \fontsize{12}{22}\selectfont
}

\hyphenpenalty=10000
\exhyphenpenalty=10000
\tolerance=1600
\emergencystretch=1.5em

\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

% =========================================================
% POSICIONAMIENTO ABSOLUTO
% =========================================================

\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\textblockorigin{0mm}{0mm}

% =========================================================
% ESTADO DE CABECERAS
% =========================================================

\newcommand{\TFMCurrentChapter}{}
\newcommand{\TFMCurrentSection}{}

% La cabecera interior mostrará:
% 2.4 Nombre de la sección
\renewcommand{\sectionmark}[1]{%
  \markright{\thesection\enspace #1}%
}

% =========================================================
% ESTILOS DE PÁGINA
% =========================================================

% ---------------------------------------------------------
% Páginas interiores de capítulos
% ---------------------------------------------------------

\fancypagestyle{TFMMain}{%
  \fancyhf{}

  % Sección actual en la parte superior derecha
  \fancyhead[R]{%
    \TFMLightFont
    \fontsize{12}{14.4}\selectfont
    \nouppercase{\rightmark}%
  }

  % Número de página siempre abajo a la derecha
  \fancyfoot[R]{%
    \TFMLightFont
    \fontsize{12}{14.4}\selectfont
    \thepage
  }

  % Línea horizontal bajo la cabecera
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}
}

% ---------------------------------------------------------
% Primera página de cada capítulo
% ---------------------------------------------------------

\fancypagestyle{TFMPlain}{%
  \fancyhf{}

  % Sin cabecera
  % Número abajo a la derecha
  \fancyfoot[R]{%
    \TFMLightFont
    \fontsize{12}{14.4}\selectfont
    \thepage
  }

  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

% LaTeX puede aplicar automáticamente "plain".
% Se redefine para que sea idéntico a TFMPlain.
\fancypagestyle{plain}{%
  \fancyhf{}

  \fancyfoot[R]{%
    \TFMLightFont
    \fontsize{12}{14.4}\selectfont
    \thepage
  }

  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

% ---------------------------------------------------------
% Resumen, agradecimientos e índices
% ---------------------------------------------------------

\fancypagestyle{TFMFront}{%
  \fancyhf{}

  \fancyfoot[R]{%
    \TFMLightFont
    \fontsize{12}{14.4}\selectfont
    \thepage
  }

  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

% Estilo general del documento
\pagestyle{TFMMain}

% =========================================================
% CONTADORES
% =========================================================

\newcounter{chapter}

\renewcommand{\thechapter}{\arabic{chapter}}
\renewcommand{\thesection}{\thechapter.\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}

\renewcommand{\theHsection}{%
  \thechapter.\arabic{section}%
}

\renewcommand{\theHsubsection}{%
  \thechapter.\arabic{section}.\arabic{subsection}%
}

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

% =========================================================
% MARCAS INTERNAS
% =========================================================

\newcommand{\TFMSetChapterMark}[1]{%
  \markboth%
    {Capítulo \thechapter\enspace #1}%
    {Capítulo \thechapter\enspace #1}%
}

\newcommand{\TFMSetSectionMark}[1]{%
  \markright{\thesection\enspace #1}%
}

% =========================================================
% CAPÍTULOS
% =========================================================

% El parámetro opcional se conserva por compatibilidad,
% pero la primera página siempre utiliza TFMPlain.

\newcommand{\TFMChapter}[2][odd]{%
  \refstepcounter{chapter}%
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%

  \addcontentsline{toc}{chapter}{%
    \protect\numberline{\thechapter}#2%
  }%

  \TFMSetChapterMark{#2}%

  \gdef\TFMCurrentChapter{#2}%
  \gdef\TFMCurrentSection{}%

  \pdfbookmark[0]{%
    Capítulo \thechapter. #2%
  }{chapter.\thechapter}%

  % Siempre elimina la cabecera en el inicio del capítulo
  \thispagestyle{TFMPlain}%

  \begingroup
  \setlength{\parskip}{0pt}%

  \vspace*{10mm}

  \begin{flushright}
    {%
      \TFMLightFont
      \fontsize{36}{43.3}\selectfont
      Capítulo \thechapter
      \par
    }

    \vspace{6mm}

    {%
      \TFMLightFont
      \fontsize{24}{28.9}\selectfont
      #2
      \par
    }
  \end{flushright}

  \vspace{4.1mm}

  \noindent
  \rule{\textwidth}{0.5pt}

  \vspace{8mm}

  \endgroup
}

% Versión compacta del capítulo
\newcommand{\TFMChapterCompact}[2][even]{%
  \refstepcounter{chapter}%
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%

  \addcontentsline{toc}{chapter}{%
    \protect\numberline{\thechapter}#2%
  }%

  \TFMSetChapterMark{#2}%

  \gdef\TFMCurrentChapter{#2}%
  \gdef\TFMCurrentSection{}%

  \pdfbookmark[0]{%
    Capítulo \thechapter. #2%
  }{chapter.\thechapter}%

  % También sin cabecera en la primera página
  \thispagestyle{TFMPlain}%

  \begingroup
  \setlength{\parskip}{0pt}%

  \vspace*{4mm}

  \begin{flushright}
    {%
      \TFMLightFont
      \fontsize{36}{43.3}\selectfont
      Capítulo \thechapter
      \par
    }

    \vspace{6mm}

    {%
      \TFMLightFont
      \fontsize{24}{28.9}\selectfont
      #2
      \par
    }
  \end{flushright}

  \vspace{4.1mm}

  \noindent
  \rule{\textwidth}{0.5pt}

  \vspace{8mm}

  \endgroup
}

% =========================================================
% SECCIONES Y SUBSECCIONES
% =========================================================

\titleformat{\section}[hang]
  {\TFMLightFont\fontsize{14}{17}\selectfont}
  {\thesection}
  {4mm}
  {}

\titlespacing*{\section}
  {0pt}
  {0pt}
  {-4mm}

\titleformat{\subsection}[hang]
  {\TFMLightFont\fontsize{12}{14.4}\selectfont}
  {\thesubsection}
  {3mm}
  {}

\titlespacing*{\subsection}
  {0pt}
  {0pt}
  {-2mm}

\NewDocumentCommand{\TFMSection}{m}{%
  \section{#1}%
  \gdef\TFMCurrentSection{\thesection\enspace #1}%
}

% =========================================================
% LISTAS
% =========================================================

\setlist[itemize]{
  label=-,
  leftmargin=36pt,
  labelwidth=4pt,
  labelsep=14pt,
  itemindent=0pt,
  topsep=0pt,
  partopsep=0pt,
  parsep=0pt,
  itemsep=0pt,
  before=\vspace{-22pt}
}

\newlist{tfmbullets}{itemize}{1}

\setlist[tfmbullets]{
  label=\raisebox{0.15ex}{%
    \fontsize{10}{10}\selectfont
    \textbullet
  },
  leftmargin=28pt,
  labelwidth=5pt,
  labelsep=13pt,
  topsep=0pt,
  partopsep=0pt,
  parsep=0pt,
  itemsep=0pt,
  before=\vspace{-22pt}
}

\setlist[enumerate]{
  leftmargin=28pt,
  labelsep=10pt,
  topsep=0pt,
  partopsep=0pt,
  parsep=0pt,
  itemsep=0pt,
  before=\vspace{-22pt}
}

% =========================================================
% ENCABEZADOS DEL FRONT MATTER
% =========================================================

\newcommand{\TFMFrontHeading}[1]{%
  \begingroup
  \setlength{\parskip}{0pt}%

  \vspace*{15mm}

  \hfill
  \begin{minipage}{71mm}
    \raggedleft

    {%
      \TFMLightFont
      \fontsize{16}{19.2}\selectfont
      #1
      \par
    }

    \vspace{2.4mm}

    \rule{\linewidth}{0.5pt}
  \end{minipage}

  \par
  \vspace{25.5mm}%

  \endgroup
}

% =========================================================
% ÍNDICE GENERAL
% =========================================================

% La clase article no incluye nivel chapter en el índice.
% Se añade explícitamente.

\makeatletter
\providecommand*{\toclevel@chapter}{0}
\providecommand*{\l@chapter}{}
\makeatother

\renewcommand{\contentsname}{Índice general}

\AtBeginDocument{%
  \renewcommand{\contentsname}{Índice general}%
}

\titlecontents{chapter}
  [0pt]
  {\addvspace{4.2mm}\fontsize{12}{14.4}\selectfont\bfseries}
  {\makebox[25.4mm][l]{Capítulo \thecontentslabel}}
  {}
  {\titlerule*[0.35em]{\_}\contentspage}

\titlecontents{section}
  [4.2mm]
  {\addvspace{3.2mm}\fontsize{11}{13.2}\selectfont}
  {\makebox[12.7mm][l]{\thecontentslabel}}
  {}
  {\titlerule*[0.35em]{\_}\contentspage}

\titlecontents{subsection}
  [12.7mm]
  {\fontsize{10}{12}\selectfont}
  {\makebox[15mm][l]{\thecontentslabel}}
  {}
  {\titlerule*[0.35em]{\_}\contentspage}

\makeatletter

\renewcommand\tableofcontents{%
  \thispagestyle{TFMFront}%
  \TFMFrontHeading{\contentsname}%

  \begingroup
  \setlength{\parskip}{0pt}%
  \@starttoc{toc}%
  \endgroup
}

\makeatother

% =========================================================
% UTILIDADES
% =========================================================

\newcommand{\TFMBlankPage}{%
  \clearpage
  \thispagestyle{empty}%
  \null
  \clearpage
}

\newcommand{\TFMPageBreak}{%
  \clearpage
}

\newcommand{\TFMSuppressPageNumber}{%
  \thispagestyle{empty}%
}

\newcommand{\TFMTOCPageBreak}{%
  \addtocontents{toc}{\protect\newpage}%
}