# INFERIOR MIND

**Beato Mattia**

## Descrizione
Il giocatore deve indovinare un codice segreto di 4 colori premendo i bottoni per selezionare la sequenza da verificare.  
Un **Floating Action Button** consente di verificare la giocata: se la sequenza scelta corrisponde al codice segreto, il gioco segnala la vittoria e genera un nuovo codice.

## Funzionamento
- All'avvio, viene generato casualmente un codice segreto di 4 colori in base alla difficoltà scleta
- Sono presenti **4 bottoni principali**, inizialmente grigi, che cambiano colore, il numero di colori dipende dalla difficoltà
- Il giocatore seleziona la sequenza desiderata e preme il bottone "GUESS" provare ad indovinare.
- dopo ogni verifica i bottoni colorati tornano grigi per indicare la non-scelta.
- Modalità aggiuntive:
  - **Dark Mode:** cambia il tema dell’app.
  - **Color Blind Mode:** mostra numeri sui bottoni per l'accessibilità.
- La difficoltà può essere variata cambiando il numero di colori disponibili.

## Scelte di sviluppo
- **Lista di colori e indici:** per gestire la sequenza selezionata e il codice segreto.
- **Reset a grigio dei bottoni colorati:** per semplicità e chiarezza nell’interazione.
- **Modalità Dark e Color Blind:** attenzione ad usabilità ed accessibilità.
- **Codice modulare e leggibile:** funzioni separate per generare codice, aggiornare colori e controllare la sequenza.

