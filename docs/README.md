# Helvault Free CSV Converter; or, A Tale of Scriptcraft and Frugality

### Part One - The Magic the Gathering Scanning App Helvault is awesome

While looking for a way to manage my ever growing collection of collectable cardboard, I stumbled accross the app Helvault. Tauting a built in, AI driven MTG card scanner, I decided to check it out and was pretty blown away by how good the scanner was. I was able to get through 20 cards in only a minute or two. 

I continued to scan until I was met with a paywall - for $3.99 I could immediately unlock unlimited use of the scanning application. While this may not seem like a bargain to many, with the considerable amount of cards I wanted to scan and the accuracy and speed of the scanner provided, for me personally, it was a no brainer. I purchased it and continued to scan away.

### Part 2. Too good to be true. 

Once I completed scanning my collection, I decided to export it so I could do some further research on my lists. However, even though I had just paid for the premium scanning capabilities, I was greeted with:

<img src="https://user-images.githubusercontent.com/20601593/178140474-558b1fe3-ac29-444a-83a5-f2e089df35c3.png" width="350" height="800">

So yes, even after I had already paid for the scanning capabilities, I was being asked for more money to export my cards in various ways. However, there was a free option, so I figured I'd check it out.

The free export included:
- Card Name
- Foil (boolean)
- Scryfall ID

and that's it. Not very useful at all, especially I have a collection of borderless / showcase cards that share the same name, but have different IDs. Rather then break out my wallet, I decided it was time to check out what [Scryfalls API](https://scryfall.com/docs/api) had available. Looked easy enough, so I went to powershell.

## Part 3. Let the Headbashing Begin

If you already looked at the code, you will probably wonder how I ran into headbashing from a simple Invoke-WebRequest. This is because Poweshell does things the way Powershell likes to do things.

My original command was:

```powershell
Invoke-RestMethod -Method Get -Uri "https://api.scryfall.com/cards/$($card.scryfallid)"  | ConvertFrom-Json | ConvertTo-Csv | Out-File "%userprofile%\desktop\export.csv" -Append
```

I naively assumed that running an ```Invoke-WebRequest``` which should receive a JSON response in powershell would stay a JSON. So my plan was to convert the JSON then convert to CSV and then export via ```Out-File```. But this continued to give me a jumbled mess of a CSV so I started digging a bit more.

Storing the ```Invoke-WebRequest``` output as ```$json``` and then checking it's type, the answer became clear:

![image](https://user-images.githubusercontent.com/20601593/178140734-fa5ee745-e269-442d-93b6-3810490533ba.png)

A-ha! It turns out, when you store an ```Invoke-WebRequst``` powershell automatically turns that into a PSCustomObject. While not what I expected, this actually makes things way easier. With the foreach to go through the loop you get:

```powershell

$helvaultcsv = Import-CSV "%userprofile%\desktop\helvault.csv"

foreach ($card in $helvaultcsv){
Invoke-RestMethod -Method Get -Uri "https://api.scryfall.com/cards/$($card.scryfallid)" | Export-Csv -LiteralPath "%userprofile%\desktop\export.csv" -NoTypeInformation -Append -Force
Start-Sleep -Milliseconds 100
}
```

Scryfall asks in their API to provide 50-100ms of latency between requests, hence the sleep. But after a little bashing, we now have a dataset far more fleshed out just by taking the Scryfall ID of the card(s) and 5 lines of Powershell.

## Part 4. To be continued

I will probably spend a bit more time on this to get it so I can convert the Helvault CSV to something Deckbox.org friendly, as that is my main end goal from this. In the meanwhile, I commented out the script and it's on the main repo page if anyone ever finds themself in the need of this. Otherwise, just a fun example of how 20 minutes of scripting can save you $6 with only a smidge of brain damage caused in the process. 

