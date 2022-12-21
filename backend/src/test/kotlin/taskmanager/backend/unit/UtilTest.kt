package taskmanager.backend.unit

import org.junit.Test
import taskmanager.backend.shared.ColorGenerator
import kotlin.test.assertTrue

class UtilTest {

    @Test
    fun `generateHexColor() should correctly generate color`() {
        val allowedSymbols: List<Char> = ('a'..'f') + ('0'..'9')

        val generatedColors: List<String> = (0..100).map {
            ColorGenerator.generateHexColor()
        }

        assertTrue("Generated color should be in HEX format") {
            generatedColors.all { color ->
                val rgbSymbols: String = color.slice(1..6)

                color.length == 7 && color[0] == '#' && rgbSymbols.all { char ->
                    allowedSymbols.contains(char)
                }
            }
        }
    }
}