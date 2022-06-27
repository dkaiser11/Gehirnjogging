program project1;

uses
  sysutils, Crt;

var
  Korrekt: boolean;
  SpielerAnzahl, AufgabenAnzahl, Spieler, PunkteAktuell, Aufgabe, Rechenart, Zahl1, Zahl2, Eingabe: integer;
  Aufgabenstellung: string;
  Punkte: array of integer;

begin
  Writeln('Geben Sie die Anzahl der Spieler an: ');
  Readln(SpielerAnzahl);

  SetLength(Punkte, Spieleranzahl);

  Writeln();

  Writeln('Geben Sie die Anzahl an Aufgaben pro Spieler an: ');
  Readln(AufgabenAnzahl);

  Randomize();

  for Spieler := 1 to Spieleranzahl do
  begin
    // Initialisiere PunkteAktuell mit Null
    PunkteAktuell := 0;

    ClrScr();

    Writeln('Spieler', Spieler, ' du bist dran! ');   
    Writeln('Was sind die richtigen Lösungen? ');
    Writeln();

    for Aufgabe := 1 to Aufgabenanzahl do
    begin
      // Bestimme Rechenart
      Rechenart := Random(4);

      // Bestimme Zahlen für Rechenart passend
      case Rechenart of
        // Addition
        0:
        begin
          Zahl1 := Random(99) + 1;
          Zahl2 := Random(99) + 1;

          Aufgabenstellung := ' + ';
        end;
                
        // Subtraktion
        1:
        begin
          Zahl1 := Random(99) + 1;
          Zahl2 := Zahl1 - Random(Zahl1 - 1) + 1;

          Aufgabenstellung := ' - ';
        end;
             
        // Multiplikation
        2:
        begin
          Zahl1 := Random(50) + 1;
          Zahl1 := Random(50) + 1;

          Aufgabenstellung := ' * ';
        end;


        // Division
        3:
        begin
          Zahl2 := Random(25) + 1;
          Zahl1 := (Random(25) + 1) * Zahl2;

          Aufgabenstellung := ' : ';
        end;
      end;

      Aufgabenstellung := IntToStr(Zahl1) + Aufgabenstellung + IntToStr(Zahl2) + ' = ';

      Writeln(Aufgabenstellung);

      Readln(Eingabe);

      Case Rechenart of
        0: Korrekt := Zahl1 + Zahl2 = Eingabe;
        1: Korrekt := Zahl1 - Zahl2 = Eingabe;
        2: Korrekt := Zahl1 * Zahl2 = Eingabe;
        3: Korrekt := Zahl1 / Zahl2 = Eingabe;
      end;

      if Korrekt then
      begin
        PunkteAktuell := PunkteAktuell + 1;

        Writeln('Korrekt! Du hast ', PunkteAktuell, ' Punkte. ');
      end
      else
        Writeln('Das ist leider falsch! Du hast ', PunkteAktuell, ' Punkte. ');
    end;

    // Weise dem Spieler, der dran ist, die Punkte zu
    Punkte[Spieler - 1] := PunkteAktuell;

    Readln();
  end;

  ClrScr();

  Writeln('Spieler - Punkte');
  Writeln('----------------');

  for Spieler := 1 to SpielerAnzahl do
    Writeln(Spieler:7, ' - ', Punkte[Spieler - 1]);

  Readln();
end.
