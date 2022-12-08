package taskmanager.backend.mappers

import org.bson.types.ObjectId
import taskmanager.backend.dtos.response.CommentResponseDto
import taskmanager.backend.models.*
import taskmanager.backend.services.UserService

class CommentMapper(private val userService: UserService) {

    suspend fun convert(userId: ObjectId, comments: List<Comment>): List<CommentResponseDto> {
        val createdByUsers: List<User> = userService.getByIds(comments.map { it.createdBy })

        return comments.map { comment ->
            comment.toResponseDto(
                userId = userId,
                createdBy = createdByUsers.find {
                    it._id.toString() == comment.createdBy.toString()
                }
            )
        }
    }

    suspend fun convert(userId: ObjectId, comment: Comment): CommentResponseDto {
        return convert(userId, listOf(comment))[0]
    }
}