#region GENERATE BOILERPLATE
function WriteHeaderBoilerPlate {
    param (
        $ACFilePath
    )

    $ClassCat = ""
    switch -Exact ($Category) {
        'JNR' { $ClassCat = "junior"; Break }
        'SNR' { $ClassCat = "senior"; Break }
        Default {}
    }

    # Write \documentclass command
    $DocClassCommand = "\documentclass[lmodern," + $ClassCat + ',' + $Round.ToLower() + "]{astrochallenge}" + [System.Environment]::NewLine
    Add-Content -Path $ACFilePath -Value $DocClassCommand

    # Use specified Day 1 date
    Add-Content -Path $ACFilePath -Value $("%%%%% AstroChallenge Day 1 date; change as necessary (YYYY-MM-DD format) %%%%%" + [Environment]::NewLine + "\setacpaperdate{${Day1}}")

    # \begin{document}
    Add-Content -Path $ACFilePath -Value $("\begin{document}" + [System.Environment]::NewLine + "\maketitle" + [System.Environment]::NewLine)
}

function WriteMCQBoilerPlate {
    param ($ACFilePath)

    # \begin{questions}
    Add-Content -Path $ACFilePath -Value $("\begin{questions}" + [Environment]::NewLine)

    $MCQ = @"
\question{
    \begin{choices}
        \choice
        \choice
        \choice
        \choice
        \correctchoice
    \end{choices}
    \begin{solution}

    \end{solution}
}
\filbreak
"@

    for ($i = 0; $i -lt 50; $i++) {
        $MCQ | Add-Content -Path $ACFilePath
    }

    # \end{questions}

    $PrintAnswers = @"
\ifprintanswers
    \printkeytable
\fi
    "@

    Add-Content -Path $ACFilePath -Value $("\end{questions}" + [Environment]::NewLine) + $PrintAnswers
}


function WriteTeamBoilerPlate {
    param ($ACFilePath)
    $TeamQ = @"
\section{}
\subsection{}
\begin{questions}
    \question[]{
        
    }
\end{questions}
\clearpage
"@
    for ($i = 0; $i -lt 5; $i++) {
        $TeamQ | Add-Content -Path $ACFilePath
    }
}
#endregion

#region LaTeX header code: doc class, maketitle, etc.
function WriteBoilerPlate {
    param ($Category, $Round, $ACFilePath)

    Write-Host "Writing AstroChallenge ${Year} ${Category} ${Round} LaTeX file..."

    WriteHeaderBoilerPlate -ACFilePath $ACFilePath

    switch -Exact ($Round) {
        'MCQ' { WriteMCQBoilerPlate -ACFilePath $ACFilePath; Break }
        'Team' { WriteTeamBoilerPlate -ACFilePath $ACFilePath; Break }
        Default {}
    }

    # \end{document}
    Add-Content -Path $ACFilePath -Value "\end{document}"

    Write-Host "Done."
}
#endregion

#region CHECK & CREATE DIRECTORY: ACTUAL SCRIPT EXECUTION BEGINS HERE
# Assume this script's file path is */scripts/createpapers.ps1, and check if a */typeset directory exists in its parent directory.
# If not, offer to create said directory, and then move to file writing. If directory exists, set a boolean value saying so.

$ProjDir = Split-Path -Path $PSScriptRoot -Parent
$TypesetDir = Join-Path -Path $projDir -ChildPath "typeset"

[bool] $hasTypesetDir = Test-Path $typesetDir

if (-Not($hasTypesetDir)) {
    Write-Host "Creating LaTeX files directory: "$typesetDir
    New-Item -Path $typesetDir -ItemType "directory"
}
else {
    Write-Host "LaTeX files directory ""$typesetDir"" present."
}
#endregion

#region ASK AND SAVE YEAR
$Day1 = Read-Host -Prompt "When is AstroChallenge Day 1? (YYYY-MM-DD format)"
$Year = $($Day1 -split "-")[0]
#endregion

#region CREATE ALL FILES
function CheckAndCreateFile {
    param (
        $ACFilePath
    )
    if (-Not $(Test-Path $ACFilePath) ) {
        Write-Host "${ACFilePath} was not found; creating it now."
        New-Item -Path $ACFilePath -ItemType File
    }
    else {
        Write-Host "${ACFilePath} already present; nothing was done."
    }
}

for ($i = 0; $i -lt 7; $i++) {
    $Category = ""
    $Round = ""
    $PaperName = ""
    $CurrentPath

    # DEFINE CATEGORIES
    if ($i -lt 2) {
        $Category = "JNR"
    }
    else {
        $Category = "SNR"
    }

    # DEFINE ROUND
    switch ($i) {
        0 { $Round = "MCQ" }
        2 { $Round = "MCQ"; Break }
        1 { $Round = "Team" }
        3 { $Round = "Team"; Break }
        4 { $Round = "DAQ"; Break }
        5 { $Round = "OBS_A"; Break }
        6 { $Round = "OBS_B"; Break }
        Default {}
    }

    # CHECK FOR AND CREATE PAPER NAME PRESENCE
    $PaperName = "AC_${Year}_${Category}_${Round}.tex"

    $CurrentPath = CheckAndCreateFile -ACFilePath $(Join-Path -Path $TypesetDir -ChildPath $PaperName)
    WriteBoilerPlate -Category $Category -Round $Round -ACFilePath $CurrentPath
}

# Copy doc class file to typeset directory
Write-Host "Copying document class file..."
Copy-Item -Path ([System.IO.Path]::Combine($ProjDir, 'preambles', 'astrochallenge.cls')) -Destination $TypesetDir

#endregion

$ACPapers
