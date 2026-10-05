# Innlogging med e-post og engangskode

Erfaringer fra `sider` (Next.js + Prisma). Bruk dette når appen trenger "skriv e-post, få kode, logg inn" uten passord. Referanseimplementasjon: `lib/otp.ts`, `lib/session.ts`, `lib/rate-limit.ts`, `app/api/login/{start,verify}/route.ts` i sider-repoet.

## Anbefaling: bygg det selv, ikke bruk Hanko til dette

Hanko (`auth.basbeta.no`) ble prøvd først og droppet. Funnene, verifisert mot Hanko v3.1.0:

- **Login oppretter ikke bruker.** Ukjent e-post i `/login`-flyten gir en e-post med «konto finnes ikke», ikke en kode. Appen må først sjekke om brukeren finnes og velge `/registration` eller `/login`.
- **Registrering krever passord** som standard (`PASSWORD_ENABLED=false` på Hanko-tjenesten fjerner det).
- **Admin-API er bare nåbart internt** i Coolify-nettverket, så appen må kobles til samme nettverk.
- **Flow API er dårlig dokumentert.** Felt må pakkes i `input_data`, ellers får du en villedende `value_missing_error`.
- Image-taggen er `:latest`. Pin til en versjon hvis Hanko brukes.

Hanko passer fortsatt hvis dere trenger passkeys eller 2FA. For ren e-postkode er egen løsning ca. 150 linjer, og den bruker bare Postgres og Brevo som allerede finnes.

## Oppskrift

**Tabell** (`OtpCode`): `id`, `email`, `codeHash`, `expiresAt`, `attempts` (default 0), `usedAt` (nullable), `createdAt`, indeks på `email`.

**Start** (`POST /api/login/start`), i denne rekkefølgen:
1. Normaliser e-post (trim + lowercase) og valider formatet.
2. Sjekk at e-posten *har lov* til å logge inn, før du sender noe. Ellers kan appen brukes til å sende e-post til hvem som helst.
3. Rate limit per e-post (5/time) og per IP (20/time). IP fra `x-forwarded-for`, første verdi (Traefik setter den).
4. Lag koden med `crypto.randomInt` (aldri `Math.random`), lagre **bcrypt-hash**, aldri klartekst. Gyldighet 10 min.
5. Send via Brevo SMTP (nodemailer, 10 s timeout). Feiler sending, svar 500 med en vanlig feilmelding.

**Verify** (`POST /api/login/verify`):
1. Finn siste kode for e-posten der `usedAt` er null og `expiresAt` er i fremtiden.
2. Maks 5 forsøk per kode. Tell opp `attempts` ved feil og sett `usedAt` når forsøkene er brukt opp.
3. Riktig kode: sett `usedAt` (koden kan ikke brukes to ganger), start sesjon.
4. Bruk samme feilmelding for «feil kode» og «utløpt kode».

**Sesjon:** `iron-session` med `httpOnly`, `secure` i produksjon og `sameSite: lax`. Hemmelighet i `SESSION_SECRET` (minst 32 tegn).

## Fallgruver vi traff

- **iron-session setter cookie-`maxAge` til `ttl - 60`.** Legg på 60 sekunder i `ttl` hvis cookien skal vare nøyaktig like lenge som du mener.
- **Lagre egen `expiresAt` i sesjonen og sjekk den på hver forespørsel.** Cookie-levetid alene er ikke en sikker utløpsgrense. Utløpt sesjon skal se ut som utlogget overalt.
- **Ulik sesjonslengde per brukertype er enkelt** når utløpet settes ved innlogging (sider: 10 t for bas.no, 2 t for kunder).
- **Tilgangsregler skal sjekkes på hver forespørsel** mot gjeldende regler, ikke caches i sesjonen. Da virker endringer med en gang for de som allerede er innlogget.
- **Rate limiting i minnet er nok** for én instans i beta, men nullstilles ved restart/deploy. Trenger du mer, bruk Redis (finnes i Coolify).
- **Gamle koder slettes ikke av seg selv.** Legg til en timejobb som sletter `OtpCode` som er utløpt eller brukt (sider har en slik jobb for sider, men ikke for koder ennå).
- **Test utløp uten å vente.** Sider brukte midlertidig en testknapp og kortere intervall. Fjern den igjen før commit.
- **Ikke lekk om en konto finnes.** Svar likt uansett, med mindre appen bevisst skal si «ingen tilgang» (som sider gjør, fordi tilgang styres av domeneliste).

## Miljøvariabler

`DATABASE_URL`, `SESSION_SECRET`, `SMTP_*` (Brevo). Se `.env.example`.
