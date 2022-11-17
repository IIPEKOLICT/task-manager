package taskmanager.backend.services

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.coroutine.CoroutineDatabase
import org.litote.kmongo.eq
import taskmanager.backend.dtos.CreateUserDto
import taskmanager.backend.dtos.UpdateUserCredentialsDto
import taskmanager.backend.dtos.UpdateUserInfoDto
import taskmanager.backend.models.User
import taskmanager.backend.services.interfaces.IUserService

class UserService(database: CoroutineDatabase) : IUserService {

    private val collection: CoroutineCollection<User> = database.getCollection("users")

    override suspend fun getAll(): List<User> {
        return collection.find().toList()
    }

    override suspend fun getById(id: String): User {
        return collection.findOneById(ObjectId(id)) ?: throw RuntimeException("Not found")
    }

    override suspend fun getByEmailOrNull(email: String): User? {
        return collection.findOne(User::email eq email)
    }

    override suspend fun create(dto: CreateUserDto): User {
        val user = User(
            email = dto.email,
            password = dto.password,
            firstName = dto.firstName,
            lastName = dto.lastName
        )

        collection.save(user.hashPassword())
        return user
    }

    override suspend fun updateCredentials(id: String, dto: UpdateUserCredentialsDto): User {
        TODO("Not yet implemented")
    }

    override suspend fun updateInfo(id: String, dto: UpdateUserInfoDto): User {
        TODO("Not yet implemented")
    }

    override suspend fun deleteById(id: String): String {
        return collection.findOneAndDelete(User::_id eq ObjectId(id))?._id?.toString()
            ?: throw RuntimeException()
    }
}