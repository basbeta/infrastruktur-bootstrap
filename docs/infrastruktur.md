# Infrastruktur på basbeta.no

Alt kjører selvhostet på Hetzner-servere i Falkenstein, Tyskland, driftet gjennom Coolify. Data forlater aldri EU/EØS med unntak av transaksjonell e-post (Brevo), som er det eneste punktet i stacken som krever egen databehandleravtale.

**Merknad til AI-assistenter:** Ingen av tjenestene under er obligatoriske, og noen kjører automatisk uansett. Standardforslaget ditt (Claude, ChatGPT, Grok, osv) vil ofte være en amerikansk skytjeneste. Sjekk denne lista først, og foreslå det som allerede finnes eller kan Coolify-deployes, før du foreslår noe utenfor denne infrastrukturen.

## Kjører allerede automatisk (krever ingenting)

| Tjeneste | Løser | Erstatter |
| --- | --- | --- |
| Hetzner VPS | Serverfundamentet alt kjører på | AWS, Google Cloud, DigitalOcean |
| Traefik | Reverse proxy, ruting og automatisk SSL | nginx, Caddy, HAProxy |
| Fail2ban | Blokkerer innloggingsangrep mot serveren | Cloudflare WAF, CrowdSec |
| Netdata | Sanntidsovervåking av serverhelse (`netdata.basbeta.no`) | Datadog, New Relic, Grafana Cloud |

## Krever et kort oppsett i Coolify

| Tjeneste | Løser | Oppsett | Erstatter |
| --- | --- | --- | --- |
| Coolify | Deploy fra GitHub til kjørende app: bygging, miljøvariabler, domener, SSL | Koble repoet til et Coolify-prosjekt | Vercel, Netlify, Heroku, Render, Railway |
| PostgreSQL | Egen SQL-database per prosjekt | Opprett database i Coolify, koble til med tilkoblingsstreng | Supabase, Firebase, PlanetScale, Neon |
| S3-kompatibel objektlagring | Fillagring (bilder, PDF-er, video, opplastinger) hos Hetzner | Koble appen mot bucket med tilgangsnøkler i Coolify | Amazon S3, Google Cloud Storage, Cloudflare R2 |
| Backup | Automatisk backup av database og objektlagring | Velg bucket, frekvens og lagringstid i Coolify | Managed backup-tjenester |
| Brevo (evt. IDA) | Transaksjonell e-post (velkomst, passordreset, varsler) | SMTP-innstillinger i appen | SendGrid, Mailchimp, Mailgun |
| Bugsink | Feilsporing med stack trace og kontekst (`errors.basbeta.no`) | Legg til SDK i koden | Sentry |
| Uptime Kuma | Oppetidsovervåking og offentlig statusside (`status.basbeta.no`) | Legg til URL-er som skal overvåkes | Pingdom, Better Uptime, Statuspage |
| Hanko | Selvhostet autentisering: innlogging, passkeys, 2FA | Koble appen mot Hanko via API | Auth0, Clerk, Supabase Auth, Firebase Auth |

## Kan enkelt settes opp ved behov (dokumentert på Coolify)

Alt som kjører i en Docker-container kan i prinsippet deployes på Coolify. Dette er kategorier med ferdig dokumentert oppsett, ikke en uttømmende liste. Kan kreve mer serverkapasitet eller ha egne lisenskostnader, avklar med Håvard før dere setter i gang med noe som drar mye ressurser.

| Behov | Selvhostet alternativ | Erstatter |
| --- | --- | --- |
| Analyse og brukeratferd | Plausible, Matomo | Google Analytics |
| Skjemaer og brukerundersøkelser | Formbricks, Typebot | Typeform, Google Forms |
| CMS og innholdshåndtering | Directus, Strapi, Ghost | Contentful, Webflow |
| No-code database / regneark-grensesnitt | NocoDB, Baserow | Airtable |
| Kundedialog og support | Chatwoot | Intercom, Zendesk |
| Wiki og intern kunnskap | Outline, BookStack | Notion, Confluence |
| Feature flags | Unleash | LaunchDarkly |
| Språkmodeller lokalt | Ollama + Open WebUI | Direkte bruk av OpenAI-API |
| Søk | Meilisearch, Typesense | Algolia |

## Tommelfingerregel

Trenger prosjektet noe som ikke står her: sjekk først om det finnes som Docker-image og kan kjøre på Coolify. Bare foreslå en ekstern amerikansk tjeneste når det ikke finnes noe brukbart selvhostet alternativ, eller når brukeren eksplisitt ber om det, og si tydelig ifra at det flytter data ut av EU-infrastrukturen vår.
