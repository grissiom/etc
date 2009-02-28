%\tracingmacros=1
%八号 5.02pt/5bp 
%七号 5.52pt/5.5bp
%小六 6.52pt/6.5bp
%六号 7.53pt/7.5bp
%小五 9.03pt/9bp
%五号 10.54pt/10.5bp
%小四 12.05pt/12bp
%四号 14.05pt/14bp
%小三 15.06pt/15bp
%三号 16.06pt/16bp
%小二 18.07pt/18bp
%二号 22.08pt/22bp
%小一 24.09pt/24bp
%一号 26.10pt/26bp
%小初(?)36.14pt/36bp
%初号 42.16pt/42bp
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{BUAApaper}[2006/03/19 V0.1 by WangNan]

\newif\ifBUA@dvipdfm
\newif\ifBUA@xelatex
\newif\ifBUA@nobookmark
\newif\ifBUA@NoBUAATitle
%% 这一页是否是封面和封底
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


%% 没有北航论文式的标题，用于译文
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
%使用了cs4size选项会引起额外的上边距。
%%读取宏包
%%\RequirePackage[a4paper]{anysize}
\RequirePackage{times}
%%表格要有粗线
\RequirePackage{booktabs}

\RequirePackage[sort&compress]{natbib}
\bibpunct{[}{]}{,}{n}{}{}
\RequirePackage{hypernat}

%本来用 natbib 的 super 选项就可以实现上标, 但不知为何没有中括号了
\let\cite@save=\cite
\newcommand{\upcite}[1]{\textsuperscript{\cite@save{#1}}}
%\newcommand{\upcite}[1]{\relax}

\ifBUA@dvipdfm
 \RequirePackage[dvipdfm]{graphicx}
 \RequirePackage[dvipdfm,
   hyperindex,
    %hypertex,%%选了hypertex就没有Bookmark，这是什么道理！
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



%%版面布局
\newlength\lengthA
\newlength\lengthB
\newlength\lengthC
\setlength{\hoffset}{-1in} %取消左边距
\setlength{\voffset}{-1in} %取消上边距
\ifBUA@TITLE
	\setlength{\topmargin}{0mm} %页眉距上边界0mm
	\setlength{\oddsidemargin}{0mm}
	\setlength{\evensidemargin}{0mm}
	\setlength{\headheight}{0mm}
	\setlength{\marginparwidth}{0pt}
	\setlength{\headsep}{0pt}
	\setlength{\marginparpush}{0pt}
	%\setlength{\textwidth}{420mm}
	%\setlength{\textheight}{670.8bp} %%量的
	\ifBUA@NoBUAATitle
		\setlength{\textheight}{670.8bp}
	\else
		\setlength{\textheight}{750bp} %%标题页这个值应为694.2, maketitle后改回来
	\fi	
	\renewcommand{\baselinestretch}{1.5} %%1.5倍行距
\else
	\setlength{\topmargin}{10mm} %页眉距上边界10mm
	\setlength{\oddsidemargin}{30mm}
	\setlength{\evensidemargin}{30mm}
	\setlength{\headheight}{25mm}
	\setlength{\marginparwidth}{0pt}
	\setlength{\headsep}{0pt}
	\setlength{\marginparpush}{0pt}
	\setlength{\textwidth}{456bp}
	%\setlength{\textheight}{670.8bp} %%量的
	\ifBUA@NoBUAATitle
		\setlength{\textheight}{670.8bp}
	\else
		\setlength{\textheight}{750bp} %%标题页这个值应为694.2, maketitle后改回来
	\fi	
\renewcommand{\baselinestretch}{1.5} %%1.5倍行距
\fi


%定义页眉页脚
\pagestyle{fancy}

\newbox\buaamark
\setbox\buaamark=\hbox{\includegraphics[width=45bp]{graphics/buaamark.eps}}


\newcommand{\titletext}{\rmfamily \bfseries 北京航空航天大学毕业设计（论文）}
\newcommand{\titlesize}{250bp}
%\newcommand{\title}
\lhead{\strut{\lower5pt\copy\buaamark}\strut} %下沉一些，以便让mark和页眉线距离为1bp,为简便起见，改为1pt
\chead{\flushleft\hbox{\hskip 79bp\hbox to \titlesize{\zihao{-3}\titletext}%
\hskip 72bp \zihao{5}\hbox to 54bp{\rmfamily\upshape 第 \hfil \thepage \hfil 页}}} %都是量出来的，不准确
\rhead{}
\lfoot{}\cfoot{}\rfoot{}
%\renewcommand{\headrulewidth}{0.5bp} %页眉线宽度

%% 解决页码问题。之所以搞的这么复杂是引为: latex 不象 plaintex 用负数表示
%% frontmatter的页码, 如果mainlatter重新设置页码就会引发dvipdfmx的Warning。另外(可
%% 能是)CTeX的Bug导致不能在thepage中setcounter.(ctex 这个 BUG 已经在我的协助下解决了)

%% 现在的问题是用了 calc 后不能在 thepage 中 setcounter
\newcounter{tmp} \newcounter{fend} \newcounter{displaypage}
\makeatletter
\let\BUA@save@outputpage=\@outputpage
\def\@outputpage{\relax\c@displaypage=\c@page \advance \c@displaypage by -\c@fend \BUA@save@outputpage}
\newcommand{\mainmatter}{\relax\setcounter{fend}{\c@page}\advance \c@fend by -1\gdef\thepage{%
	\arabic{displaypage}}}
\newcommand{\frontmatter}{\relax\setcounter{page}{1}%
	\gdef\thepage{\Roman{page}}}

%%页眉和下面的文本相距16pt.
\setlength{\headsep}{16pt}

%%使用竖直的积分号
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

%定义中英文的作者标题导师以及单位代码、学号、分类号、密级
\gdef\@etitle{English Title}
\newcommand{\etitle}[1]{\gdef\@etitle{#1}}

\gdef\@eauthor{Zhang San}
\newcommand{\eauthor}[1]{\gdef\@eauthor{#1}}

%分类号
\gdef\@classification{TP000}
\newcommand{\classification}[1]{\gdef\@classification{#1}}

%学号
\gdef\@studentnumber{3X000000}
\newcommand{\studentnumber}[1]{\gdef\@studentnumber{#1}}

%单位代码
\gdef\@unitcode{TP10000}
\newcommand{\unitcode}[1]{\gdef\@unitcode{#1}}

\gdef\@confidential{不涉密}
\newcommand{\confidential}[1]{\gdef\@confidential{#1}}

%院系名称
\gdef\@schoolname{计算机学院}
\newcommand{\schoolname}[1]{\gdef\@schoolname{#1}}

%专业名称
\gdef\@specialty{计算机科学与技术}
\newcommand{\specialty}[1]{\gdef\@specialty{#1}}

\gdef\@advisor{王小五}
\gdef\@eadvisor{Wang Xiaowu}
\newcommand{\advisor}[2]{\gdef\@advisor{#1}\gdef\@eadvisor{#2}}

\gdef\@cabsname{摘要}
\gdef\@ckeyword{中文关键词}
\gdef\@ekeyword{English Keyword}
\newcommand{\buaakeyword}[2]{\gdef\@ckeyword{#1}%
	\gdef\@ekeyword{#2}}


%中文摘要
\newenvironment{cabstract}{%
	\newpage
	\vskip10.5bp
	\begin{center}
		\bf\zihao{3}\@title
	\end{center}
%\vskip15bp
\hfill	{\begin{tabular}{cl}
		\ziju{2}学生：&\@author\\
		指导教师：&\@advisor\\
	\end{tabular}}
	\begin{center}
		\bf\zihao{3} \ziju{2}摘要
	\end{center}
	\vskip15bp
}{%
	\vskip21bp
	\noindent {\bf\zihao{4} 关键词：}\@ckeyword
}

\newenvironment{eabstract}{%
	\newpage
	\vskip10.5bp
	\begin{center}
		\bf\zihao{3}\@etitle
	\end{center}
%\vskip15bp
\hfill	{\begin{tabular}{rl}
		Author：&\@eauthor\\
		Tutor：&\@eadvisor\\
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

%在下划线上写字, box0要预先定义成下划线
\newcommand{\@draw@right}[1]{\rlap{\copy0}{\raise 2pt\hbox to%
	\wd0{\hfil\bf\zihao{5}#1\hfil}}}
%封面
\ifBUA@NoBUAATitle
	%\relax
	\let\maketitle@save=\maketitle
	\def\maketitle{\maketitle@save\thispagestyle{empty}}
\else
\renewcommand\maketitle{\begin{titlepage}%
%%
\setlength{\hoffset}{-1in} %取消左边距
\setlength{\voffset}{-1in} %取消因各种原因引起的上边距3pt, 上边距65bp
\setlength{\oddsidemargin}{25mm}
\setlength{\evensidemargin}{25mm}
\setlength{\topmargin}{0mm}
\setlength{\headheight}{0pt}
\setlength{\marginparwidth}{20mm}
\setlength{\marginparsep}{5mm}
\setlength{\headsep}{0pt}
\setlength{\parindent}{0pt}
\setlength{\parsep}{0pt}
%构造右上角的那一组东西
\newbox\test@width
\setbox\test@width=\hbox{\bf\zihao{5}单位代码}%
\newlength\width@rt%
\setlength{\width@rt}{\wd\test@width}%
\newbox\table@rt
\setbox\table@rt=\hbox{%
	\def\@the@line{\vrule width100bp height 0.75bp depth 0pt}%
	\setbox0=\hbox{\@the@line}
	\begin{tabular}{c}
		\hbox to \width@rt{\bf\zihao{5}单位代码}\@draw@right{\@unitcode}\\
		\hbox to \width@rt{\bf\zihao{5}学 \hfil 号}\@draw@right{\@studentnumber}\\
		\hbox to \width@rt{\bf\zihao{5}分 \hfil 类\hfil 号}\@draw@right{\@classification}\\
		\hbox to \width@rt{\bf\zihao{5}密 \hfil 级}\@draw@right{\@confidential}\\
	\end{tabular}}
%题目在正中间
\newlength{\@title@pos}%题目的位置
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
\centerline{\def~{\hskip1bp}\bf\zihao{-0}毕~业~设~计~（~论~文~）}
\vskip200bp
%
\newbox\@tmp@strutbox
\setbox\@tmp@strutbox=\hbox{\vrule height25.8bp depth0pt width0pt}
\begin{center}
\def~{\hfil}
\def\@set@font{\bf\zihao{-3}}
\def\baselinestretch{1.5}
\begin{tabular}{c@{}c}
{\copy\@tmp@strutbox\hbox to 122bp{\@set@font 院~（~系~）~名~称}}&%
	\hbox to 218.55bp{\@set@font\ziju{0.1}\hfill\@schoolname\hfill}\\ \cline{2-2}
{\copy\@tmp@strutbox\hbox to 122bp{\@set@font 专~业~名~称}}&%
	\hbox to 218.55bp{\@set@font\ziju{0.1}\hfill\@specialty\hfill}\\ \cline{2-2}
{\copy\@tmp@strutbox\hbox to 122bp{\@set@font 学~生~姓~名}}&%
	\hbox to 218.55bp{\@set@font\ziju{0.1}\hfill\@author\hfill}\\ \cline{2-2}
{\box\@tmp@strutbox\hbox to 122bp{\@set@font 指~导~教~师}}&%
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

\def\CTEX@appendixname{附录}
%\let\appendix@save=\appendix
%\renewcommand{\appendix}{\appendix@save\renewcommand{\sectionname}{附录}}

%% 生成书脊

\endinput
