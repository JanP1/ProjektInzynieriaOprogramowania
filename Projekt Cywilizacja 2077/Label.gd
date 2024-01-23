extends Label

var text_to_display := "		Witaj w grze Cywilizacja 2077! Przygotuj się na ekscytujące wyzwania, strategiczne decyzje i zdobywanie potęgi 
w tym świecie pełnym intryg i bitew.
1. Wybór postaci, każda ma umiejętności na różnym stopniu rozwoju
2. Budujemy nasze miasto 
	-Przechowuj swoje pieniądze w Banku
	-Zarabiaj pieniądze w Kasynie. 
	-Ulepszaj swoje jednostki wojskowe w laboratorium.
	-Produkuj swoje roboty-żołnierzy w koszarach.
3. Mapa
	Odkrywaj pobliskie obszary, Szukaj potencjalnych celów do atakowania lub bronienia. 
4. Bitwy
-Atakuj Przeciwników:
		Wybierz cel i przygotuj swoją armię do ataku.
-Obrona:
Bądź gotów na ataki przeciwników. Wzmocnij swoje budynki, aby utrzymać swoje terytorium."
	
var current_index := 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	text = ""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_index < text_to_display.length():
		text += text_to_display[current_index]
		current_index += 1
	else:
		set_process(false)  
	# Zatrzymaj proces po zakończeniu animacji
