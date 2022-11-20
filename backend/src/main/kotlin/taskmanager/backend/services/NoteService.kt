package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.NoteDto
import taskmanager.backend.models.Note
import taskmanager.backend.services.base.AttachedToTaskEntityService

interface NoteService : AttachedToTaskEntityService<Note> {
    suspend fun create(userId: ObjectId, taskId: ObjectId, dto: NoteDto): Note
    suspend fun updateById(id: ObjectId, dto: NoteDto): Note
}