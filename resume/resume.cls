%-------------------------
% Resume Document Class
% Based on Jake's Resume template
% Author : Jake Gutierrez
% Based off of: https://github.com/sb2nov/resume
% License : MIT
%
% Do NOT change visual styling here unless intentionally updating
% the shared look for ALL resume variants.
%-------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/07/22 Jake's Resume modular class]

\LoadClass[letterpaper,11pt]{article}

\RequirePackage{latexsym}
\RequirePackage[empty]{fullpage}
\RequirePackage{titlesec}
\RequirePackage{marvosym}
\RequirePackage[usenames,dvipsnames]{color}
\RequirePackage{verbatim}
\RequirePackage{enumitem}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{fancyhdr}
\RequirePackage[english]{babel}
\RequirePackage{tabularx}
\input{glyphtounicode}


%----------FONT OPTIONS----------
% sans-serif
% \usepackage[sfdefault]{FiraSans}
% \usepackage[sfdefault]{roboto}
% \usepackage[sfdefault]{noto-sans}
% \usepackage[default]{sourcesanspro}

% serif
% \usepackage{CormorantGaramond}
% \usepackage{charter}


\pagestyle{fancy}
\fancyhf{} % clear all header and footer fields
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Adjust margins
\addtolength{\oddsidemargin}{-0.5in}
\addtolength{\evensidemargin}{-0.5in}
\addtolength{\textwidth}{1in}
\addtolength{\topmargin}{-0.5in}
\addtolength{\textheight}{1.0in}

\urlstyle{same}

\raggedbottom
\raggedright
\setlength{\tabcolsep}{0in}

% Sections formatting
\titleformat{\section}{
  \vspace{-4pt}\scshape\raggedright\small
}{}{0em}{}[\color{black}\titlerule \vspace{-5pt}]

% Ensure that generate pdf is machine readable/ATS parsable
\pdfgentounicode=1

%-------------------------
% Custom commands

\newcommand{\resumeEducation}[6]{
  \vspace{-2pt}\item
    \begin{tabular*}{0.97\textwidth}[t]{l@{\extracolsep{\fill}}r}
      \textbf{#1} & #2 \\
      \textit{\small#3} & \textit{\small #4} \\
    \end{tabular*}
        \textbf{\small#5:} {\small#6} \\
}


\newcommand{\resumeItem}[1]{
  \item\small{
    {#1 \vspace{-2pt}}
  }
}

\newcommand{\resumeSubheading}[4]{
  \vspace{-2pt}\item
    \begin{tabular*}{0.97\textwidth}[t]{l@{\extracolsep{\fill}}r}
      \textbf{#1} & #2 \\
      \textit{\small#3} & \textit{\small #4} \\
    \end{tabular*}\vspace{-7pt}
}

\newcommand{\resumeSubSubheading}[2]{
    \item
    \begin{tabular*}{0.97\textwidth}{l@{\extracolsep{\fill}}r}
      \textit{\small#1} & \textit{\small #2} \\
    \end{tabular*}\vspace{-7pt}
}

\newcommand{\resumeProjectHeading}[2]{
    \item
    \begin{tabular*}{0.97\textwidth}{l@{\extracolsep{\fill}}r}
      \small#1 & #2 \\
    \end{tabular*}\vspace{-7pt}
}

\newcommand{\resumeSubItem}[1]{\resumeItem{#1}\vspace{-4pt}}

\renewcommand\labelitemii{$\vcenter{\hbox{\tiny$\bullet$}}$}

\newcommand{\resumeSubHeadingNoBulletListStart}{\begin{itemize}[leftmargin=0.15in]}
\newcommand{\resumeSubHeadingListStart}{\begin{itemize}[leftmargin=0.15in, label={}]}
\newcommand{\resumeSubHeadingListEnd}{\end{itemize}}
\newcommand{\resumeItemListStart}{\begin{itemize}}
\newcommand{\resumeItemListEnd}{\end{itemize}\vspace{-5pt}}

% Optional Leadership section flag (variants set \ShowLeadershiptrue when needed)
\newif\ifShowLeadership
\ShowLeadershipfalse

% Role titles variants may override (default = shared experience header)
\newcommand{\BroadAxisRoleTitle}{Software Engineering Intern}

% Default Technical Skills categories — variants may \renewcommand{...}
% Convention: list most important first; trim from the end under space pressure.
\newcommand{\SkillsLanguages}{Python, C++, Go, TypeScript, JavaScript, SQL, HTML/CSS}
\newcommand{\SkillsFrameworks}{React, Next.js, FastAPI, Flask, Tailwind CSS, NumPy, Pandas}
\newcommand{\SkillsCloud}{PostgreSQL, Azure App Service, Azure DevOps, Azure PostgreSQL, Azure Static Web Apps, Azure Blob Storage, AWS (Amazon Bedrock), Supabase, Firebase, GitHub Actions, GCP}
\newcommand{\SkillsTools}{Git, GitHub, Postman, Node.js, Vercel, VS Code}

% Default Relevant Coursework — variants may \renewcommand{\RelevantCoursework}{...}
% Same convention: most important first; trim from the end if the page is tight.
\newcommand{\RelevantCoursework}{Data Structures and Analysis of Algorithms, Computer Organization, Software Engineering, Computer Systems, Programming Languages, Linear Algebra, Discrete Mathematics, Introduction to C++}

% Education block (variants may replace entirely via \renewcommand{\EducationContent}{...})
\newcommand{\EducationContent}{\input{sections/education}}
