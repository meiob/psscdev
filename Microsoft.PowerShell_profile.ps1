<#
    This script is licensed under the MIT License.
    See the full license text at: https://opensource.org/licenses/MIT
    © 2024 Mei Okubo
#> 

function Update-WindowTitle {
    $homeDirectory = [System.Environment]::GetFolderPath("UserProfile")
    $currentDirectory = Get-Location

    if ($currentDirectory -eq $homeDirectory) {
        $currentDirectory = "~"
    } elseif ($currentDirectory -eq "C:\") {
        $currentDirectory = "/"
    } else {
        $currentDirectory = Split-Path -Leaf $currentDirectory.Path
        if ($currentDirectory -eq "C:") {
            $currentDirectory = "/"
        } else {
            $currentDirectory = "$currentDirectory"
        }
    }

    $title = "[$currentDirectory]"
    $host.UI.RawUI.WindowTitle = $title
}

function Test-GitRepository {
    try {
        git rev-parse --is-inside-work-tree 2>$null
        if ($?) {
            return $true
        } else {
            return $false
        }
    } catch {
        return $false
    }
}

function Get-GitBranch {
    if (-not (Test-GitRepository)) {
        return $false
    }

    try {
        $branch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($branch) {
            return $branch
        }
    } catch {
        return $false
    }
    return $false
}

function Get-GitStatus {
    if (-not (Test-GitRepository)) {
        return $false
    }

    try {
        $status = git status --porcelain 2>$null
        if ($status) {
            return "Dirty"
        } else {
            return "Clean"
        }
    } catch {
        return $false
    }
}

# カレントディレクトリが変更されるたびにウィンドウタイトルを更新し、プロンプトを設定する
function Set-Prompt {
    Update-WindowTitle
    $currentDirectory = Get-Location

    $branchName = if (Test-GitRepository) {
        $branch = Get-GitBranch
        if ($branch -ne $false) {
            " ($branch)"
        } else {
            ""
        }
    } else {
        ""
    }

    $gitStatus = if (Test-GitRepository) {
        $status = Get-GitStatus
        if ($status -eq "Dirty") {
            " *"
        } elseif ($status -eq "Clean") {
            ""
        } else {
            ""
        }
    } else {
        ""
    }

    if ($currentDirectory -eq [System.Environment]::GetFolderPath("UserProfile")) {
        $currentDirectory = "~"
    } else {
        $currentDirectory = Split-Path -Leaf $currentDirectory.Path
    }

    # # デバッグ出力
    # Write-Host "Debug: Current Directory = $currentDirectory"
    # Write-Host "Debug: Branch Name = $branchName"
    # Write-Host "Debug: Git Status = $gitStatus"

    "[$currentDirectory]$branchName$gitStatus > "
}

# プロンプト関数を変更
function prompt {
    Set-Prompt
}

# 初回実行
Update-WindowTitle

# PowerShell起動時にホームディレクトリに移動
Set-Location ([System.Environment]::GetFolderPath("UserProfile"))
