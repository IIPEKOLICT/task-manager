package taskmanager.backend.mappers

import org.bson.types.ObjectId
import taskmanager.backend.dtos.response.NoteResponseDto
import taskmanager.backend.models.*
import taskmanager.backend.services.UserService

class NoteMapper(private val userService: UserService) {

    suspend fun convert(userId: ObjectId, notes: List<Note>): List<NoteResponseDto> {
        val createdByUsers: List<User> = userService.getByIds(notes.map { it.createdBy })

        return notes.map { note ->
            note.toResponseDto(
                userId = userId,
                createdBy = createdByUsers.find {
                    it._id.toString() == note.createdBy.toString()
                }
            )
        }
    }

    suspend fun convert(userId: ObjectId, note: Note): NoteResponseDto {
        return convert(userId, listOf(note))[0]
    }
}