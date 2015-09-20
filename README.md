# Exchange

## Wstęp

Repozytorium aplikacji internetowej Exchange, zarządzającej wymianami terminów zajęć.

## Dokumentacja

* [Wizja](https://raw.githubusercontent.com/bzurkowski/exchange/master/docs/wizja.pdf)
* [Koncepcja](https://raw.githubusercontent.com/bzurkowski/exchange/master/docs/koncepcja.pdf)
* [Techniczna](https://raw.githubusercontent.com/bzurkowski/exchange/master/docs/techniczna.pdf)
* [Procesowa](https://raw.githubusercontent.com/bzurkowski/exchange/master/docs/procesowa.pdf)
* [Użytkownika](https://raw.githubusercontent.com/bzurkowski/exchange/master/docs/uzytkownika.pdf)
* [Deweloperska](https://raw.githubusercontent.com/bzurkowski/exchange/master/docs/developerska.pdf)
* [Instalacji](https://raw.githubusercontent.com/bzurkowski/exchange/master/docs/instalacji.pdf)

## Manifest

    * app/             - główny kod aplikacji
    * app/admin/       - definicje stron w panelu administratorskim
    * app/assets/      - zasoby aplikacji, skrypty i style
    * app/controllers/ - kontrolery (jak w MVC)
    * app/decorators/  - dekoratory - klasy odpowiedzialne za prezentację zasobów
    * app/helpers/     - zbiór różnych pomocniczych metod
    * app/jobs/        - klasy reprezentujące zadania wykonywane asynchronicznie
    * app/mailers/     - kontrolery dla wysyłki maili
    * app/models/      - modele (jak w MVC)
    * app/services/    - serwisy - klasy modyfikujące dane w systemie
    * app/validators/  - klasy definiujące i gwarantujące poprawność danych w systemie
    * app/views/       - widoki (jak w MVC)
    * bin/             - skrypty wykonujące rożne zadania powiązane z developmentem (uruchomienie testów, serwera)
    * config/          - konfiguracja aplikacji Rails
    * db/              - pliki opisujące bazę danych
    * docs/            - dokumentacja
    * lib/             - zbiór zasobów i kodu niezwiązanego bezpośrednio z zadaniem wykonywanym przez aplikację
    * log/             - pusty folder (trzymane są tu logi, gdy aplikacja jest uruchomiona; nie są one trzymane w repozytorium)
    * public/          - folder z plikami statycznymi
    * spec/            - testy automatyczne aplikacji


