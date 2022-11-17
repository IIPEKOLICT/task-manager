package taskmanager.backend.models

import at.favre.lib.crypto.bcrypt.BCrypt
import org.bson.codecs.pojo.annotations.BsonId
import org.bson.types.ObjectId
import org.koin.java.KoinJavaComponent.inject
import taskmanager.backend.models.base.BaseEntity
import taskmanager.backend.shared.Configuration

data class User(
    @BsonId val _id: ObjectId = ObjectId(),
    val projects: Set<ObjectId> = emptySet(),

    var email: String,
    var password: String,
    var firstName: String,
    var lastName: String,
    var picturePath: String? = null
) : BaseEntity<User>() {

    fun hashPassword(): User {
        password = BCrypt
            .withDefaults()
            .hashToString(configuration.bcryptStrength, password.toCharArray())

        return this
    }

    fun comparePassword(checkedPassword: String): Boolean {
        return BCrypt.verifyer().verify(checkedPassword.toCharArray(), password).verified
    }

    companion object {

        private val configuration by inject<Configuration>(Configuration::class.java)
    }
}