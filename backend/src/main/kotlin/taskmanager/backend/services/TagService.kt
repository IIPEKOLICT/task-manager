package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.models.Tag

interface TagService {
    suspend fun getAll(): List<Tag>
    suspend fun getByProject(projectId: String): List<Tag>
    suspend fun getById(id: String): Tag
    suspend fun isOwner(id: String, userId: ObjectId): Boolean
    suspend fun create(userId: ObjectId, projectId: ObjectId, name: String): Tag
    suspend fun updateById(id: String, name: String): Tag
    suspend fun deleteById(id: String): String
    suspend fun deleteByProject(projectId: String)
}