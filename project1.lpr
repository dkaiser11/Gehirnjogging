program project1;

uses sysutils, Crt, math;

var
  Korrekt: boolean;
  SpielerAnzahl, AufgabenAnzahl, Spieler, PunkteAktuell, Aufgabe, Rechenart, Zahl1, Zahl2, Eingabe, HoechstePunkte, Schwierigkeit, Bereich1, Bereich2, Bereich3: integer;
  Aufgabenstellung, GewinnerText, Nochmal: string;
  Punkte: array of integer;
  Gewinner: array of boolean;

begin
  try
    repeat
    // - Begrüßung und Setup -

    ClrScr();

    WriteLn(UTF8Decode('┌────────────────────────────────────────────────────┐'));
    WriteLn(UTF8Decode('│ Willkommen beim Gehirnjogging!                     │'));
    WriteLn(UTF8Decode('│                                                    │'));
    WriteLn(UTF8Decode('│ Hier können sie alleine oder mit mehreren Spielern │'));
    WriteLn(UTF8Decode('│ ihre Kopfrechenfähigkeiten verbessern.             │'));
    WriteLn(UTF8Decode('│                                                    │'));
    WriteLn(UTF8Decode('│ Wenn Sie das Programm schließen wollen, geben Sie  │'));
    WriteLn(UTF8Decode('│ etwas ein, dass keine Zahl ist.                    │'));
    WriteLn(UTF8Decode('└────────────────────────────────────────────────────┘'));

    Writeln();

    Writeln('Geben Sie die Anzahl der Spieler an: ');
    Readln(SpielerAnzahl);

    SetLength(Punkte, Spieleranzahl);
    SetLength(Gewinner, Spieleranzahl);

    Writeln();

    Writeln('Geben Sie die Anzahl an Aufgaben pro Spieler an: ');
    Readln(AufgabenAnzahl);

    Writeln();

    Writeln('Geben Sie den Schwierigkeitsgrad an (1/2/3): ');
    Readln(Schwierigkeit);


    // Lege Zahlenbereiche nach Schwierigkeit fest
    // Bereich1 Addition, Subtraktion
    // Bereich2 Multiplikation, Dividend
    // Bereich3 Divisor
    case Schwierigkeit of
      1:
      begin
        Bereich1 := 10;
        Bereich2 := 10;
        Bereich3 := 5;
      end;
      2:
      begin
        Bereich1 := 100;
        Bereich2 := 20;
        Bereich3 := 10;
      end;
      3:
      begin
        Bereich1 := 100;
        Bereich2 := 50;
        Bereich3 := 25;
      end;
    end;

    Randomize();

    for Spieler := 1 to Spieleranzahl do
    begin

      // - Aufgaben -

      ClrScr();

      // Initialisiere PunkteAktuell mit Null
      PunkteAktuell := 0;

      Writeln('Spieler ', Spieler, ' du bist dran! ');
      Writeln(UTF8Decode('Was sind die richtigen Lösungen? '));
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
            Zahl1 := Random(Bereich1) + 1;
            Zahl2 := Random(Bereich1) + 1;

            Aufgabenstellung := ' + ';
          end;

          // Subtraktion
          1:
          begin
            Zahl1 := Random(Bereich1) + 1;
            Zahl2 := Random(Zahl1 - 1) + 1;

            Aufgabenstellung := ' - ';
          end;

          // Multiplikation
          2:
          begin
            Zahl1 := Random(Bereich2) + 1;
            Zahl2 := Random(Bereich2) + 1;

            Aufgabenstellung := ' * ';
          end;


          // Division
          3:
          begin
            Zahl2 := Random(Bereich2) + 1;
            Zahl1 := (Random(Bereich3) + 1) * Zahl2;

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

      Writeln();

      Writeln(UTF8Decode('Zum Weitergehen Enter drücken '));

      Readln();
    end;

    // - Scoreboard -

    ClrScr();

    HoechstePunkte := MaxIntValue(Punkte);

    Writeln('Spieler - Punkte');
    Writeln('----------------');

    for Spieler := 1 to SpielerAnzahl do
    begin
      Writeln(Spieler:7, ' - ', Punkte[Spieler - 1]:6);
      Gewinner[Spieler - 1] := Punkte[Spieler - 1] = HoechstePunkte;
    end;

    Writeln();

    // - Gewinner gratulieren -

    GewinnerText := UTF8Decode('Herzlichen Glückwunsch Spieler ');

    for Spieler := 1 to SpielerAnzahl do
      if Gewinner[Spieler - 1] then
        GewinnerText := GewinnerText + IntToStr(Spieler) + ', ';

    GewinnerText := GewinnerText + 'Sie haben gewonnen! ';

    Writeln(Gewinnertext);

    Writeln();

    Writeln(UTF8Decode('Drücken Sie Enter zum nochmal Spielen. '));


    Readln(Nochmal);

    until Nochmal <> '';
  except
    Exit();
  end;
end.

