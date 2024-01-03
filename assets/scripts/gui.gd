extends CanvasLayer

func _process(delta):
	%Credits.text = "Credits: " + str(GLOBAL.credits)
	%Score.text = "Score: " + str(GLOBAL.score)
