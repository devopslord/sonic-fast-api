# Ensure you have the ImportExcel module installed
# Install-Module -Name ImportExcel -Scope CurrentUser

# Define file paths
$bookAPath = "C:\Users\USER\Desktop\Excel\BookA.xlsx"
$bookBPath = "C:\Users\USER\Desktop\Excel\BookB.xlsx"
$outputPath = "C:\Users\USER\Desktop\Excel\UpdatedBookA.xlsx"

# Read data from Excel files
$bookA = Import-Excel -Path $bookAPath
$bookB = Import-Excel -Path $bookBPath

# Ensure column names are consistent
$bookA | ForEach-Object {
    $serverA = $_.Servername

    # Find matching server in BookB
    $match = $bookB | Where-Object { $_.Servername -like "*${serverA}*" }

    if ($match) {
        $_."Resource Group" = $match."Resource Group"
    }
}

# Export the updated data to a new file
$bookA | Export-Excel -Path $outputPath -WorksheetName "UpdatedData" -AutoSize

Write-Host "BookA has been updated and saved to $outputPath"
