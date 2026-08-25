# Koble prosjektet til Coolify, steg for steg

Denne guiden er skrevet for deg som aldri har brukt Coolify før, og ikke nødvendigvis er utvikler. Du trenger ikke forstå hva som skjer i bakgrunnen, bare følge stegene. Gjør du dette med placeholder-siden i `public/index.html` med en gang, vet du at alt fungerer før du begynner å utvikle noe faktisk.

Coolify-grensesnittet kan endre seg litt mellom versjoner, så et fåtall detaljer under kan avvike fra det du ser. Er du usikker på et steg, spør Claude om å tolke det du ser på skjermen, eller ta kontakt med Håvard (haavard.kvinnesland@bas.no).

## Før du starter

Du trenger en brukerkonto med tilgang til basbeta sin Coolify-instans. Har du ikke det, spør Håvard før du fortsetter, resten av denne guiden forutsetter at du er logget inn.

## Slik oppretter du appen, klikk for klikk

1. Klikk **Projects** i menyen til venstre.
2. Klikk **+ Add** oppe til høyre for å opprette et nytt prosjekt.
3. Gi prosjektet et navn i vinduet som dukker opp (f.eks. samme navn som appen din), la beskrivelsen stå tom om du vil, og klikk **Continue**. Prosjektet får automatisk et miljø som heter **production**.
4. Du havner på prosjektets Resources-side. Klikk **+ Add Resource**.
5. Under **Applications → Git Based**, klikk **Private Repository (with GitHub App)**.
6. Velg GitHub-appen som heter **basbeta** (dukker det opp flere apper i lista, ikke velg en annen).
7. Velg riktig repo fra **Repository**-feltet (f.eks. det du opprettet fra basbeta-bootstrap-malen), og trykk **Load Repository** hvis konfigurasjonsfeltene ikke dukker opp av seg selv.
8. Under **Configuration**: la **Branch** stå som **main**. Bytt **Build Pack** fra standardvalget **Nixpacks** til **Dockerfile**, det bytter ikke Coolify til automatisk. Sjekk samtidig **Port**-feltet, det står som standard på **3000**, og må endres til **80**, siden det er porten placeholder-siden (og de fleste enkle nginx-baserte oppsett) faktisk lytter på.
9. Klikk **Continue**. Ressursen opprettes, og du havner på konfigurasjonssiden for den (Configuration → General).
10. Bytt **Name** øverst til noe fornuftig, det starter som en litt kryptisk autogenerert tekst.
11. I feltet **Domains**, bytt ut den midlertidige adressen Coolify satte inn (noe ala `http://...sslip.io`) med `https://ØNSKET-NAVN.basbeta.no`, og trykk **Save**.
12. Klikk **Deploy** oppe til høyre. Status vil vise **Exited** i rødt helt til første deploy er ferdig, det er normalt, ikke noe har gått galt ennå.
13. **Vent et par minutter.** Bygging og utstedelse av SSL-sertifikat tar litt tid første gang. Statusen kan vise noe som "Running (unknown)" med en varseltrekant en liten stund etterpå, også det er normalt.
14. Åpne domenet du satte opp i nettleseren. Ser du "Det virker.", er alt riktig koblet, og du er klar til å begynne å utvikle. Ser du en sertifikatadvarsel (usikker/utrygg tilkobling) de aller første minuttene, vent litt til og prøv igjen.

Miljøvariabler (database, S3, e-post og lignende, se `.env.example`) legger du inn under fanen **Environment Variables** i samme meny, når prosjektet faktisk trenger dem.

## Hvis noe går galt

- **Bygget feiler:** kopier feilmeldingen fra byggeloggen (fanen **Logs** eller **Deployments**) og spør Claude om å tolke den.
- **Domenet svarer ikke etter noen minutter:** dobbeltsjekk at **Build Pack** faktisk er satt til **Dockerfile** (ikke Nixpacks), at **Port** er satt til **80**, og at domenet under General er lagret riktig.
- **Usikker på tilganger, kontoinnstillinger eller hvilket prosjekt/miljø du skal bruke:** spør Håvard i stedet for å gjette deg videre. Feil her er vanskeligere å rydde opp i enn feil i selve koden.
