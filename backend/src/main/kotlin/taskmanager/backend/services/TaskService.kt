package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.CreateTaskDto
import taskmanager.backend.dtos.request.UpdateTaskInfoDto
import taskmanager.backend.enums.Priority
import taskmanager.backend.enums.Status
import taskmanager.backend.models.Task
import taskmanager.backend.services.base.CreatedByUserEntityService

interface TaskService : CreatedByUserEntityService<Task> {
    suspend fun getAll(): List<Task>
    suspend fun getByProject(projectId: ObjectId): List<Task>
    suspend fun getById(id: ObjectId): Task
    suspend fun create(userId: ObjectId, projectId: ObjectId, dto: CreateTaskDto): Task
    suspend fun updateInfo(id: ObjectId, dto: UpdateTaskInfoDto): Task
    suspend fun updateStatus(id: ObjectId, status: Status): Task
    suspend fun updatePriority(id: ObjectId, priority: Priority): Task
    suspend fun updateBlockedBy(id: ObjectId, blockedBy: List<ObjectId>): Task
    suspend fun updateTags(id: ObjectId, tags: List<ObjectId>): Task
    suspend fun addWork(id: ObjectId, workId: ObjectId)
    suspend fun addComment(id: ObjectId, commentId: ObjectId)
    suspend fun addNote(id: ObjectId, noteId: ObjectId)
    suspend fun addAttachment(id: ObjectId, attachmentId: ObjectId)
    suspend fun removeWork(id: ObjectId, workId: ObjectId)
    suspend fun removeComment(id: ObjectId, commentId: ObjectId)
    suspend fun removeNote(id: ObjectId, noteId: ObjectId)
    suspend fun removeAttachment(id: ObjectId, attachmentId: ObjectId)
    suspend fun deleteById(id: ObjectId): String
    suspend fun deleteByProject(projectId: ObjectId)
}