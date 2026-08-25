# basbeta-bootstrap

Utgangspunkt for nye AI-utviklede prosjekter som skal kjøre på [basbeta.no](https://basbeta.no), betamiljøet til Bas Kommunikasjon på Hetzner/Coolify.

## Hvorfor dette repoet finnes

Målet er at det skal være raskt å gå fra idé til noe som kjører, uten at Claude (eller andre AI-verktøy) automatisk foreslår amerikanske skytjenester vi allerede har selvhostede alternativer til. Repoet inneholder ingen kode, bare instruksjonene og referansene som gjør at et AI-verktøy starter riktig fra dag én.

## Før du starter (tilganger)

- **Coolify:** du trenger en brukerkonto på basbeta sin Coolify-instans for å faktisk deploye, opprette databaser og sette miljøvariabler. Uten den kan ikke prosjektet komme i produksjon, uansett hvor riktig koden er.
- **GitHub:** enklest hvis repoet ligger i basbeta sin GitHub-organisasjon, da dukker det opp i en dropdown i Coolify. Ligger det andre steder, går det også med en offentlig repo-URL eller et Docker-image.
- **Andre tjenester ved behov:** noen tjenester, som Brevo (e-post) eller Slack (varsler fra Uptime Kuma), krever en egen konto utenfor Coolify. Bare relevant hvis prosjektet faktisk skal bruke dem.

Mangler du noe av dette, ta kontakt med Håvard før du setter i gang, se kontaktinfo nederst. Claude er også satt opp til å sjekke dette med deg tidlig i en ny økt, se `CLAUDE.md`.

## Slik bruker du det

1. Bruk dette repoet som mal ("Use this template" på GitHub), eller kopier innholdet inn i et nytt prosjekt.
2. Bytt ut denne README-en med en som beskriver det faktiske prosjektet.
3. La `CLAUDE.md` ligge i rota. Det er fila som forteller Claude (og andre AI-kodeassistenter som støtter det) hvordan den skal tenke om infrastruktur i dette prosjektet.
4. Push repoet til GitHub og koble det til et Coolify-prosjekt med en gang, før du skriver noe faktisk kode. Repoet har en enkel placeholder-side (`Dockerfile` + `public/index.html`) som er klar til å deployes rett ut av boksen. Er du usikker på hvordan, følg `docs/deploy-i-coolify.md`, en steg-for-steg-guide skrevet for deg som ikke har brukt Coolify før, eller be Claude gå gjennom det sammen med deg. Ser du "Det virker" på domenet Coolify gir deg, vet du at bygging, domene og SSL fungerer, og kan feilsøke pipelinen isolert fra egen kode hvis noe er galt.
5. Begynn å utvikle, og bytt ut placeholder-siden med det faktiske prosjektet etter hvert. Trenger prosjektet database, fillagring, autentisering, e-post, overvåking eller lignende, skal AI-verktøyet sjekke `docs/infrastruktur.md` og foreslå det vi allerede har, før det foreslår noe utenfor Hetzner/Coolify.
6. Fortsett å deploye jevnlig mens du utvikler, ikke bare helt til slutt, så oppdager du raskt om noe i Coolify-oppsettet slutter å fungere.

## Innhold

- `CLAUDE.md`: instruksjoner til AI-assistenten. Viktigst her er regelen om å bruke eksisterende infrastruktur før noe nytt utenfor Hetzner/Coolify.
- `docs/infrastruktur.md`: kortfattet oversikt over hva som kjører på basbeta.no i dag, hva som krever oppsett, og hva som lett kan settes opp ved behov.
- `docs/deploy-i-coolify.md`: steg-for-steg-guide for å koble repoet til Coolify første gang, skrevet for folk som ikke har gjort det før.
- `Dockerfile` og `public/index.html`: en minimal placeholder-side du kan deploye med en gang for å bekrefte at Coolify-oppsettet virker, før du utvikler noe faktisk. Bytt ut begge når prosjektet får en ordentlig stack.
- `.env.example`: mal for miljøvariabler til de vanligste tjenestene (database, S3, e-post, feilsporing, autentisering).
- `.gitignore`: enkel standardoppsett som holder `.env` og vanlige byggemapper unna Git.

## Spørsmål

Ta kontakt med Håvard (haavard.kvinnesland@bas.no) ved spørsmål om infrastrukturen, Coolify-tilgang eller om et prosjekt trenger noe som ikke er dekket her.
