package taskmanager.backend.services.impl

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.set
import org.litote.kmongo.setTo
import taskmanager.backend.dtos.request.NoteDto
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.Note
import taskmanager.backend.services.NoteService
import taskmanager.backend.services.base.impl.AttachedToTaskEntityServiceImpl

class NoteServiceImpl(
    override val collection: CoroutineCollection<Note>
) : AttachedToTaskEntityServiceImpl<Note>(collection, CollectionInfo.NOTE), NoteService {

    override suspend fun create(userId: ObjectId, taskId: ObjectId, dto: NoteDto): Note {
        val note = Note(
            createdBy = userId,
            task = taskId,
            header = dto.header,
            text = dto.text
        )

        collection.save(note)
        return note
    }

    override suspend fun updateById(id: ObjectId, dto: NoteDto): Note {
        return updateById(
            id,
            set(
                Note::header setTo dto.header,
                Note::text setTo dto.text
            )
        )
    }
}