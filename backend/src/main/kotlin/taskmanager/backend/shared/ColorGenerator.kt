package taskmanager.backend.shared

object ColorGenerator {

    fun generateHexColor(): String {
        val allowedChars: List<Char> = ('a'..'f') + ('0'..'9')
        val hex = (1..6).map { allowedChars.random() }.joinToString("")
        return "#$hex"
    }
}