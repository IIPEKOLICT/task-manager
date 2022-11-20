package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.CreateUserDto
import taskmanager.backend.dtos.request.UpdateUserCredentialsDto
import taskmanager.backend.dtos.request.UpdateUserInfoDto
import taskmanager.backend.models.User
import taskmanager.backend.services.base.BaseService

interface UserService : BaseService<User> {
    suspend fun getByEmailOrNull(email: String): User?
    suspend fun create(dto: CreateUserDto): User
    suspend fun updateCredentials(id: ObjectId, dto: UpdateUserCredentialsDto): User
    suspend fun updateInfo(id: ObjectId, dto: UpdateUserInfoDto): User
    suspend fun updatePicture(id: ObjectId, picturePath: String?): User
}