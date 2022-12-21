package taskmanager.backend.unit

import org.junit.Test
import org.koin.core.context.startKoin
import org.koin.core.context.stopKoin
import org.koin.test.KoinTest
import taskmanager.backend.dtos.response.UserResponseDto
import taskmanager.backend.models.User
import taskmanager.backend.shared.Utils
import kotlin.test.assertEquals
import kotlin.test.assertNotEquals
import kotlin.test.assertTrue

class UserTest : KoinTest {

    private val mockedUser = User(
        email = "test@mail.ru",
        password = "12345",
        firstName = "Test",
        lastName = "User"
    )

    @Test
    fun `getProfilePicturePath() should correctly generate picture path`() {
        val generatedPath: String = mockedUser.getProfilePicturePath()

        assertEquals("/users/pictures/${mockedUser._id}.png", generatedPath)
    }

    @Test
    fun `hashPassword() should correctly hash password`() {
        startKoin {
            modules(Utils.koinTestModule)
        }

        val user: User = mockedUser.copy().hashPassword()

        assertTrue {
            user.comparePassword(mockedUser.password)
        }

        assertNotEquals(mockedUser.password, user.password)

        stopKoin()
    }

    @Test
    fun `comparePassword() should correctly compare passwords`() {
        startKoin {
            modules(Utils.koinTestModule)
        }

        val user: User = mockedUser.copy().hashPassword()

        val correct: Boolean = user.comparePassword(mockedUser.password)
        val incorrect: Boolean = user.comparePassword("42")

        assertEquals(true, correct)
        assertEquals(false, incorrect)

        stopKoin()
    }

    @Test
    fun `toResponseDto() should work correctly`() {
        startKoin {
            modules(Utils.koinTestModule)
        }

        val user: UserResponseDto = mockedUser.toResponseDto()

        assertEquals(mockedUser._id.toString(), user._id)
        assertEquals(mockedUser.email, user.email)
        assertEquals(mockedUser.firstName, user.firstName)
        assertEquals(mockedUser.lastName, user.lastName)
        assertEquals(null, user.profilePicture)

        stopKoin()
    }
}