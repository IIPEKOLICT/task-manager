package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.WorkDto
import taskmanager.backend.models.Work
import taskmanager.backend.services.base.CreatedByUserEntityService

interface WorkService : CreatedByUserEntityService<Work> {
    suspend fun getByTask(taskId: ObjectId): List<Work>
    suspend fun create(userId: ObjectId, taskId: ObjectId, dto: WorkDto): Work
    suspend fun updateById(id: ObjectId, dto: WorkDto): Work
    suspend fun deleteByTask(taskId: ObjectId)
}