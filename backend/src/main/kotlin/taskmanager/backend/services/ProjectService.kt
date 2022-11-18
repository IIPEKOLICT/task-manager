package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.CreateProjectDto
import taskmanager.backend.models.Project

interface ProjectService {
    suspend fun getAll(): List<Project>
    suspend fun getByUser(userId: ObjectId): List<Project>
    suspend fun getById(id: String): Project
    suspend fun isOwner(id: String, userId: ObjectId): Boolean
    suspend fun create(userId: ObjectId, dto: CreateProjectDto): Project
    suspend fun updateName(id: String, name: String): Project
    suspend fun updateMembers(id: String, members: List<ObjectId>): Project
    suspend fun deleteById(id: String): String
    suspend fun deleteByUser(userId: ObjectId)
}