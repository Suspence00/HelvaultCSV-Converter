## Helvault CSV Converter
## Converts free-tier Helvault CSV to something more detailed from Scryfall via API

# Replace "%userprofile%\Desktop\helvault.csv" with the path to the exported Helvault CSV
$helvaultcsv = Import-csv "%userprofile%\Desktop\helvault.csv"

# Optional: Replace "C:\Users\XXX\Desktop\scryfall.csv" with the path of where you'd like the export to go. 
# If unchanged, it will export the CSV to your desktop.
$scryfallExportPath = "%userprofile%\Desktop\scryfall.csv"

foreach ($card in $helvaultcsv){
$data = Invoke-RestMethod -Method Get -Uri "https://api.scryfall.com/cards/$($card.scryfallid)" | Export-Csv -LiteralPath $scyfallExportPath -NoTypeInformation -Append -Force

# Scryfall kindly asks for 100ms of delay between API requests, so this does so.
Start-Sleep -Milliseconds 100
}
