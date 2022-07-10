# Helvault Free CSV Converter
## A quick script to turn Helvault free-tier CSV's to something more detailed via Scryfall API. 

### About
The Helvault app has the ability to freely export a CSV of your "binders" / card collection. However, without paying for an upgrade, the default export only shows the foil status, name, and scryfall ID of the card. Thankfully, with the help of Scryfall's API and some poweshell, we can convert this to something far more useful.

### How-to
1. Export the CSV of your binder/list/collection from Helvault and place the exported CSV on your PC.
2. Download ```helvault-convert.ps1```  to your PC
3. Edit ```helvault-convert.ps1```  with your text editor of choice. You will need to change the path of ```$helvaultcsv``` to the path of your exported file from step 1.
4. Open powershell and navigate to the directory where ```helvault-convert.ps1``` is stored.
5. type ``` .\helvault-convert.ps1``` into the console to run the script.
6. By default, it will export the detailed CSV to your desktop. If you changed the directory of ```$scryfallExportPath``` then the CSV will be there instead.

### Notes
I'd like to flesh this out a bit so I can easily convert the Helvault exports to Deckbox and the like. For now, this will do. 
