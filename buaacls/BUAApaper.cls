%\tracingmacros=1
%�˺� 5.02pt/5bp 
%�ߺ� 5.52pt/5.5bp
%С�� 6.52pt/6.5bp
%���� 7.53pt/7.5bp
%С�� 9.03pt/9bp
%��� 10.54pt/10.5bp
%С�� 12.05pt/12bp
%�ĺ� 14.05pt/14bp
%С�� 15.06pt/15bp
%���� 16.06pt/16bp
%С�� 18.07pt/18bp
%���� 22.08pt/22bp
%Сһ 24.09pt/24bp
%һ�� 26.10pt/26bp
%С��(?)36.14pt/36bp
%���� 42.16pt/42bp
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{BUAApaper}[2006/03/19 V0.1 by WangNan]

\newif\ifBUA@dvipdfm
\newif\ifBUA@xelatex
\newif\ifBUA@nobookmark
\newif\ifBUA@NoBUAATitle
%% ��һҳ�Ƿ��Ƿ���ͷ��
\newif\ifBUA@TITLE
\BUA@dvipdfmfalse
\BUA@xelatexfalse
\BUA@nobookmarkfalse
\BUA@NoBUAATitlefalse
\BUA@TITLEfalse
\DeclareOption{dvipdfm}{\BUA@dvipdfmtrue}
\DeclareOption{xelatex}{\BUA@xelatextrue}
\DeclareOption{nobookmark}{\BUA@nobookmarktrue}
\DeclareOption{bigtitle}{\BUA@TITLEtrue}


%% û�б�������ʽ�ı��⣬��������
\DeclareOption{NoBUAAtitle}{\BUA@NoBUAATitletrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

\ifBUA@TITLE
	\LoadClass[cs4size, punct, nospace, fancyhdr, fntef]{ctexart}[2005/11/25]
	\RequirePackage[a3paper=true, landscape=true, twocolumn=true,
		hoffset=0pt, voffset=0pt, tmargin=0pt, lmargin=0pt, rmargin=0pt]{geometry}
%\RequirePackage{multicolumn}
\else
	\LoadClass[cs4size, punct, nospace, fancyhdr, fntef]{ctexart}[2005/11/25]
	\ifBUA@xelatex
		% xelatex won't generate proper paper size without these options
		% FIXME: other drivers may also need this.
		\RequirePackage[a4paper=true,
		hoffset=0pt, voffset=0pt, tmargin=0pt, lmargin=0pt, rmargin=0pt]{geometry}
	\fi
\fi
%ʹ����cs4sizeѡ������������ϱ߾ࡣ
%%��ȡ���
%%\RequirePackage[a4paper]{anysize}
\RequirePackage{times}
%%����Ҫ�д���
\RequirePackage{booktabs}

\RequirePackage[sort&compress]{natbib}
\bibpunct{[}{]}{,}{n}{}{}
\RequirePackage{hypernat}

%������ natbib �� super ѡ��Ϳ���ʵ���ϱ�, ����֪Ϊ��û����������
\let\cite@save=\cite
\newcommand{\upcite}[1]{\textsuperscript{\cite@save{#1}}}
%\newcommand{\upcite}[1]{\relax}

\ifBUA@dvipdfm
 \RequirePackage[dvipdfm]{graphicx}
 \RequirePackage[dvipdfm,
   hyperindex,
    %hypertex,%%ѡ��hypertex��û��Bookmark������ʲô������
   colorlinks,linkcolor=blue,
   citecolor=blue,
   CJKbookmarks, pdfstartview=FitH,
\ifBUA@nobookmark
bookmarks=false,
\fi
   pdfauthor=pithree]{hyperref}
 \AtBeginDvi{\special{pdf:tounicode GBK-EUC-UCS2}}   % GBK -> Unicode
 \DeclareGraphicsExtensions{.eps}
\else
\ifBUA@xelatex
	\RequirePackage[CJKbookmarks,
	  \ifBUA@nobookmark
	  bookmarks=false,
	  \fi
	hyperindex,
	xetex, 
	colorlinks,linkcolor=blue,
	citecolor=blue,
	pdfstartview=FitH,
	citecolor=blue]{hyperref}
	\RequirePackage[xetex]{graphicx}
	\DeclareGraphicsExtensions{.pdf,.png,.jpg,.mps}
\else
	\RequirePackage[CJKbookmarks,
	  \ifBUA@nobookmark
	  bookmarks=false,
	  \fi
	hyperindex,
	colorlinks,linkcolor=blue,
	citecolor=blue,
	pdfstartview=FitH,
	citecolor=blue]{hyperref}
	\RequirePackage{graphicx}
	\DeclareGraphicsExtensions{.pdf,.png,.jpg,.mps}
\fi
\fi

\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{CJKfntef}



%%���沼��
\newlength\lengthA
\newlength\lengthB
\newlength\lengthC
\setlength{\hoffset}{-1in} %ȡ����߾�
\setlength{\voffset}{-1in} %ȡ���ϱ߾�
\ifBUA@TITLE
	\setlength{\topmargin}{0mm} %ҳü���ϱ߽�0mm
	\setlength{\oddsidemargin}{0mm}
	\setlength{\evensidemargin}{0mm}
	\setlength{\headheight}{0mm}
	\setlength{\marginparwidth}{0pt}
	\setlength{\headsep}{0pt}
	\setlength{\marginparpush}{0pt}
	%\setlength{\textwidth}{420mm}
	%\setlength{\textheight}{670.8bp} %%����
	\ifBUA@NoBUAATitle
		\setlength{\textheight}{670.8bp}
	\else
		\setlength{\textheight}{750bp} %%����ҳ���ֵӦΪ694.2, maketitle��Ļ���
	\fi	
	\renewcommand{\baselinestretch}{1.5} %%1.5���о�
\else
	\setlength{\topmargin}{10mm} %ҳü���ϱ߽�10mm
	\setlength{\oddsidemargin}{30mm}
	\setlength{\evensidemargin}{30mm}
	\setlength{\headheight}{25mm}
	\setlength{\marginparwidth}{0pt}
	\setlength{\headsep}{0pt}
	\setlength{\marginparpush}{0pt}
	\setlength{\textwidth}{456bp}
	%\setlength{\textheight}{670.8bp} %%����
	\ifBUA@NoBUAATitle
		\setlength{\textheight}{670.8bp}
	\else
		\setlength{\textheight}{750bp} %%����ҳ���ֵӦΪ694.2, maketitle��Ļ���
	\fi	
\renewcommand{\baselinestretch}{1.5} %%1.5���о�
\fi


%����ҳüҳ��
\pagestyle{fancy}

\newbox\buaamark
\setbox\buaamark=\hbox{\includegraphics[width=45bp]{graphics/buaamark.eps}}


\newcommand{\titletext}{\rmfamily \bfseries �������պ����ѧ��ҵ��ƣ����ģ�}
\newcommand{\titlesize}{250bp}
%\newcommand{\title}
\lhead{\strut{\lower5pt\copy\buaamark}\strut} %�³�һЩ���Ա���mark��ҳü�߾���Ϊ1bp,Ϊ����������Ϊ1pt
\chead{\flushleft\hbox{\hskip 79bp\hbox to \titlesize{\zihao{-3}\titletext}%
\hskip 72bp \zihao{5}\hbox to 54bp{\rmfamily\upshape �� \hfil \thepage \hfil ҳ}}} %�����������ģ���׼ȷ
\rhead{}
\lfoot{}\cfoot{}\rfoot{}
%\renewcommand{\headrulewidth}{0.5bp} %ҳü�߿���

%% ���ҳ�����⡣֮���Ը����ô��������Ϊ: latex ���� plaintex �ø�����ʾ
%% frontmatter��ҳ��, ���mainlatter��������ҳ��ͻ�����dvipdfmx��Warning������(��
%% ����)CTeX��Bug���²�����thepage��setcounter.(ctex ��� BUG �Ѿ����ҵ�Э���½����)

%% ���ڵ����������� calc ������ thepage �� setcounter
\newcounter{tmp} \newcounter{fend} \newcounter{displaypage}
\makeatletter
\let\BUA@save@outputpage=\@outputpage
\def\@outputpage{\relax\c@displaypage=\c@page \advance \c@displaypage by -\c@fend \BUA@save@outputpage}
\newcommand{\mainmatter}{\relax\setcounter{fend}{\c@page}\advance \c@fend by -1\gdef\thepage{%
	\arabic{displaypage}}}
\newcommand{\frontmatter}{\relax\setcounter{page}{1}%
	\gdef\thepage{\Roman{page}}}

%%ҳü��������ı����16pt.
\setlength{\headsep}{16pt}

%%ʹ����ֱ�Ļ��ֺ�
\let\oldintop\intop
\def\oldint{\oldintop\nolimits}

\let\oldsmallint\smallint

\DeclareSymbolFont{EUEX}{U}{euex}{m}{n}

\DeclareSymbolFont{euexlargesymbols}{U}{euex}{m}{n}
\DeclareMathSymbol{\intop}{\mathop}{euexlargesymbols}{"52}
     \def\int{\intop\nolimits}

\DeclareSymbolFont{euexsymbols}     {U}{euex}{m}{n}
\DeclareMathSymbol{\smallint}{\mathop}{euexsymbols}{"52}
\CJKtilde

%������Ӣ�ĵ����߱��⵼ʦ�Լ���λ���롢ѧ�š�����š��ܼ�
\gdef\@etitle{English Title}
\newcommand{\etitle}[1]{\gdef\@etitle{#1}}

\gdef\@eauthor{Zhang San}
\newcommand{\eauthor}[1]{\gdef\@eauthor{#1}}

%�����
\gdef\@classification{TP000}
\newcommand{\classification}[1]{\gdef\@classification{#1}}

%ѧ��
\gdef\@studentnumber{3X000000}
\newcommand{\studentnumber}[1]{\gdef\@studentnumber{#1}}

%��λ����
\gdef\@unitcode{TP10000}
\newcommand{\unitcode}[1]{\gdef\@unitcode{#1}}

\gdef\@confidential{������}
\newcommand{\confidential}[1]{\gdef\@confidential{#1}}

%Ժϵ����
\gdef\@schoolname{�����ѧԺ}
\newcommand{\schoolname}[1]{\gdef\@schoolname{#1}}

%רҵ����
\gdef\@specialty{�������ѧ�뼼��}
\newcommand{\specialty}[1]{\gdef\@specialty{#1}}

\gdef\@advisor{��С��}
\gdef\@eadvisor{Wang Xiaowu}
\newcommand{\advisor}[2]{\gdef\@advisor{#1}\gdef\@eadvisor{#2}}

\gdef\@cabsname{ժҪ}
\gdef\@ckeyword{���Ĺؼ���}
\gdef\@ekeyword{English Keyword}
\newcommand{\buaakeyword}[2]{\gdef\@ckeyword{#1}%
	\gdef\@ekeyword{#2}}


%����ժҪ
\newenvironment{cabstract}{%
	\newpage
	\vskip10.5bp
	\begin{center}
		\bf\zihao{3}\@title
	\end{center}
%\vskip15bp
\hfill	{\begin{tabular}{cl}
		\ziju{2}ѧ����&\@author\\
		ָ����ʦ��&\@advisor\\
	\end{tabular}}
	\begin{center}
		\bf\zihao{3} \ziju{2}ժҪ
	\end{center}
	\vskip15bp
}{%
	\vskip21bp
	\noindent {\bf\zihao{4} �ؼ��ʣ�}\@ckeyword
}

\newenvironment{eabstract}{%
	\newpage
	\vskip10.5bp
	\begin{center}
		\bf\zihao{3}\@etitle
	\end{center}
%\vskip15bp
\hfill	{\begin{tabular}{rl}
		Author��&\@eauthor\\
		Tutor��&\@eadvisor\\
	\end{tabular}}
	\vskip24bp
	\centerline{\bf\zihao{3} Abstract}
	\par
	\setlength{\parindent}{24bp}
	\setlength{\parskip}{18bp}
}{%
	\vskip21bp
	\noindent {\bf\zihao{4} Key words: }\@ekeyword
}

%���»�����д��, box0ҪԤ�ȶ�����»���
\newcommand{\@draw@right}[1]{\rlap{\copy0}{\raise 2pt\hbox to%
	\wd0{\hfil\bf\zihao{5}#1\hfil}}}
%����
\ifBUA@NoBUAATitle
	%\relax
	\let\maketitle@save=\maketitle
	\def\maketitle{\maketitle@save\thispagestyle{empty}}
\else
\renewcommand\maketitle{\begin{titlepage}%
%%
\setlength{\hoffset}{-1in} %ȡ����߾�
\setlength{\voffset}{-1in} %ȡ�������ԭ��������ϱ߾�3pt, �ϱ߾�65bp
\setlength{\oddsidemargin}{25mm}
\setlength{\evensidemargin}{25mm}
\setlength{\topmargin}{0mm}
\setlength{\headheight}{0pt}
\setlength{\marginparwidth}{20mm}
\setlength{\marginparsep}{5mm}
\setlength{\headsep}{0pt}
\setlength{\parindent}{0pt}
\setlength{\parsep}{0pt}
%�������Ͻǵ���һ�鶫��
\newbox\test@width
\setbox\test@width=\hbox{\bf\zihao{5}��λ����}%
\newlength\width@rt%
\setlength{\width@rt}{\wd\test@width}%
\newbox\table@rt
\setbox\table@rt=\hbox{%
	\def\@the@line{\vrule width100bp height 0.75bp depth 0pt}%
	\setbox0=\hbox{\@the@line}
	\begin{tabular}{c}
		\hbox to \width@rt{\bf\zihao{5}��λ����}\@draw@right{\@unitcode}\\
		\hbox to \width@rt{\bf\zihao{5}ѧ \hfil ��}\@draw@right{\@studentnumber}\\
		\hbox to \width@rt{\bf\zihao{5}�� \hfil ��\hfil ��}\@draw@right{\@classification}\\
		\hbox to \width@rt{\bf\zihao{5}�� \hfil ��}\@draw@right{\@confidential}\\
	\end{tabular}}
%��Ŀ�����м�
\newlength{\@title@pos}%��Ŀ��λ��
\setlength{\@title@pos}{413bp}
%
\newbox\@center@title@box
%\setbox\@center@title@box=\vbox{\parbox{\centerline{\bf\zihao{2}\@title}}}
\setbox\@center@title@box=\vbox{{\centerline{\parbox{.7\textwidth}{\centering\bf\zihao{2}\@title}}}}
%%
\hrule height\@title@pos width0pt depth0pt
\copy\@center@title@box
\newlength\@tmp
\setlength{\@tmp}{\@title@pos+\ht\@center@title@box+\dp\@center@title@box}
\hrule height-\@tmp width0pt depth0pt
\hrule height22mm depth0pt width0pt
\vrule width9bp height0bp\includegraphics[width=90.05pt]{graphics/buaamark.eps}\hfill%
	\raise\dp\table@rt\box\table@rt
\hrule height0pt
\vrule width 0bp height105.4bp
\centerline{\includegraphics[width=362.25bp]{graphics/buaaname.eps}}
\vskip 47bp
\centerline{\def~{\hskip1bp}\bf\zihao{-0}��~ҵ~��~��~��~��~��~��}
\vskip200bp
%
\newbox\@tmp@strutbox
\setbox\@tmp@strutbox=\hbox{\vrule height25.8bp depth0pt width0pt}
\begin{center}
\def~{\hfil}
\def\@set@font{\bf\zihao{-3}}
\def\baselinestretch{1.5}
\begin{tabular}{c@{}c}
{\copy\@tmp@strutbox\hbox to 122bp{\@set@font Ժ~��~ϵ~��~��~��}}&%
	\hbox to 218.55bp{\@set@font\ziju{0.1}\hfill\@schoolname\hfill}\\ \cline{2-2}
{\copy\@tmp@strutbox\hbox to 122bp{\@set@font ר~ҵ~��~��}}&%
	\hbox to 218.55bp{\@set@font\ziju{0.1}\hfill\@specialty\hfill}\\ \cline{2-2}
{\copy\@tmp@strutbox\hbox to 122bp{\@set@font ѧ~��~��~��}}&%
	\hbox to 218.55bp{\@set@font\ziju{0.1}\hfill\@author\hfill}\\ \cline{2-2}
{\box\@tmp@strutbox\hbox to 122bp{\@set@font ָ~��~��~ʦ}}&%
	\hbox to 218.55bp{\@set@font\ziju{0.1}\hfill\@advisor\hfill}\\ \cline{2-2}
\end{tabular}
\end{center}
\vfill
\centerline{\bf\zihao{-3}\@date}
\end{titlepage}%
\setlength{\textheight}{670.8bp}%
\setcounter{page}{0}
}
\fi

\renewcommand \thefigure
     {\ifnum \c@section>\z@ \thesection.\fi \@arabic\c@figure}
\@addtoreset{figure}{section}

\def\CTEX@appendixname{��¼}
%\let\appendix@save=\appendix
%\renewcommand{\appendix}{\appendix@save\renewcommand{\sectionname}{��¼}}

%% �����鼹

\endinput