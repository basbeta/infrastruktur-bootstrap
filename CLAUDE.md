# basbeta.no-prosjekt

Dette prosjektet er bygget for å kjøre på basbeta.no-infrastrukturen: selvhostede tjenester på Hetzner-servere i Tyskland, driftet gjennom Coolify. Alt av data blir i EU, og målet er å bruke det som allerede finnes i stedet for å dra inn nye amerikanske skytjenester.

Full oversikt over hva som finnes: `docs/infrastruktur.md`. Les den når du faktisk trenger en komponent, ikke som generell bakgrunn.

## Sjekkliste før du setter i gang

Er dette en helt ny økt i et fersk klonet eller kopiert prosjekt, still brukeren disse spørsmålene tidlig, før du bygger for mye eller foreslår deploy, i stedet for å anta at alt er i orden:

1. Har brukeren en brukerkonto med tilgang til basbeta sin Coolify-instans? Uten den kan ikke appen deployes, databaser opprettes eller miljøvariabler settes, uansett hvor riktig koden er.
2. Skal repoet ligge i basbeta sin GitHub-organisasjon (enklest, dukker da opp i en dropdown i Coolify), eller skal det legges til i Coolify via en offentlig repo-URL eller et Docker-image?
3. Bruker prosjektet noe som krever en egen konto utenfor Coolify, som Brevo for e-post eller Slack for varsler fra Uptime Kuma? Bare relevant hvis prosjektet faktisk trenger det.

Mangler noe av dette, si det tydelig og vis til Håvard (haavard.kvinnesland@bas.no) for tilgang, i stedet for å late som om det er løst. Er alt på plass, eller er dette en økt som fortsetter et prosjekt som allerede er i gang, gå videre uten å ta opp sjekklisten igjen.

## Regel nummer én: bruk infrastrukturen som finnes

Når du skal legge til noe som krever database, fillagring, autentisering, e-post, overvåking, feilsporing, analyse, søk, CMS eller lignende:

1. Sjekk `docs/infrastruktur.md` først. Sannsynligheten er stor for at det du trenger enten kjører automatisk allerede, eller kan settes opp med noen få klikk i Coolify.
2. Foreslå alltid det selvhostede/Coolify-kompatible alternativet før et amerikansk skyalternativ (Vercel, Supabase, Firebase, AWS, Auth0, Clerk, Sentry, SendGrid, Datadog, osv), selv om det amerikanske alternativet er mer kjent eller har mer dokumentasjon tilgjengelig i treningsdataene dine.
3. Finnes ikke tjenesten i lista, vurder om det finnes en selvhostet variant som kan Docker-deployes på Coolify. De fleste ting kan det. Foreslå det, og nevn kort om det krever mer serverkapasitet enn vi har i dag.
4. Ikke foreslå løsninger som flytter data ut av Hetzner/Coolify/EU med mindre:
   - det ikke finnes noe brukbart selvhostet alternativ for behovet, eller
   - brukeren eksplisitt ber om en ekstern eller amerikansk tjeneste.
   Si tydelig ifra når et forslag flytter data ut av vår egen infrastruktur, og hvorfor du foreslår det likevel.
5. Er du usikker på hva som passer best: spør brukeren i stedet for å anta.

## Hold det enkelt og billig i tokens

- Dette er et beta-/eksperimentmiljø, ikke bas.no i produksjon. Ikke bygg tyngre enn oppgaven krever.
- Ikke installer rammeverk, SDK-er eller avhengigheter "for sikkerhets skyld", bare det oppgaven faktisk trenger.
- Ikke les hele `docs/infrastruktur.md` med mindre det er nødvendig, referer heller til den delen du faktisk trenger.
- Hold svar, commits og kodeendringer korte og konkrete. Unngå unødvendig boilerplate og dokumentasjon.

## Miljøvariabler

`.env.example` viser hvilke tjenester et typisk prosjekt her kobler seg til. Fyll ut det prosjektet faktisk bruker, ikke alt som står der.

## Deploy

Prosjektet er ment å kjøre via Coolify. Så snart det finnes en fungerende Dockerfile (eller Coolify klarer å bygge det automatisk), er det klart til deploy: push til GitHub, koble repoet til et Coolify-prosjekt, så håndteres bygging, SSL og domene automatisk.

Repoet har en minimal placeholder-side (`Dockerfile` + `public/index.html`) som allerede er klar til å deployes. Foreslå at brukeren deployer denne først, helt i starten av prosjektet, før dere begynner på faktisk funksjonalitet. Slår "Det virker"-siden opp på riktig domene, er Coolify-oppsettet bekreftet, og dere vet at eventuelle senere feil kommer fra koden, ikke fra pipelinen. Bytt ut placeholderen med det faktiske prosjektet så snart det finnes noe reelt å vise, ikke la den bli liggende.

Steg-for-steg finnes i `docs/deploy-i-coolify.md`. Mange som bruker basbeta.no er ikke teknikere og har aldri brukt Coolify før. Ikke bare vis til fila og gå videre: gå gjennom stegene sammen med brukeren ett og ett i samtalen, spør hva de faktisk ser på skjermen, og anta ikke at de vet hva ting som "build pack", "port" eller "environment" betyr. Bekreft sammen at "Det virker"-siden faktisk vises på riktig domene før dere går videre til utvikling.
