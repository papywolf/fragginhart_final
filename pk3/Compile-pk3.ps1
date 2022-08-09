function Compile-pk3 {
    $mapname = "fragginhart_final"
    $localrepo ="F:\GtkRadiant-1.6.6-20180422\etdev\git\fragginhart_final"

    Remove-Item -Path "$localrepo\pk3\maps\fragginhart_final" -Recurse -force
    Copy-Item -Path "$localrepo\maps\fragginhart_final" -Destination "$localrepo\pk3\maps\fragginhart_final" -Recurse

    foreach ($file in $(gc $localrepo\pk3\pk3.list)) {
        if ($(Test-Path -Path "$localrepo\pk3\$file")){
            Remove-Item -Path "$localrepo\pk3\$file"
            }
        
        if ($(Test-Path -Path "$localrepo\$file")){
            Copy-Item -Path "$localrepo\$file" -Destination "$localrepo\pk3\$file" -Recurse
            }
    }
    Get-Date | Out-file "$localrepo\pk3\$mapname.pk3.buld.info.txt"
    Remove-Item -Path "$localrepo\pk3\$mapname.pk3"
    sleep 5
    Compress-Archive -Path $localrepo\pk3\* -DestinationPath "$localrepo\pk3\$mapname.zip"
    sleep 5
    Rename-Item "$localrepo\pk3\$mapname.zip" "$localrepo\pk3\$mapname.pk3"
    copy-Item -Force "$localrepo\pk3\$mapname.pk3" "$localrepo\$mapname.pk3"
}

Compile-pk3