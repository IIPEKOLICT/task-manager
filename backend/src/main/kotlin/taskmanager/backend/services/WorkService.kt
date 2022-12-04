package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.WorkDto
import taskmanager.backend.models.Work
import taskmanager.backend.services.base.AttachedToTaskEntityService

interface WorkService : AttachedToTaskEntityService<Work> {
    suspend fun getByIds(ids: List<ObjectId>): List<Work>
    suspend fun create(userId: ObjectId, taskId: ObjectId, dto: WorkDto): Work
    suspend fun updateById(id: ObjectId, dto: WorkDto): Work
}