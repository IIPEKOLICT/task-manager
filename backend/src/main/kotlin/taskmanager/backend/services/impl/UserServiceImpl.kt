package taskmanager.backend.services.impl

import org.bson.types.ObjectId
import org.litote.kmongo.*
import org.litote.kmongo.coroutine.CoroutineCollection
import taskmanager.backend.dtos.request.CreateUserDto
import taskmanager.backend.dtos.request.UpdateUserCredentialsDto
import taskmanager.backend.dtos.request.UpdateUserInfoDto
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.User
import taskmanager.backend.services.UserService
import taskmanager.backend.services.base.impl.BaseServiceImpl

class UserServiceImpl(
    override val collection: CoroutineCollection<User>
) : BaseServiceImpl<User>(collection, CollectionInfo.USER), UserService {

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

    override suspend fun updateCredentials(id: ObjectId, dto: UpdateUserCredentialsDto): User {
        val update: MutableList<SetTo<*>> = mutableListOf()

        if (dto.email != null) {
            update.add(User::email setTo dto.email)
        }

        if (dto.password != null) {
            update.add(User::email setTo User.hashPassword(dto.password))
        }

        return updateById(id, set(*update.toTypedArray()))
    }

    override suspend fun updateInfo(id: ObjectId, dto: UpdateUserInfoDto): User {
        return updateById(
            id,
            set(
                User::firstName setTo dto.firstName,
                User::lastName setTo dto.lastName
            )
        )
    }

    override suspend fun updatePicture(id: ObjectId, picturePath: String?): User {
        return updateById(id, setValue(User::picturePath, picturePath))
    }
}