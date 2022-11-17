package taskmanager.backend.services.interfaces

import taskmanager.backend.dtos.CreateUserDto
import taskmanager.backend.dtos.UpdateUserCredentialsDto
import taskmanager.backend.dtos.UpdateUserInfoDto
import taskmanager.backend.models.User

interface IUserService {
    suspend fun getAll(): List<User>
    suspend fun getById(id: String): User
    suspend fun getByEmailOrNull(email: String): User?
    suspend fun create(dto: CreateUserDto): User
    suspend fun updateCredentials(id: String, dto: UpdateUserCredentialsDto): User
    suspend fun updateInfo(id: String, dto: UpdateUserInfoDto): User
    suspend fun deleteById(id: String): String
}