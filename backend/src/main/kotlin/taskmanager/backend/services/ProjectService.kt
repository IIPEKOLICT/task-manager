package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.ProjectDto
import taskmanager.backend.models.Project
import taskmanager.backend.services.base.CreatedByUserEntityService

interface ProjectService : CreatedByUserEntityService<Project> {
    suspend fun getByUser(userId: ObjectId): List<Project>
    suspend fun create(userId: ObjectId, dto: ProjectDto): Project
    suspend fun updateById(id: ObjectId, dto: ProjectDto): Project
}