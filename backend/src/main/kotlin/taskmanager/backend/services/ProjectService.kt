package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.CreateProjectDto
import taskmanager.backend.models.Project
import taskmanager.backend.services.base.CreatedByUserEntityService

interface ProjectService : CreatedByUserEntityService<Project> {
    suspend fun getAll(): List<Project>
    suspend fun getByUser(userId: ObjectId): List<Project>
    suspend fun getById(id: ObjectId): Project
    suspend fun create(userId: ObjectId, dto: CreateProjectDto): Project
    suspend fun updateName(id: ObjectId, name: String): Project
    suspend fun updateMembers(id: ObjectId, members: List<ObjectId>): Project
    suspend fun deleteById(id: ObjectId): String
    suspend fun deleteByUser(userId: ObjectId)
}