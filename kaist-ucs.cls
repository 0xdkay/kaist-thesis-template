% -*- TeX:UTF-8 -*-
%% KAIST Thesis Template for LaTeX
%%
%% @version      0.4
%% @releasedate  Apr 28th, 2007
%%
%% @author       Chae, Seugbyung 채승병
%%               mailto:chess@kaist.ac.kr
%%
%% @requirements
%%    current distribution of TeXLive
%%      + ko.TeX
%%
%% Karnes Kim, converted to ko.TeX version. 
%%    2008/10/21
%%
%% Seokwoo Choi, modified according to the 2008 thesis format
%%    2008/12/29
%%
%% Jong Mun Lee, modified according to the 2010 thesis format
%% 2010/11/25
%% 본 수정은 대학원학생회와 교무팀의 지원으로 진행되었습니다.

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{kaist-ucs}%
       [2008/10/21 v0.4 Standard KAIST Thesis document class, ko.TeX version]
       
%% 옵션 설정을 위한 boolean 변수선언
\newif\if@isDoctor
\newif\if@isKorean
\newif\if@isFinal
\newif\if@PDFdoc\@PDFdocfalse
\newif\if@dvips\@dvipsfalse

%% 새 옵션 모음 - doctor|master, korean|english, final|draft
\DeclareOption{doctor} {\@isDoctortrue}
\DeclareOption{master} {\@isDoctorfalse}
\DeclareOption{korean} {\@isKoreantrue}
\DeclareOption{english}{\@isKoreanfalse}
\DeclareOption{final}  {\@isFinaltrue}
\DeclareOption{draft}  {\@isFinalfalse}
\DeclareOption{pdfdoc} {\@PDFdoctrue}
\DeclareOption{dvips}  {\@dvipstrue}

%% leqno,fleqn,openbib 옵션은 그대로 report 클래스에 전달
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ExecuteOptions{doctor,korean,final}         % doctor,korean,final이 기본값
\ProcessOptions

%% 10pt,a4paper,onecolumn,oneside 옵션으로 report 클래스 불러오기
\LoadClass[10pt,a4paper,onecolumn,oneside]{report}


%%들여쓰기
\usepackage{indentfirst}
\setlength\parindent{2.0em}

\RequirePackage{ifthen}       % 추가 패키지 설정

%%%% Hangul-ucs preamble.......
\RequirePackage[nonfrench]{dhucs}
%\RequirePackage[default]{dhucs-interword}
\RequirePackage{ifpdf}
\ifpdf
  \def\@drivername{pdftex}
\else
  \def\@drivername{dvipdfmx}
\fi
\if@dvips
  \def\@drivername{dvips}
\fi

%\ifpdf
%  \input glyphtounicode\pdfgentounicode=1
%\fi

\RequirePackage[\@drivername]{graphicx,xcolor}

\if@PDFdoc
  \RequirePackage[unicode,%
      \@drivername=true,%
      bookmarks=true,%
     colorlinks=true,%
   ]{hyperref}
\else
  \RequirePackage[unicode,%
      \@drivername=true,%
      bookmarks=false,%
     colorlinks=false,%
   ]{hyperref}
\fi

%% for compatability to HLaTeX
\let\gt\sffamily
\DeclareTextFontCommand{\textgt}{\gt}
%%%% end of Hangul-ucs preamble

\AtBeginDocument{%                           % \begin{document}와 함께 실행
    \checkparameters                        % 문서 변수가 올바른지 점검
    \if@isFinal                             % final 옵션이 지정되어 있으면
        \makefrontcover \maketitle         % 앞표지, 속표지 생성
        \makeapproval                      % 제출승인서, 심사완료검인 생성
    \else \fi }
\AtEndDocument{}                             % \end{document}와 함께 실행

%% 편집용지 설정
\usepackage[left=25.4mm,right=25.4mm,top=30mm,bottom=25.4mm,a4paper]{geometry}


%% 줄간격 설정
%\renewcommand{\baselinestretch}{1.3}
\linespread{1.3}

%% 본문이 영어로 되어있는지 한글로 되어있는지 설정
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                    % 텍스트 기본언어 변수선언
\if@isKorean                                 % korean 옵션이 지정되어 있으면
    \let\@textlang\@korean                  % 텍스트 기본언어는 한글
\else                                        % english 옵션이 지정되어 있으면
    \let\@textlang\@english                 % 텍스트 기본언어는 영문
\fi

%% KAIST 공식 영문명칭
\newcommand{\@kaist}{KAIST}

%% pagestyle 
\def\ps@kaist{\let\@mkboth\@gobbletwo
     \let\@oddhead\@empty
     \def\@oddfoot{\reset@font\hfil--\ \thepage\ --
     \hfil}%
     \let\@evenhead\@empty\let\@evenfoot\@oddfoot
}

\pagestyle{kaist}

%%
%% 문서 정보 변수 정의
%%

% @command title 논문 제목
% @options [default: (none)]
% - korean: 한글제목 | english: 영문제목
\renewcommand{\title}[2][korean] {%
    \ifthenelse{\equal{#1}{korean}}%
        {\newcommand{\@titleKor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}%
        {\newcommand{\@titleEng}{#2}}{}%
}
\@onlypreamble{\title}

% @command author 저자 이름
% @param family_name, given_name 성, 이름을 구분해서 입력
% @options [default: (none)]
% - korean: 한글이름 | chinese: 한문이름 | english: 영문이름
\renewcommand{\author}[3][korean] {%
    \ifthenelse{\equal{#1}{korean}}
        {\newcommand{\@authorKorFN}{#2}
         \newcommand{\@authorKorGN}{#3}
         \newcommand{\@authorKor}{#2\ #3}}{}%
    \ifthenelse{\equal{#1}{chinese}}
        {\newcommand{\@authorChnFN}{#2}
         \newcommand{\@authorChnGN}{#3}
         \newcommand{\@authorChn}{#2\ #3}}{}%
    \ifthenelse{\equal{#1}{english}}
        {\newcommand{\@authorEngFN}{#2}
         \newcommand{\@authorEngGN}{#3}
         \newcommand{\@authorEng}{#2, #3}}{}%
}
\@onlypreamble{\author}

% @command advisor 지도교수 이름 (복수가능)
% @options [default: major]
% - major: 주 지도교수  | coopr: 부 지도교수 (공동지도교수 경우)
\newcommand{\advisor}[4][major]{%
    \ifthenelse{\equal{#1}{major}} {%       % 주 지도교수이면
        \newcommand{\@advisorMajorKor}{#2} % 한글이름 저장
        \newcommand{\@advisorMajorEng}{#3} % 영문이름 저장
        % nosign을 명시하지 않으면 주 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#4}{nosign}}{}{%
            \newcommand{\@advisorSigned}{\@advisorMajorEng}} }{}%
    \ifthenelse{\equal{#1}{coopr}} {%       % 부 지도교수이면
        \newcommand{\@advisorCooprKor}{#2} % 한글이름 저장
        \newcommand{\@advisorCooprEng}{#3} % 영문이름 저장
        % signed를 명시해야 부 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#4}{signed}}{%
            \newcommand{\@advisorSigned}{\@advisorCooprEng}}{} }{}%
}
\@onlypreamble{\advisor}

% @command department 
%
\newcommand{\@degreeCode}{}          % 학위 영문코드
\newcommand{\@degreeName}{}          % 학위명
\newcommand{\@parentDeptNameKor}{}      % 학과/전공 첫째줄
\newcommand{\@childDeptNameKor}{}       % 학과/전공 둘째줄
\newcommand{\@parentDeptNameEng}{}      % 학과/전공 첫째줄
\newcommand{\@childDeptNameEng}{}       % 학과/전공 둘째줄
\newcommand{\@affFullNameKor}{}      % 학과/전공 한글이름
\newcommand{\@affFullNameEng}{}      % 학과/전공 영문이름
\newcommand{\@affFullNameEngCover}{} % 학과/전공 영문이름(표지용)
\newcommand{\@degreeField}{}
\newcommand{\@degreePrefix}{\ifthenelse{\boolean{@isDoctor}}{D}{M}}
\newcommand{\department}[2] {%
    \ifthenelse{\equal{#1}{PH}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{물리학과}
         \renewcommand{\@childDeptNameEng}{Department of Physics}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{MAS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{수리과학과}
         \renewcommand{\@childDeptNameEng}{Department of Mathematical Sciences}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{CH}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{화학과}
         \renewcommand{\@childDeptNameEng}{Department of Chemistry}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{NST}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{나노과학기술대학원}
         \renewcommand{\@childDeptNameEng}{Graduate School of Nanoscience \& Technology}
         \renewcommand{\@degreeField}{#2}} {}       
    \ifthenelse{\equal{#1}{NT}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{나노과학기술 학제전공}
         \renewcommand{\@childDeptNameEng}{Nano Science and Technology Program}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{BS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{생명과학과}
         \renewcommand{\@childDeptNameEng}{Department of Biological Sciences}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{BIS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{바이오및뇌공학과}
         \renewcommand{\@childDeptNameEng}{Department of Bio and Brain Engineering}
         \renewcommand{\@degreeField}{#2}} {}      	
    \ifthenelse{\equal{#1}{MSE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{의과학대학원}
         \renewcommand{\@childDeptNameEng}{Graduate School of Medical Science and Engineering}
         \renewcommand{\@degreeField}{#2}} {}      	
    \ifthenelse{\equal{#1}{BM}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{의과학 학제전공}
         \renewcommand{\@childDeptNameEng}{Biomedical Science and Engineering Program}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{CE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{건설및환경공학과}
         \renewcommand{\@childDeptNameEng}{Department of Civil and Environmental Engineering}
         \renewcommand{\@degreeField}{#2}} {}          	
    \ifthenelse{\equal{#1}{ME}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@parentDeptNameKor}{기계항공시스템학부}
         \renewcommand{\@parentDeptNameEng}{School of Mechanical, Aerospace and Systems Engineering}
         \renewcommand{\@childDeptNameKor}{기계공학전공}
         \renewcommand{\@childDeptNameEng}{Division of Mechanical Engineering}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{AE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@parentDeptNameKor}{기계항공시스템학부}
         \renewcommand{\@parentDeptNameEng}{School of Mechanical, Aerospace and Systems Engineering}
         \renewcommand{\@childDeptNameKor}{항공우주공학전공}
         \renewcommand{\@childDeptNameEng}{Division of Aerospace Engineering}
         \renewcommand{\@degreeField}{#2}} {}	
    \ifthenelse{\equal{#1}{OSE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@parentDeptNameKor}{기계항공시스템학부}
         \renewcommand{\@parentDeptNameEng}{School of Mechanical, Aerospace and Systems Engineering}
         \renewcommand{\@childDeptNameKor}{해양시스템공학전공}
         \renewcommand{\@childDeptNameEng}{Department of Ocean Systems Engineering}
         \renewcommand{\@degreeField}{#2}} {}	  	
    \ifthenelse{\equal{#1}{CBE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{생명화학공학과}
         \renewcommand{\@childDeptNameEng}{Department of Chemical and Biomolecular Engineering}
         \renewcommand{\@degreeField}{#2}} {}      	
    \ifthenelse{\equal{#1}{MS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{신소재공학과}
         \renewcommand{\@childDeptNameEng}{Department of Materials Science and Engineering}
         \renewcommand{\@degreeField}{#2}} {}      	
    \ifthenelse{\equal{#1}{NQE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{원자력 및 양자공학과}
         \renewcommand{\@childDeptNameEng}{Department of Nuclear and Quantum Engineering}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{EEW}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{EEWS 대학원}
         \renewcommand{\@childDeptNameEng}{Graduate School of EEWS}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{PSE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{고분자 학제전공}
         \renewcommand{\@childDeptNameEng}{Polymer Science and Engineering Program}
         \renewcommand{\@degreeField}{#2}} {}         
     \ifthenelse{\equal{#1}{SPE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{우주탐사공학 학제전공}
         \renewcommand{\@childDeptNameEng}{Space Exploration Engineering Program}
         \renewcommand{\@degreeField}{#2}} {}         
     \ifthenelse{\equal{#1}{ENY}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{환경·에너지공학 학제전공}
         \renewcommand{\@childDeptNameEng}{Environmental and Energy Program}
         \renewcommand{\@degreeField}{#2}} {}               
     \ifthenelse{\equal{#1}{IT}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@parentDeptNameKor}{경영과학과}
         \renewcommand{\@parentDeptNameEng}{Department of Management Science}
         \renewcommand{\@childDeptNameKor}{경영과학과(IT경영학)}
         \renewcommand{\@childDeptNameEng}{Department of Management Science (IT Business)}
         \renewcommand{\@degreeField}{#2}} {}        
     \ifthenelse{\equal{#1}{BAP}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@parentDeptNameKor}{경영과학과}
         \renewcommand{\@parentDeptNameEng}{Department of Management Science}
         \renewcommand{\@childDeptNameKor}{경영전문대학원프로그램}
         \renewcommand{\@childDeptNameEng}{Master of Business Administration Program}
         \renewcommand{\@degreeField}{#2}} {}          
     \ifthenelse{\equal{#1}{ITP}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{글로벌IT기술대학원프로그램}
         \renewcommand{\@childDeptNameEng}{Global Information \& Telecommunication Technology Program}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{ITM}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{기술경영전문대학원}
         \renewcommand{\@childDeptNameEng}{Graduate School of Innovation \& Technology Management}
         \renewcommand{\@degreeField}{#2}} {}         
     \ifthenelse{\equal{#1}{GCT}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{문화기술대학원}
         \renewcommand{\@childDeptNameEng}{Graduate School of Culture Technology}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{STP}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{과학기술정책대학원}
         \renewcommand{\@childDeptNameEng}{Graduate Program of Science and Technology Policy}
         \renewcommand{\@degreeField}{#2}} {}                     
     \ifthenelse{\equal{#1}{CT}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{문화기술(CT) 학제전공}
         \renewcommand{\@childDeptNameEng}{Culture Technology Program}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{EE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{전기 및 전자공학부}
         \renewcommand{\@childDeptNameEng}{School of Electrical Engineering}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{STE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@parentDeptNameKor}{전기 및 전자공학부}
         \renewcommand{\@parentDeptNameEng}{School of Electrical Engineering}
         \renewcommand{\@childDeptNameKor}{반도체공학프로그램}
         \renewcommand{\@childDeptNameEng}{KAIST Education Program for Semiconductor Industry}
         \renewcommand{\@degreeField}{#2}} {}                                                         
    \ifthenelse{\equal{#1}{CS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{전산학과}
         \renewcommand{\@childDeptNameEng}{Department of Computer Science}
         \renewcommand{\@degreeField}{#2}} {}      
    \ifthenelse{\equal{#1}{ICE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{정보통신공학과}
         \renewcommand{\@childDeptNameEng}{Department of Information and Communications Engineering}
         \renewcommand{\@degreeField}{#2}} {}      
    \ifthenelse{\equal{#1}{IE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{산업및시스템공학과}
         \renewcommand{\@childDeptNameEng}{Department of Industrial \& Systems Engineering}
         \renewcommand{\@degreeField}{#2}} {}             
    \ifthenelse{\equal{#1}{KSE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{지식서비스공학과}
         \renewcommand{\@childDeptNameEng}{Department of Knowledge Service Engineering}
         \renewcommand{\@degreeField}{#2}} {}                        
    \ifthenelse{\equal{#1}{ID}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{산업디자인학과}
         \renewcommand{\@childDeptNameEng}{Department of Industrial Design}
         \renewcommand{\@degreeField}{#2}} {}                                     
     \ifthenelse{\equal{#1}{RE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{로봇공학 학제전공}
         \renewcommand{\@childDeptNameEng}{Robotics Program}	
         \renewcommand{\@degreeField}{#2}} {}                                                  
    \ifthenelse{\equal{#1}{STE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{반도체 학제전공}
         \renewcommand{\@childDeptNameEng}{Semiconductor Technology Educational Program}
         \renewcommand{\@degreeField}{#2}} {}                                                                   
    \ifthenelse{\equal{#1}{SEP}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@parentDeptNameKor}{소프트웨어대학원프로그램}
         \renewcommand{\@parentDeptNameEng}{Software Graduate Program}
         \renewcommand{\@childDeptNameKor}{소프트웨어공학프로그램}
         \renewcommand{\@childDeptNameEng}{Software Engineering Program}
         \renewcommand{\@degreeField}{#2}} {}         
     \ifthenelse{\equal{#1}{TE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{정보통신공학 학제전공}
         \renewcommand{\@childDeptNameEng}{Telecommunication Engineering Program}
         \renewcommand{\@degreeField}{#2}} {}    
     \ifthenelse{\equal{#1}{EML}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{e-매뉴팩쳐링리더십 학제전공}
         \renewcommand{\@childDeptNameEng}{e-Manufacturing Leadership Program}
         \renewcommand{\@degreeField}{#2}} {}   
      \ifthenelse{\equal{#1}{MT}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{경영공학과}
         \renewcommand{\@childDeptNameEng}{Department of Management Engineering}
         \renewcommand{\@degreeField}{#2}} {}          
     \ifthenelse{\equal{#1}{TM}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@parentDeptNameKor}{테크노경영대학원}
         \renewcommand{\@parentDeptNameEng}{Graduate School of Management}
         \renewcommand{\@childDeptNameKor}{테크노경영전공}
         \renewcommand{\@childDeptNameEng}{Techno-MBA Program}
         \renewcommand{\@degreeField}{#2}} {}                           
     \ifthenelse{\equal{#1}{FIN}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{금융전문대학원}
         \renewcommand{\@childDeptNameEng}{Graduate School of Finance and Accounting}
         \renewcommand{\@degreeField}{#2}} {}                                                    

    \renewcommand{\@affFullNameKor}{%               % 학과/전공 한글이름
    	\ifthenelse{\equal{\@parentDeptNameKor}{}}
    		{\@childDeptNameKor}
    		{\@parentDeptNameKor, \@childDeptNameKor}
    }
    \renewcommand{\@affFullNameEng}{%               % 학과/전공 영문이름
        	\ifthenelse{\equal{\@parentDeptNameEng}{}}
    		{\@childDeptNameEng}
    		{\@parentDeptNameEng, \@childDeptNameEng}
    }

    \renewcommand{\@affFullNameEngCover}{%          % 학과/전공 영문이름
        	\ifthenelse{\equal{\@parentDeptNameEng}{}}
    		{\@childDeptNameEng}
    		{\@parentDeptNameEng \\ \@childDeptNameEng}
    }
    \renewcommand{\@degreeName}{%                       % 학위 영문이름
        \ifthenelse{\boolean{@isDoctor}}
            {Doctor of Philosophy} {%                 % 박사는 모두 Ph.D.
            \ifthenelse{\equal{\@degreeField}{science}}
                {Master of Science}{}%               % 이학석사는 M.S.
            \ifthenelse{\equal{\@degreeField}{engineering}}
                {Master of Science in Engineering}{}%           % 공학석사는 M.E.
            \ifthenelse{\equal{\@degreeField}{business}}
                {Master of Business Administration}{}% 경영학석사는 M.B.A.
        }
    }
}
\@onlypreamble{\department}

% @command studentid 학번
\newcommand{\studentid}[1]{\newcommand{\@studentID}{#1}}
\@onlypreamble{\studentid}

% @command referee 심사위원 (석사과정 3인, 박사과정 5인)
\newcommand{\referee}[2][1] {%
    \ifthenelse{\equal{#1}{1}}{\newcommand{\@refereeChief} {#2}} {}%
    \ifthenelse{\equal{#1}{2}}{\newcommand{\@refereeSecond}{#2}} {}%
    \ifthenelse{\equal{#1}{3}}{\newcommand{\@refereeThird} {#2}} {}%
    \ifthenelse{\equal{#1}{4}}{\newcommand{\@refereeFourth}{#2}} {}%
    \ifthenelse{\equal{#1}{5}}{\newcommand{\@refereeFifth} {#2}} {}%
}
\@onlypreamble{\referee}

% @command approvaldate 지도교수논문승인일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\approvaldate}[3] {%
    \newcommand{\@approvalYear}{#1}
    \newcommand{\@approvalMonth}{#2}
    \newcommand{\@approvalDay}{#3}
}
\@onlypreamble{\approvaldate}

% @command refereedate 심사위원논문심사일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\refereedate}[3] {%
    \newcommand{\@refereeYear}{#1}
    \newcommand{\@refereeMonth}{#2}
    \newcommand{\@refereeDay}{#3}
}
\@onlypreamble{\refereedate}

% @command gradyear 졸업년도
\newcommand{\gradyear}[1]{\newcommand{\@gradYear}{#1}}
\@onlypreamble{\gradyear}

%%
%% 필요한 정보 중에 누락된 것이 없는지 점검 --> 제작중. 아직 불완전.
%%
\newcommand{\checkparameters}{%
    \@ifundefined{@titleKor}{%
        \ClassError{kaist}{The korean title is not found}{}}{}
    \@ifundefined{@titleEng}{%
        \ClassError{kaist}{The english title is not found}{}}{}
    \@ifundefined{@authorKor}{%
        \ClassError{kaist}{The korean name of the author is not found}{}}{}
    \@ifundefined{@authorChn}{%
        \ClassError{kaist}{The chinese name of the author is not found}{}}{}
    \@ifundefined{@authorEng}{%
        \ClassError{kaist}{The english name of the author is not found}{}}{}
    \@ifundefined{@advisorMajorKor}{%
        \ClassError{kaist}{The korean name of the major advisor is not found}{}}{}
    \@ifundefined{@advisorMajorEng}{%
        \ClassError{kaist}{The english name of the major advisor is not found}{}}{}
}

%%
%% 앞표지 생성
%%
\newcommand{\makefrontcover}{%
    \renewcommand{\baselinestretch}{1.3}%
    \thispagestyle{empty} \noindent%
    \begin{minipage}[b][20mm][b]{\textwidth}
        \begin{center}
            \Large
            \if@isDoctor
                박사 학위논문\\ Ph. D. Dissertation
            \else
                석사 학위논문\\ Master's Thesis
            \fi
        \end{center}
    \end{minipage}\\[30mm]
    \begin{minipage}[t][70mm][t]{\textwidth}
        \begin{center}
            \fontsize{21pt}{21pt}\selectfont  \@titleKor \\[21pt]
            \Large \@titleEng
        \end{center}
    \end{minipage}\\[30mm]
    \begin{minipage}[c][55mm][c]{\textwidth}
        \begin{center}
            \Large
            \ifthenelse{\equal{\@authorKorFN}{}}
            {\@authorEng\ (\@authorChn) \\}
            {\@authorKor\   (\@authorChn\ \
            \@authorEng) \\}
            \@affFullNameKor \\ \@affFullNameEngCover
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[c][17mm][c]{\textwidth}
        \begin{center}
            \Large \@kaist
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[c][17mm][c]{\textwidth}
        \begin{center}
            \Large \@gradYear
        \end{center}
    \end{minipage}
    \newpage
}
  
%%
%% 속표지 생성
%%
\renewcommand{\maketitle}{%
    \renewcommand{\baselinestretch}{1.3}%
    \thispagestyle{empty} \noindent
    \vspace{60mm}\\[0mm]
    \begin{minipage}[t][70mm][t]{\textwidth}
        \begin{center}
            \fontsize{21pt}{21pt}\selectfont  \@titleKor \\[21pt]
            \Large \@titleEng
        \end{center}
    \end{minipage}
    \newpage
}

%%
%% 학위논문 제출승인서 및 심사완료 검인서 생성
%%
\newcommand{\makeapproval}{%
    % 학위논문 제출승인서
    \renewcommand{\baselinestretch}{1.3}
    \hyphenation{institute department division program} % word division 방지
    \thispagestyle{empty} \noindent
    \begin{minipage}[c][25mm][c]{\textwidth}
        \begin{center}
            \fontsize{21pt}{21pt}\selectfont \@titleEng \\ \vfill
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[c][17mm][c]{\textwidth}
        \begin{center}
            \Large
            \begin{tabular}{lcl}             % 학위논문 지도교수 영문이름
                \@ifundefined{@advisorCooprEng}
                    % 단독지도교수이면 Advisor 하나만 출력
                    {Advisor & : & Professor\ \ \@advisorMajorEng}
                    % 공동지도교수이면 Major,Co-Advisor 둘 다 출력
                    {Major Advisor & : & Professor\ \ \@advisorMajorEng \\
                     Co-Advisor & : & Professor\ \ \@advisorCooprEng}
            \end{tabular} \vfill
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[c][8mm][c]{\textwidth}
        \begin{center}
        \Large by \vfill
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[t][46mm][t]{\textwidth}
        \Large
        \begin{center}
                    \@authorEngFN, \@authorEngGN \\  % 저자 영문이름
            \@affFullNameEngCover \\         % 학과/전공명 (표지용)
            \@kaist                          % 학교명 KAIST
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[t][40mm][t]{\textwidth}
    	\Large
    	\hspace*{10mm}
    	A thesis submitted to the faculty of \@kaist\ 
    	in partial fulfillment of the requirements 
    	for the degree of \@degreeName in the \@affFullNameEng.
    	The study was conducted in accordance with Code of Research Ethics\footnotemark[1].
    \end{minipage}\\[0mm]
    \mbox{} \hfill
    \begin{minipage}[t][75mm][t]{.55\textwidth}
        \linespread{1.6}
        \Large \noindent
        \@approvalYear. \@approvalMonth. \@approvalDay. \\ % 제출승인일자
        Approved by \\
        Professor \@advisorSigned \\          % 제출승인서에 서명한 교수이름
        % 단독 또는 주 지도교수가 서명하면 Major-,  부 지도교수가 서명하면 Co-
        \@ifundefined{@advisorCooprEng}{[Advisor]}%
            {\ifthenelse{\equal{\@advisorSigned}{\@advisorMajorEng}}%
                {[Major Advisor]}{[Co-Advisor]}} \\[24pt]
        \makebox[.8\textwidth][r]{\hrulefill} 
    \end{minipage}
    	\footnotetext[1]{\normalsize Declaration of Ethical Conduct in Research: I, as a graduate student of KAIST, hereby declare that I have not committed any acts that may damage the credibility of my research. These include, but are not limited to: falsification, thesis written by someone else, distortion of research findings or plagiarism. I affirm that my thesis contains honest conclusions based on my own careful research under the guidance of my thesis advisor.}



    % 학위논문 심사완료 검인서
    \newpage \thispagestyle{empty} \noindent
    \begin{minipage}[c][34mm][c]{\textwidth}
        \begin{center}
            \fontsize{21pt}{21pt}\selectfont \@titleKor \\          % 학위논문 한글제목
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[c][17mm][c]{\textwidth}
        \begin{center}
            \LARGE 
             \ifthenelse{\equal{\@authorKorFN}{}}
             {\@authorEng}
             {\@authorKor}  % 저자 한글이름
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[c][30mm][c]{\textwidth}
        	\begin{center}
        		\Large 위 논문은 한국과학기술원
        		\ifthenelse{\boolean{@isDoctor}}{박사}{석사}학위논문으로\linebreak
        		학위논문심사위원회에서 심사 통과하였음.
	\end{center}
    \end{minipage}\\[28mm]
    \begin{minipage}[t][50mm][b]{\textwidth}
        \Large
        \begin{flushright}
                        
	\begin{tabular}{rcl}                 % 심사위원명단
                \multicolumn{3}{r}{\@refereeYear 년 \@refereeMonth 월 \@refereeDay 일 \hspace*{15mm}}\mbox{\ }
                \@ifundefined{@refereeChief}{}
                    {\\[30pt] 심사위원장 & \ \makebox[\width][r]{\@refereeChief}  & \ (인) \hspace*{15mm}}
                \@ifundefined{@refereeSecond}{}
                    {\\[15pt] 심사위원   & \ \makebox[\width][r]{\@refereeSecond} & \ (인) \hspace*{15mm}}
                \@ifundefined{@refereeThird}{}
                    {\\[15pt] 심사위원   & \ \makebox[\width][r]{\@refereeThird}  & \ (인) \hspace*{15mm}}
                \@ifundefined{@refereeFourth}{}
                    {\\[15pt] 심사위원   & \ \makebox[\width][r]{\@refereeFourth} & \ (인) \hspace*{15mm}}
                \@ifundefined{@refereeFifth}{}
                    {\\[15pt] 심사위원   & \ \makebox[\width][r]{\@refereeFifth} & \ (인) \hspace*{15mm}}
            \end{tabular}
        \end{flushright}
    \end{minipage} \hfill \newpage
}

%%
%% 초록(abstract)페이지 생성
%%
\newcounter{pagemarker}                           % 페이지 번호 임시 저장용
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}} % 총 페이지 수 계산용
\renewenvironment{abstract}{%
    \pagenumbering{roman}                        % 로마자 페이지 시작
    \thispagestyle{plain}%
    \newcommand{\@tempbreak}{}                   % \linebreak 명령 보관용
    \let\@tempbreak\linebreak
    \renewcommand{\linebreak}{\ }                % \linebreak -> 공백 대체
    \newlength{\@thesisinfowidth}
    \setlength{\@thesisinfowidth}{\textwidth}    % 논문정보박스 사이즈는
    \addtolength{\@thesisinfowidth}{-30mm}       % 텍스트 폭보다 30mm 작게
    \noindent
    \parbox[t]{30mm}{\Large \textsf{\@degreeCode \\ \@studentID}}%
    \raisebox{3pt}{\begin{minipage}[t]{\@thesisinfowidth}
        \normalsize \sffamily
        \ifthenelse{\equal{\@authorKorFN}{}}
        {}
        {\@authorKorFN\ \@authorKorGN.}           % 저자 한글이름
        \@authorEngFN,\ \@authorEngGN.           % 저자 영문이름
        \@titleEng. \@titleKor.                 % 학위논문 영문 및 한글제목
        \@affFullNameEng. \@gradYear.           % 학과/전공명, 졸업년도
        \@lastPage p.                           % 총 페이지 수 -> 참고문헌 끝
        \@ifundefined{@advisorCooprEng}         % 공동지도교수 유무판정
            {Advisor Prof.~\@advisorMajorEng.} % 단독지도교수 영문이름
            {Advisors Prof.~\@advisorMajorEng, % 공동 주 지도교수 영문이름
             Prof.~\@advisorCooprEng.}         % 공동 부 지도교수 영문이름
        \ifthenelse{\boolean{@isKorean}}
            {}{Text in English.}               % 본문이 영어인 경우 명시
    \end{minipage}}\\[16pt]
    \begin{center} \textbf{ABSTRACT} \end{center}      % 초록명 -> Abstract
    \hspace*{5mm}
    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\abstractname}% 초록을 목차(TOC)에 삽입
}{  \setcounter{pagemarker}{\value{page}}        % 마지막 페이지 번호를 저장
    \addtocounter{pagemarker}{1}                 % 백색별지분을 고려
    \newpage \pagenumbering{arabic}              % 페이지 아라비아 수자 포맷
    \let\linebreak\@tempbreak                    % \linebreak 명령 복원
}

%%
%% 목차 일괄 생성
%%
\newcommand{\makecontents}{%            % TOC, LOT, LOF 생성
    \tableofcontents
    \listoftables
    \listoffigures
}

%%
%% 한글요약문 생성 - 영문논문의 경우만 해당
%%
\newenvironment{summary}{%              % 요약문 생성 환경
    \newcommand{\@tempbreak}{}
    \let\@tempbreak\linebreak
    \renewcommand{\linebreak}{\ }      % \linebreak 명령 바꿔치기
    \if@isKorean
    \else
        \chapter*{Summary}
        \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Summary (in Korean)}
        \begin{quote}
            \begin{center}
                \noindent \textsf{\Large \@titleEng} \\[6mm]
            \end{center}
        \end{quote}% \setlength{\parindent}{0pt}
    \fi
}{  \let\linebreak\@tempbreak          % \linebreak 명령 되돌리기
}

\newcommand{\summarykorean}{%           % ver 0.1 요약문 생성 명령
    \renewcommand{\linebreak}{\ }      % 차후 버젼에서 삭제 예정
    \ifx\@textlang\@english
        \chapter*{요 약 문}
        \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Summary (in Korean)}
        \begin{center}
            \noindent\textsf{\Large \@titleKor} \\[6mm]
        \end{center}% \setlength{\parindent}{0\p@}
    \fi
}

%%
%% 감사의 글 및 이력서 생성
%%

\newcommand{\acknowledgement}[1][default]{%     % 이력서
    \newcommand{\@acklang}{#1}
    \ifthenelse{\equal{#1}{default}}            % 아무 옵션을 설정하지 않으면
        {\let\@acklang\@textlang}{}           % 논문 언어대로 이력서 언어설정
    \ifthenelse{\equal{\@acklang}{\@korean}}
        {\chapter*{감 사 의 글}}                 % korean  옵션일 경우
        {\chapter*{Acknowledgement}}         % english 옵션일 경우
}

\newcommand{\curriculumvitae}[1][default]{%     % 이력서
    \newcommand{\@ccvlang}{#1}
    \ifthenelse{\equal{#1}{default}}            % 아무 옵션을 설정하지 않으면
        {\let\@ccvlang\@textlang}{}           % 논문 언어대로 이력서 언어설정
    \ifthenelse{\equal{\@ccvlang}{\@korean}}
        {\chapter*{이 력 서}}                 % korean  옵션일 경우
        {\chapter*{Curriculum Vitae}}         % english 옵션일 경우
}

%%
%% 이력서 내부 요소 생성
%%
    \newenvironment{personaldata}{%            % 개인정보
        \begin{list}{}{%
            \setlength{\labelwidth}{70pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{0pt}
            \renewcommand{\makelabel}[1]{\textgt{##1\ \ :\ }}}
        \newcommand{\name}[1]{%               % 이름
            \ifx\@ccvlang\@korean
                \def\@arg{[이\hfill름]}
            \else
                \def\@arg{[Name\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\dateofbirth}[3]{%        % 생년월일
            \ifx\@ccvlang\@korean
                \def\@arg{[생\hfill년\hfill월\hfill일]}
                \expandafter\item\@arg ##1년 ##2월 ##3일
            \else
                \def\@arg{[Date of Birth\hfill]}
                \expandafter\item\@arg \@dateUSenglish{##1}{##2}{##3}
            \fi }
        \newcommand{\birthplace}[1]{%         % 출생지
            \ifx\@ccvlang\@korean
                \def\@arg{[출\hfill생\hfill지]}
            \else
               \def\@arg{[Birthplace\hfill]}
           \fi
           \expandafter\item\@arg ##1}
        \newcommand{\domicile}[1]{%           % 본적지
            \ifx\@ccvlang\@korean
                \def\@arg{[본\hfill적\hfill지]}
            \else
                \def\@arg{[Domicile\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\address}[1]{%            % 주소지
            \ifx\@ccvlang\@korean
                \def\@arg{[주\hfill소]}
            \else
                \def\@arg{[Address\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\email}[1]{%              % E-mail
            \ifx\@ccvlang\@korean
                \def\@arg{[E-mail\hfill주\hfill소]}
            \else
                \def\@arg{[E-mail\hfill]}
            \fi
          \expandafter\item\@arg ##1}
        %이력서에 집어넣을 추가 필드가 필요하면 위를 참고하여 만들어 쓸 것.
        %\newcommand{(필드명령)}[1]{%
        %   \ifx\@ccvlang\@korean
        %       \def\@arg{[(한글필드명)]}
        %   \else
        %       \def\@arg{[(영문필드명)]}
        %   \fi
        %   \expandafter\item\@arg ##1}
    }{\end{list}}

    \newenvironment{education}{%               % 학력
        \vspace*{5mm} \noindent
        \ifx\@ccvlang\@korean
            \begin{center}
                \makebox[2cm][s]{\textbf{\large 학 력}}
            \end{center}
        \else \textbf{\large Educations} \fi
        \begin{list}{}{%
            \setlength{\labelwidth}{95pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{0pt}
            \renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
    }{\end{list}}

    \newenvironment{career}{%                  % 경력
        \vspace*{5mm} \noindent
        \ifx\@ccvlang\@korean
            \begin{center}
                \makebox[2cm][s]{\textbf{\large 경 력}}
            \end{center}
        \else \textbf{\large Career} \fi
        \begin{list}{}{%
            \setlength{\labelwidth}{95pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
    }{\end{list}}

    \newcounter{itemnum1}
    \newenvironment{activity}{%                % 학회활동
        \vspace*{5mm} \noindent
        \ifx\@ccvlang\@korean
            \begin{center}
                \makebox[2cm][s]{\textbf{\large 수 상 경 력}}
            \end{center}
        \else \textbf{\large Academic Activities} \fi
        \begin{list}{}{%
            \usecounter{itemnum1}
            \setlength{\labelwidth}{50pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
    }{\end{list}}

    \newcounter{itemnum2}
    \newenvironment{publication}{%             % 연구업적
        \vspace*{5mm} \noindent
        \ifx\@ccvlang\@korean
            \begin{center}
                \makebox[2cm][s]{\textbf{\large 연 구 업 적}}
            \end{center}
        \else \textbf{\large Publications} \fi
        \begin{list}{}{%
            \usecounter{itemnum2}
            \setlength{\labelwidth}{1.5em}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}{\textgt{\arabic{itemnum2}.\ }}}
    }{\end{list}}

%%
%% 헤딩 재설정
%%
\renewcommand{\contentsname}{%
    \if@isKorean 목 차       \else Contents        \fi}
\renewcommand{\listfigurename}{%
    \if@isKorean 그 림 목 차 \else List of Figures \fi}
\renewcommand{\listtablename}{%
    \if@isKorean 표 목 차    \else List of Tables  \fi}
\renewcommand{\bibname}{%
    \if@isKorean 참 고 문 헌 \else References      \fi}

%%
%% \part 재정의 - 아예 쓰지 못하게 막아버림. 이 명령을 호출하면 에러 발생.
%%
\renewcommand\part{%
    \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ClassError{kaist}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}
\def\@spart#1{%
    \ClassError{kaist}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}

%%
%% \chapter 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\chapter{%
    \if@openright\cleardoublepage\else\clearpage\fi
%   \thispagestyle{plain}%
    \global\@topnum\z@
    \@afterindentfalse
%   \if@isKorean \parindent\z@ \else \fi % <-- 추가할지 여부 고민중
    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
        \refstepcounter{chapter}%
        \typeout{\@chapapp\space\thechapter.}%
        \addcontentsline{toc}{chapter}{%
            \if@isKorean
                \protect\numberline{제 \thechapter\ 장}#1
            \else
                \protect\numberline{Chapter \thechapter.}#1
            \fi
        }% <-- 목차에 나타나는 형식 - 변경사항
    \else
        \addcontentsline{toc}{chapter}{#1}%
    \fi
    \chaptermark{#1}%
    \addtocontents{lof}{\protect\addvspace{10\p@}}%
    \addtocontents{lot}{\protect\addvspace{10\p@}}%
    \if@twocolumn
        \@topnewpage[\@makechapterhead{#2}]%
    \else
        \@makechapterhead{#2}%
        \@afterheading%
    \fi
}
\def\@makechapterhead#1{% <-- 전체 변경
    \vspace*{10\p@}
    {\centering \parindent\z@ \LARGE\bfseries
    \ifthenelse{\equal{\@textlang}{korean}}
        {제\hspace{1.4ex}\thechapter\hspace{1.4ex}장\hspace{2ex}}
        {Chapter\hspace{1.4ex}\thechapter.\hspace{1ex}}
    #1\par}
    \vspace*{20\p@}
}
\def\@schapter#1{%
    \if@twocolumn
        \@topnewpage[\@makeschapterhead{#1}]%
    \else
        \@makeschapterhead{#1}%
        \@afterheading
    \fi}
\def\@makeschapterhead#1{% <-- 전체 변경
    \vspace*{10\p@}
    {\centering \parindent\z@ \LARGE\bfseries #1\par}
    \vspace*{20\p@}
}

%%
%% \tableofcontents 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\tableofcontents{%
	\thispagestyle{plain}
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \pagenumbering{roman}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\contentsname} % 목차(TOC)에 추가
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% \listoftables 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoftables{%
	\thispagestyle{plain}
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
    \pagenumbering{roman}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listtablename}% 목차(TOC)에 추가
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% \listoffigures 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoffigures{%
	\thispagestyle{plain}
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
    \pagenumbering{roman}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listfigurename}% 목차(TOC)에 추가
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% 목차에 나오는 형식 - report 클래스로부터 복사하여 일부 수정
%%

\newcommand{\l@content}{\large\bf\@dottedtocline{1}{0em}{0em}}

\renewcommand*\l@chapter[2]{%
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip 1.0em \@plus\p@
        \if@isKorean                     % <-- 변경 부분
            \setlength\@tempdima{5.0em} % korean  옵션일 때는 5.0em
        \else
            \setlength\@tempdima{6.5em} % english 옵션일 때는 1.5em
        \fi
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \large \sffamily \bfseries
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi}
    
    
\if@isKorean % 한글이면 각종 치수를 변경
    \renewcommand*\l@section{\@dottedtocline{1}{2.7em}{2.3em}}
    \renewcommand*\l@subsection{\@dottedtocline{2}{5.0em}{3.2em}}
    \renewcommand*\l@subsubsection{\@dottedtocline{3}{8.2em}{4.1em}}
    \renewcommand*\l@paragraph{\@dottedtocline{4}{11.2em}{5em}}
    \renewcommand*\l@subparagraph{\@dottedtocline{5}{13.2em}{6em}}
\else \fi     % 영문이면 가만히 내버려둠

%%
%% thebibliography 환경 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewenvironment{thebibliography}[1]{%
    \chapter*{\bibname}%
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\bibname}%
    \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m%
}{  \label{paperlastpagelabel}     % <-- 추가 부분: 마지막 페이지 위치 지정
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}

%%
%% 한국식 날짜 표기 -> 영문식 날짜 표기
%%
\newcommand{\@dateUSenglish}[3]{%  % 미국식 날짜 표기
    \newcommand{\@year}{#1}%
    \newcommand{\@month}{#2}%
    \newcommand{\@day}{#3}%
    \ifcase\@month \or
        January \or February \or March \or April \or May \or June \or
        July \or August \or September \or October \or November \or December \fi
    \@day, \@year
}
\newcommand{\@dateBRenglish}[3]{%  % 영국식 날짜 표기
    \newcommand{\@year}{#1}%
    \newcommand{\@month}{#2}%
    \newcommand{\@day}{#3}%
    \@day\ifcase\@day \or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or th\fi
    \space\ifcase\@month \or
        January\or February\or March\or April\or May\or June\or
        July\or August\or September\or October\or November\or December\fi,
    \@year
}
