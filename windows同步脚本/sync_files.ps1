param (
    [Parameter(Mandatory=$true)]
    [string]$SourceFilePath,
    [Parameter(Mandatory=$true)]
    [string]$TargetFilePath
)

# 定义一个函数，用于同步源文件到目标文件
function SyncFile {
    param (
        [Parameter(Mandatory=$true)]
        [string]$SrcPath,
        [Parameter(Mandatory=$true)]
        [string]$DstPath
    )

    $srcContent = Get-Content -Path $SrcPath -Raw
    Set-Content -Path $DstPath -Value $srcContent -NoNewline
}

# 监控源文件的变化
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = Split-Path $SourceFilePath -Parent
$watcher.Filter = Split-Path $SourceFilePath -Leaf
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite

$onChanged = Register-ObjectEvent -InputObject $watcher -EventName Changed -Action {
    SyncFile -SrcPath $event.SourceEventArgs.FullPath -DstPath $TargetFilePath
}

# 保持脚本运行，直到手动中断
while ($true) { Start-Sleep -Seconds 1 }