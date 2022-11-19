package taskmanager.backend.services.impl

import com.mongodb.client.model.FindOneAndUpdateOptions
import com.mongodb.client.model.ReturnDocument
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
import java.util.*

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
        val user: User = getById(id)

        return collection
            .findOneAndUpdate(
                filter = User::_id eq id,
                update = set(
                    SetTo(User::email, dto.email ?: user.email),
                    SetTo(User::password, dto.password ?: user.password),
                    SetTo(User::updatedAt, Date())
                ),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun updateInfo(id: ObjectId, dto: UpdateUserInfoDto): User {
        return collection
            .findOneAndUpdate(
                filter = User::_id eq id,
                update = set(
                    SetTo(User::firstName, dto.firstName),
                    SetTo(User::lastName, dto.lastName),
                    SetTo(User::updatedAt, Date())
                ),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun updatePicture(id: ObjectId, picturePath: String?): User {
        return collection
            .findOneAndUpdate(
                filter = User::_id eq id,
                update = set(
                    SetTo(User::picturePath, picturePath),
                    SetTo(User::updatedAt, Date())
                ),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }
}