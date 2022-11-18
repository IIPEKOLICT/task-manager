package taskmanager.backend.services

import taskmanager.backend.dtos.request.CreateUserDto
import taskmanager.backend.dtos.request.UpdateUserCredentialsDto
import taskmanager.backend.dtos.request.UpdateUserInfoDto
import taskmanager.backend.models.User

interface UserService {
    suspend fun getAll(): List<User>
    suspend fun getById(id: String): User
    suspend fun getByEmailOrNull(email: String): User?
    suspend fun create(dto: CreateUserDto): User
    suspend fun updateCredentials(id: String, dto: UpdateUserCredentialsDto): User
    suspend fun updateInfo(id: String, dto: UpdateUserInfoDto): User
    suspend fun updatePicture(id: String, picturePath: String?): User
    suspend fun deleteById(id: String): String
}